import 'dart:io';
import 'dart:math';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:http/http.dart' as http;
import 'package:intelligent_learning/backend/crud.dart';
import 'package:path/path.dart';
import 'package:intelligent_learning/backend/linkapi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/io_client.dart';



class OCR extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _ocr();
  }
}

class _ocr extends State<OCR> {
  late SharedPreferences sharedPref;
  bool textScanning = false;
  bool running = true;
  XFile? imageFile;
  String scannedText = "";
  SharedPreferences? prefs;
  List images = [];
  Crud _crud = Crud();
  CollectionReference imagesref = FirebaseFirestore.instance.collection("ocr");
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  FlutterTts ftts = FlutterTts();

  @override
  void initState() {
    super.initState();
    ftts.setCompletionHandler(() {
      setState(() {
        running = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Read Story"),
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
              _scaffoldKey.currentState!.openEndDrawer();
            },
          ),
        ],
      ),
      endDrawer: Drawer(
        child: FutureBuilder(
          future: imagesref
              .where("user_id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .get(),
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
                                    snapshot.data.docs[i]["imageUrl"],
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              onTap: () => playsound(snapshot.data.docs[i]["recognized_text"]),
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
                                      title: const Text('Delete image?'),
                                      content: const Text(
                                        'Are you sure you want to delete\nthis image?',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(color: Colors.grey, fontSize: 16),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () async {
                                            await imagesref.doc(snapshot.data.docs[i].id).delete();
                                            await FirebaseStorage.instance.refFromURL(snapshot.data.docs[i]["imageUrl"]).delete();

                                            // await _crud.postRequest(linkDeleteOcr, {
                                            //   "imgname": snapshot.data.docs[i]["img name"],
                                            // });
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
                                  snapshot.data.docs[i]["recognized_text"],
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
      body: Center(
          child: SingleChildScrollView(
        child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (textScanning) const CircularProgressIndicator(),
                if (!textScanning && imageFile == null)
                  Container(
                    width: 300,
                    height: 300,
                    color: Colors.grey[300]!,
                  ),
                if (imageFile != null) Image.file(File(imageFile!.path)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        padding: const EdgeInsets.only(top: 10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: Colors.grey,
                            shadowColor: Colors.grey[400],
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                          ),
                          onPressed: () {
                            getImage(ImageSource.gallery);
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.image,
                                  size: 30,
                                ),
                                Text(
                                  "Gallery",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.grey[600]),
                                )
                              ],
                            ),
                          ),
                        )),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        padding: const EdgeInsets.only(top: 10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: Colors.grey,
                            shadowColor: Colors.grey[400],
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                          ),
                          onPressed: () {
                            getImage(ImageSource.camera);
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.camera_alt, size: 30,),
                                Text("Camera", style: TextStyle(fontSize: 13, color: Colors.grey[600]),)
                              ],
                            ),
                          ),
                        )),

                    //play sound
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        padding: const EdgeInsets.only(top: 10),
                        child: running
                            ? ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                  onPrimary: Colors.grey,
                                  shadowColor: Colors.grey[400],
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                                ),
                                onPressed: () {
                                  playsound();
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.volume_up, size: 30,),
                                      Text("Play", style: TextStyle(fontSize: 13, color: Colors.grey[600]),),
                                    ],
                                  ),
                                ),
                              )
                            : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                  onPrimary: Colors.grey,
                                  shadowColor: Colors.grey[400],
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                                ),
                                onPressed: () {
                                  playsound();
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.pause, size: 30,),
                                      Text("Pause", style: TextStyle(fontSize: 13, color: Colors.grey[600]),),
                                    ],
                                  ),
                                ),
                              )
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  child: Text(scannedText, style: TextStyle(fontSize: 20),),
                )
              ],
            )),
      )),
    );
  }

  void getImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        textScanning = true;
        imageFile = pickedImage;
        setState(() {scannedText = '';});
        getRecognisedText(pickedImage);
      }
    } catch (e) {
      textScanning = false;
      imageFile = null;
      scannedText = "Error occured while scanning";
      setState(() {});
    }
  }

  void getRecognisedText(XFile image) async {
    try{
      prefs = await SharedPreferences.getInstance();
      if((prefs!.getBool('switchValue'))!){
        print("1");
        final box1 = await Hive.openBox('my_box');
        final value = box1.get('my_key');
        final ioClient = IOClient(
          HttpClient()
            ..badCertificateCallback = ((X509Certificate cert, String host, int port) => true),
        );

        String url = '$value/ocr';
        var request = http.MultipartRequest('POST', Uri.parse(url));
        request.files.add(await http.MultipartFile.fromPath('image', image.path));
        var response = await ioClient.send(request);
        if (response.statusCode == 200) {
          var responseData = await response.stream.bytesToString();
          scannedText = jsonDecode(responseData)["result"];
        } else {
          print('Error: ${response.statusCode}');
        }

        //firebase
        var imgname = Random().nextInt(10000000).toString()+basename(image.path);
        var refstorage = FirebaseStorage.instance.ref(imgname);
        await refstorage.putFile(File(image.path));

        await imagesref.add({
          "imageUrl": await refstorage.getDownloadURL(),
          "recognized_text": scannedText,
          "img name": imgname,
          "user_id": FirebaseAuth.instance.currentUser!.uid,
        });

        //php
        // await _crud.postRequestWithFile(linkAddOcr, {"user_id": sharedPref.getString("id"), "recognized_text": scannedText, "imgname": imgname }, File(image.path));

      }else{
        print("2");
        final inputImage = InputImage.fromFilePath(image.path);
        final textDetector = GoogleMlKit.vision.textDetector();
        RecognisedText recognisedText = await textDetector.processImage(inputImage);
        await textDetector.close();
        scannedText = "";
        for (TextBlock block in recognisedText.blocks) {
          for (TextLine line in block.lines) {
            scannedText = scannedText + line.text + "\n";
          }
        }
        //firebase
        var imgname = Random().nextInt(10000000).toString()+basename(image.path);
        var refstorage = FirebaseStorage.instance.ref(imgname);
        await refstorage.putFile(File(image.path));

        await imagesref.add({
          "imageUrl": await refstorage.getDownloadURL(),
          "recognized_text": scannedText,
          "img name": imgname,
          "user_id": FirebaseAuth.instance.currentUser!.uid,
        });

        //php
        await _crud.postRequestWithFile(linkAddOcr, {"user_id": sharedPref.getString("id"), "recognized_text": scannedText, "imgname": imgname }, File(image.path));

      }
      textScanning = false;
      setState(() {});
    } catch(e) {
      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  void playsound([String? text]) async {
    await ftts.setLanguage("en-US");
    await ftts.setSpeechRate(0.2);
    await ftts.setVolume(1.0);
    await ftts.setPitch(1.2);
    text==null? running ? await ftts.speak(scannedText) : await ftts.pause()
    : running ? await ftts.speak(text) : await ftts.pause();
    setState(() { running = !running; });
  }
}
