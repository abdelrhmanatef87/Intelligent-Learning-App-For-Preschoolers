import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:intelligent_learning/backend/linkapi.dart';
import 'package:intelligent_learning/backend/crud.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:http/io_client.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ObjectDetection extends StatefulWidget {
  @override
  _ObjectDetectionState createState() => _ObjectDetectionState();
}

class _ObjectDetectionState extends State<ObjectDetection> {
  File? _image;
  bool _busy = false;
  String recognize = '';
  List<dynamic> label = [];
  List images = [];
  Crud _crud = Crud();
  late SharedPreferences sharedPref;
  CollectionReference imagesref = FirebaseFirestore.instance.collection("images");
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  selectFromImagePicker(source) async {
    setState(() {
      _image = null;
    });
    var image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    setState(() {
      _busy = true;
    });
    getImageFromAPI(image);
  }

  Future<void> getImageFromAPI(XFile image) async {
    final box1 = await Hive.openBox('my_box');
    final value = box1.get('my_key');
    final ioClient = IOClient(
      HttpClient()
        ..badCertificateCallback = ((X509Certificate cert, String host, int port) => true),
    );

    String urlLabel = '$value/label';
    var requestLabel = http.MultipartRequest('POST', Uri.parse(urlLabel));
    requestLabel.files.add(await http.MultipartFile.fromPath('image', image.path));
    var responseLabel = await ioClient.send(requestLabel);
    var responseData = await responseLabel.stream.bytesToString();

    if (responseLabel.statusCode == 200) {
      label = jsonDecode(responseData)["Label"];
    } else {
      print('Error: ${responseLabel.statusCode}');
    }


    String url = '$value/detect_objects';
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('image', image.path));
    var response = await ioClient.send(request);

    if (response.statusCode == 200) {
      // Create a temporary file to save the received image
      var directory = await getTemporaryDirectory();
      var filePath = '${directory.path}/received_image.jpg';
      var file = File(filePath);

      // Save the image file
      await response.stream.pipe(file.openWrite());

      //firebase
      var imgname = Random().nextInt(10000000).toString()+basename(filePath);
      var refstorage = FirebaseStorage.instance.ref(imgname);
      await refstorage.putFile(file);

      await imagesref.add({
        "object Detection": await refstorage.getDownloadURL(),
        "object names": label,
        "image name": imgname,
        "user_id": FirebaseAuth.instance.currentUser!.uid,
      });

      ////php
      await _crud.postRequestWithFile(linkAddImage, {"user_id": sharedPref.getString("id"), "object_names": label.join(', '), "imagename": imgname }, file);

      setState(() {
        _image = file;
        _busy = false;
      });
    } else {
      print('Error: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> stackChildren = [];
    stackChildren.add(
      Positioned(
        top: 0.0,
        left: 0.0,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              _image == null
                  ? Text("No Image Selected")
                  : Image.file(File(_image!.path)),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Text(
                LabelOnScreen(label),
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                  fontStyle: FontStyle.italic,
                  decorationThickness: 2.0,
                ),
              ),
              // Add more widgets here as needed
            ],
          ),
        ),
      ),
    );


    if (_busy) {
      stackChildren.add(Center(
        child: CircularProgressIndicator(),
      ));
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text("What\'s this"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () async{
              QuerySnapshot response = await imagesref.where("user_id", isEqualTo: FirebaseAuth.instance.currentUser!.uid).get();
              response.docs.forEach((element) {
                images.add(element.data());
              });
              print(images);
              _scaffoldKey.currentState!.openEndDrawer();
            },
          ),
        ],
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.only(left: 30),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          FloatingActionButton(
            heroTag: "btn1",
            child: Icon(Icons.camera_alt),
            tooltip: "Pick Image from camera",
            onPressed: () {
              selectFromImagePicker(ImageSource.camera);
              recognize = '';
              label = [];
            },
          ),
          FloatingActionButton(
            heroTag: "btn2",
            child: Icon(Icons.volume_up),
            tooltip: "play ",
            onPressed: () {
              playsound(label.join(', '));
            },
          ),
          FloatingActionButton(
            heroTag: "btn3",
            child: Icon(Icons.image),
            tooltip: "Pick Image from gallery",
            onPressed: (){
              selectFromImagePicker(ImageSource.gallery);
              recognize = '';
              label = [];
            },
          ),
        ]),
      ),
      endDrawer: Drawer(
        child: FutureBuilder(
          future: imagesref.where("user_id", isEqualTo: FirebaseAuth.instance.currentUser!.uid).get(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      "History Result",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, i) {
                        return Column(
                          children: [
                            InkWell(
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    snapshot.data.docs[i]["object Detection"],
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              onTap: () => playsound(snapshot.data.docs[i]["object names"].join(', ')),
                              onLongPress: () async {
                                await showDialog<bool>(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (context) {
                                    return AlertDialog(
                                      insetPadding: EdgeInsets.zero,
                                      contentTextStyle: GoogleFonts.mulish(),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      title: const Text('Delete image!'),
                                      content: const Text(
                                        'Are you sure you want to delete\nthis image?',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(color: Colors.grey, fontSize: 16),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () async {
                                            //firebase
                                            await imagesref.doc(snapshot.data.docs[i].id).delete();
                                            await FirebaseStorage.instance.refFromURL(snapshot.data.docs[i]["object Detection"]).delete();

                                            //php
                                            await _crud.postRequest(linkDeleteImage, {
                                              "imagename": snapshot.data.docs[i]["image name"],
                                            });
                                            Navigator.pop(context, false);
                                            setState(() {});
                                          },
                                          child: const Text(
                                            'Yes',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context, false);
                                          },
                                          child: const Text('No'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Align(
                                child: Text(
                                  snapshot.data.docs[i]["object names"].join(', '),
                                  style: TextStyle(fontSize: 20, color: Colors.red),
                                ),
                                alignment: Alignment.centerRight,
                              ),
                            ),
                            SizedBox(height: 5),
                            Container(
                              height: 1.5,
                              color: Colors.black,
                            ),
                            SizedBox(height: 20),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
      body: Stack(
        children: stackChildren,
      ),
    );
  }

  Future<void> playsound(String objectName) async {
    FlutterTts flutterTts = FlutterTts();
    await flutterTts.setLanguage('en-US'); // Set the language of the voice
    await flutterTts.setPitch(1.2); // Set the pitch of the voice
    await flutterTts.setSpeechRate(0.3); // Set the speed of the voice
    await flutterTts.setVolume(1.0); // Set the volume of speech
    await flutterTts.speak(objectName);
  }

  String LabelOnScreen(List<dynamic> input) {
    if (input.isEmpty) return '';
    List<String> splitStrings = input.join(', ').split(", ");
    String formattedString = '';
    for (int i = 0; i < splitStrings.length; i++) {
      formattedString += '${i + 1}) ${splitStrings[i]}\n';
    }
    return formattedString;
  }
}
