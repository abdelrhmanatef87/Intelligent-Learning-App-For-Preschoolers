import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:intelligent_learning/backend/crud.dart';
import 'package:intelligent_learning/youtubeANDweb/cartoon.dart';
import 'package:intelligent_learning/youtubeANDweb/webview.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intelligent_learning/GoogleSheet/user_sheets_api.dart';
import 'package:intelligent_learning/Games/games_screen.dart';
import 'package:intelligent_learning/Learning/Learning.dart';
import 'package:intelligent_learning/ObjectDetection/object_detection.dart';
import 'package:intelligent_learning/Question/components/questionpage.dart';
import 'package:intelligent_learning/Report/graphChart.dart';
import 'package:intelligent_learning/TextClassification/classifier.dart';
import 'package:intelligent_learning/TextRecognition/ocr.dart';
import 'package:intelligent_learning/model/Theme.dart';
import 'package:intelligent_learning/model/color.dart';
import 'package:intelligent_learning/model/primary_text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intelligent_learning/main.dart';
import 'package:intelligent_learning/backend/linkapi.dart';
import 'package:http/io_client.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> with WidgetsBindingObserver{
  List<Color> color = const [
    Color(0xFFffaa5b),
    Color(0xFF71b8ff),
    Color(0xFF9ba0fc),
    Color(0xffffcce7),
    Color(0xffff5f7e),
    Color(0xFF36C12C),
  ];
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final keyOne = GlobalKey();
  BuildContext? mycontext;
  TextEditingController _reviewController = TextEditingController();
  TextEditingController _usernameForEdit = TextEditingController();
  List<double>? pred;
  String? gender;
  SharedPreferences? prefs;
  bool switchValue = false;
  Classifier? _classifier;
  CollectionReference userref = FirebaseFirestore.instance.collection('users');
  List users = [];
  Crud _crud = Crud();
  DateTime? appResumedTime;
  DateTime? appPausedTime;
  Duration appUsageDuration = Duration.zero;
  int closeAppCount = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    getSwitchValue();
    getUserInfo();

    WidgetsBinding.instance!.addPostFrameCallback(
      (_) => ShowCaseWidget.of(mycontext!).startShowCase([keyOne])
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async{
    if (state == AppLifecycleState.resumed) {
      appResumedTime = DateTime.now();
    } else if (state == AppLifecycleState.paused) {
      closeAppCount++;
      appPausedTime = DateTime.now();
      if (appResumedTime != null) {
        appUsageDuration += appPausedTime!.difference(appResumedTime!);
      }
    }
    String avgUsage = Duration(milliseconds: appUsageDuration.inMilliseconds ~/closeAppCount).toString();
    await userref.doc(FirebaseAuth.instance.currentUser!.uid).update({
      "duration": appUsageDuration.toString(),
      "closeApp": closeAppCount,
      "AvgUsage": avgUsage,
    });
    await UserSheetsApi.updateCell(
        id: FirebaseAuth.instance.currentUser!.uid,
        key: 'Duration',
        value: appUsageDuration.toString());
    await UserSheetsApi.updateCell(
        id: FirebaseAuth.instance.currentUser!.uid,
        key: '#use app',
        value: closeAppCount);
    await UserSheetsApi.updateCell(
        id: FirebaseAuth.instance.currentUser!.uid,
        key: 'Average usage of the app',
        value: avgUsage);
    print("Avg: $avgUsage");
    print("appUsageDuration: $appUsageDuration");
  }

  getUserInfo() async {
    _classifier = Classifier();
    QuerySnapshot response = await userref.where("userid", isEqualTo: FirebaseAuth.instance.currentUser!.uid).get();
    response.docs.forEach((element) {
      users.add(element.data());
    });
    _usernameForEdit.text = users[0]['username'];
    gender = users[0]['gender'];
    _reviewController.text = users[0]['review'];
    closeAppCount = users[0]['closeApp'];

    String durationString = users[0]['duration'];
    print(durationString);
    List<String> durationParts = durationString.split(':');
    int hours = int.parse(durationParts[0]);
    int minutes = int.parse(durationParts[1]);
    int seconds = double.parse(durationParts[2]).toInt();
    appUsageDuration = Duration(hours: hours, minutes: minutes, seconds: seconds);
    setState(() {});

    if (users[0]['show']) {
      print("===========================");
      Future.delayed(const Duration(seconds: 10), () async {
        await userref.doc(FirebaseAuth.instance.currentUser!.uid).update({
          "show": false,
        });
      });
    }

    DocumentSnapshot documentSnapshot = await userref.doc('public Api').get();
    if(documentSnapshot.exists){
        Map<String, dynamic>? data = documentSnapshot.data() as Map<String, dynamic>?;
        if (data != null) {
          String? field = data['server'];
          final box = await Hive.openBox('my_box');
          final myValue = field;
          await box.put('my_key', myValue);
        }
      } else {
        print('Document does not exist');
      }
    }

  Future<void> getSwitchValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      switchValue = prefs.getBool('switchValue') ?? false;
    });
  }

  Future<void> setSwitchValue(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('switchValue', value);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ModelTheme>(
        builder: (context, ModelTheme themeNotifier, child) {
      return ShowCaseWidget(
        builder: Builder(builder: (context) {
          mycontext = context;
          return Scaffold(
            key: _key,
            drawer: Drawer(
              child: users.length == 0
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        UserAccountsDrawerHeader(
                          decoration: BoxDecoration(color: Color(0xff764abc)),
                          accountName: InkWell(
                            onTap: () => EditProfileInfo(),
                            child: Text(
                              users[0]['username'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          accountEmail: InkWell(
                            child: Text(
                              (FirebaseAuth.instance.currentUser!.email)!,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                            onTap: () => EditProfileInfo(),
                          ),
                          currentAccountPicture: CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage: AssetImage(
                              users[0]['gender'] == 'boy'
                                  ? "assets/image/home/profile.jpg"
                                  : "assets/image/home/girl.png",
                            ),
                          ),
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.games_outlined,
                          ),
                          title: const Text('Games'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => GameScreen()),
                            );
                          },
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.reviews,
                          ),
                          title: const Text('Review'),
                          onTap: () {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.info,
                              borderSide: const BorderSide(
                                color: Colors.green,
                                width: 2,
                              ),
                              headerAnimationLoop: true,
                              animType: AnimType.bottomSlide,
                              buttonsTextStyle:
                                  const TextStyle(color: Colors.black),
                              showCloseIcon: true,
                              body: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      'How was your experience with us?',
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Material(
                                      elevation: 0,
                                      color: Colors.blueGrey.withAlpha(40),
                                      child: TextFormField(
                                        autofocus: true,
                                        controller: _reviewController,
                                        decoration: const InputDecoration(
                                          labelText: 'Review',
                                          hintText: 'Enter your opinion',
                                          hintStyle: TextStyle(fontSize: 15),
                                          prefixIcon: Icon(Icons.text_fields),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              btnOkOnPress: () async {
                                if (_reviewController.text.replaceAll(" ", "").isNotEmpty) {
                                  if (switchValue) {
                                    final box1 = await Hive.openBox('my_box');
                                    final value = box1.get('my_key');
                                    final ioClient = IOClient(
                                      HttpClient()
                                        ..badCertificateCallback = ((X509Certificate cert, String host, int port) => true),
                                    );

                                    var url = Uri.parse('$value/review');
                                    var response = await ioClient.post(url, body: {'review': _reviewController.text});

                                    if (response.statusCode == 200) {
                                      var responseData = response.body;
                                    if ((jsonDecode(responseData)[0]['label']) == 'POSITIVE') {
                                      await userref.doc(FirebaseAuth.instance.currentUser!.uid).update({
                                        "review": _reviewController.text,
                                        "positive": jsonDecode(responseData)[0]['score'] >= 0.99 ? 0.99 : jsonDecode(responseData)[0]['score'],
                                        "negative": 1 - jsonDecode(responseData)[0]['score'] <= 0.01 ? 0.01 : 1 - jsonDecode(responseData)[0]['score'],
                                      });
                                      // await _crud.postRequest(linkEditReview, {
                                      //   "review": _reviewController.text,
                                      //   "positive": jsonDecode(responseData)[0]['score'] >= 0.99 ? 0.99.toString() : jsonDecode(responseData)[0]['score'].toString(),
                                      //   "negative": 1 - jsonDecode(responseData)[0]['score'] <= 0.01 ? 0.01.toString() : (1 - jsonDecode(responseData)[0]['score']).toString(),
                                      //   "id": sharedPref.getString("id"),
                                      // });
                                      await UserSheetsApi.updateCell(
                                          id: FirebaseAuth.instance.currentUser!.uid,
                                          key: 'Review',
                                          value: _reviewController.text);
                                      await UserSheetsApi.updateCell(
                                          id: FirebaseAuth.instance.currentUser!.uid,
                                          key: 'Positive',
                                          value: jsonDecode(responseData)[0]['score'] >= 0.99 ? 0.99 : jsonDecode(responseData)[0]['score']);
                                      await UserSheetsApi.updateCell(
                                          id: FirebaseAuth.instance.currentUser!.uid,
                                          key: 'Negative',
                                          value: 1 - jsonDecode(responseData)[0]['score'] <= 0.01 ? 0.01 : 1 - jsonDecode(responseData)[0]['score']);
                                    } else if ((jsonDecode(responseData)[0]['label']) == 'NEGATIVE') {
                                      await userref.doc(FirebaseAuth.instance.currentUser!.uid).update({
                                        "review": _reviewController.text,
                                        "positive": 1 - jsonDecode(responseData)[0]['score'] <= 0.01 ? 0.01 : 1 - jsonDecode(responseData)[0]['score'],
                                        "negative": jsonDecode(responseData)[0]['score'] >= 0.99 ? 0.99 : jsonDecode(responseData)[0]['score'],
                                      });
                                      // await _crud.postRequest(linkEditReview, {
                                      //   "review": _reviewController.text,
                                      //   "positive": 1 - jsonDecode(responseData)[0]['score'] <= 0.01 ? 0.01.toString() : (1 - jsonDecode(responseData)[0]['score']).toString(),
                                      //   "negative": jsonDecode(responseData)[0]['score'] >= 0.99 ? 0.99.toString() : jsonDecode(responseData)[0]['score'].toString(),
                                      //   "id": sharedPref.getString("id"),
                                      // });
                                      await UserSheetsApi.updateCell(
                                          id: FirebaseAuth.instance.currentUser!.uid,
                                          key: 'Review',
                                          value: _reviewController.text);
                                      await UserSheetsApi.updateCell(
                                          id: FirebaseAuth.instance.currentUser!.uid,
                                          key: 'Positive',
                                          value: 1 - jsonDecode(responseData)[0]['score'] <= 0.01 ? 0.01 : 1 - jsonDecode(responseData)[0]['score']);
                                      await UserSheetsApi.updateCell(
                                          id: FirebaseAuth.instance.currentUser!.uid,
                                          key: 'Negative',
                                          value: jsonDecode(responseData)[0]['score'] >= 0.99 ? 0.99 : jsonDecode(responseData)[0]['score']);
                                    }
                                    } else {
                                      print('Error: ${response.statusCode}');
                                    }
                                  } else {
                                    pred = await _classifier!.classify( _reviewController.text.toLowerCase());
                                    await UserSheetsApi.updateCell(
                                        id: FirebaseAuth.instance.currentUser!.uid,
                                        key: 'Review',
                                        value: _reviewController.text);
                                    await UserSheetsApi.updateCell(
                                        id: FirebaseAuth.instance.currentUser!.uid,
                                        key: 'Positive',
                                        value: pred![1]);
                                    await UserSheetsApi.updateCell(
                                        id: FirebaseAuth.instance.currentUser!.uid,
                                        key: 'Negative',
                                        value: pred![0]);
                                    await userref.doc(FirebaseAuth.instance.currentUser!.uid).update({
                                      "review": _reviewController.text,
                                      "positive": pred![1],
                                      "negative": pred![0],
                                    });
                                    // await _crud.postRequest(linkEditReview, {
                                    //   "review": _reviewController.text,
                                    //   "positive": pred![1].toString(),
                                    //   "negative": pred![0].toString(),
                                    //   "id": sharedPref.getString("id"),
                                    // });
                                  }
                                  Fluttertoast.showToast(
                                      msg: "Thanks for Review",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      backgroundColor: Colors.green,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }
                              },
                            ).show();
                          },
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.wb_incandescent_outlined,
                          ),
                          title: const Text('Theme'),
                          trailing: IconButton(
                              icon: Icon(themeNotifier.isDark
                                  ? Icons.nightlight_round
                                  : Icons.wb_sunny,  color: themeNotifier.isDark? Colors.white:Colors.yellow),
                              onPressed: () {
                                themeNotifier.isDark
                                    ? themeNotifier.isDark = false
                                    : themeNotifier.isDark = true;
                              }),
                          onTap: () {
                            themeNotifier.isDark
                                ? themeNotifier.isDark = false
                                : themeNotifier.isDark = true;
                          },
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.http,
                          ),
                          title: const Text('use Models'),
                          onTap: () async {
                            setState(() {
                              switchValue = !switchValue;
                              setSwitchValue(switchValue);
                            });
                          },
                          trailing: Switch(
                            value: switchValue,
                            onChanged: (bool newValue) {
                              setState(() {
                                switchValue = newValue;
                                setSwitchValue(newValue);
                              });
                            },
                          ),
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.web,
                          ),
                          title: const Text('Games Alphabet'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => WebViewExample(url: 'https://www.education.com/games/alphabet/', title: 'Games Alphabet',)),
                            );
                          },
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.web,
                          ),
                          title: const Text('learn English kids'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => WebViewExample(url: 'https://learnenglishkids.britishcouncil.org/', title: 'learn English kids',)),
                            );
                          },
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.logout,
                          ),
                          title: const Text('Logout'),
                          onTap: () async {
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
                                  title: const Text('Confirm Logout!'),
                                  content: const Text(
                                    'Are you sure you want to log out\nfrom the application?',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(color: Colors.grey, fontSize: 16),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () async {
                                        await userref.doc(FirebaseAuth.instance.currentUser!.uid).update({
                                          "show": true,
                                        });
                                        sharedPref.clear();
                                        await FirebaseAuth.instance.signOut();
                                        Navigator.of(context).pushReplacementNamed("login");
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
                      ],
                    ),
            ),
            body: Container(
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/image/learning/bg-bottom.png'),
                  alignment: Alignment.bottomCenter,
                ),
              ),
              child: SingleChildScrollView(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          users.length == 0
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : users[0]['show']
                                  ? Showcase(
                                      key: keyOne,
                                      description:
                                          'Press here to open your profile',
                                      child: IconButton(
                                          onPressed: () =>
                                              _key.currentState!.openDrawer(),
                                          icon: const Icon(
                                            Icons.dashboard_rounded,
                                            color: Color(0xFF71b8ff),
                                            size: 30,
                                            semanticLabel: 'cddcdsd',
                                          )))
                                  : IconButton(
                                      onPressed: () =>
                                          _key.currentState!.openDrawer(),
                                      icon: const Icon(
                                        Icons.dashboard_rounded,
                                        color: Color(0xFF71b8ff),
                                        size: 30,
                                        semanticLabel: 'cddcdsd',
                                      )),
                          SizedBox(
                              height: 150,
                              child:
                                  Image.asset('assets/image/icon/login.png')),
                          const SizedBox(
                            width: 45,
                          ),
                        ],
                      ),
                      buildCards(context, Card.CardsList),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      );
    });
  }

  EditProfileInfo() async {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.info,
      dismissOnTouchOutside: false,
      borderSide: const BorderSide(
        color: Colors.green,
        width: 2,
      ),
      headerAnimationLoop: true,
      animType: AnimType.bottomSlide,
      buttonsTextStyle: const TextStyle(color: Colors.black),
      showCloseIcon: true,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Text(
              'Edit your Information',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(
              height: 10,
            ),
            Material(
              elevation: 0,
              color: Colors.blueGrey.withAlpha(40),
              child: TextFormField(
                autofocus: true,
                controller: _usernameForEdit,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  hintText: 'Enter username',
                  hintStyle: TextStyle(fontSize: 15),
                  prefixIcon: Icon(Icons.text_fields),
                ),
              ),
            ),
            AlertDialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              contentPadding: EdgeInsets.zero,
              alignment: Alignment.topLeft,
              content: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RadioListTile(
                      title: Text("Boy"),
                      value: "boy",
                      groupValue: gender,
                      onChanged: (value) {
                        setState(() {
                          gender = value.toString();
                        });
                      },
                    ),
                    RadioListTile(
                      title: Text("Girl"),
                      value: "girl",
                      groupValue: gender,
                      onChanged: (value) {
                        setState(() {
                          gender = value.toString();
                        });
                      },
                    ),
                  ],
                );
              }),
            )
          ],
        ),
      ),
      btnCancelOnPress: () {},
      btnOkOnPress: () async {
        if (_usernameForEdit.text.replaceAll(" ", "").isNotEmpty) {
          await UserSheetsApi.updateCell(
              id: FirebaseAuth.instance.currentUser!.uid,
              key: 'Username',
              value: _usernameForEdit.text);

          await UserSheetsApi.updateCell(
              id: FirebaseAuth.instance.currentUser!.uid,
              key: 'Gender',
              value: gender);

          await userref.doc(FirebaseAuth.instance.currentUser!.uid).update({
            "username": _usernameForEdit.text,
            "gender": gender,
          });

          await _crud.postRequest(linkEditProfile, {
            "username": _usernameForEdit.text,
            "gender": gender,
            "id": sharedPref.getString("id"),
          });

          users = [];
          getUserInfo();
          Fluttertoast.showToast(
              msg: "Edit successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      },
    ).show();
  }

  SizedBox buildCards(BuildContext context, List<Card> CardsList) {
    return SizedBox(
      height: 545,
      child: GridView.builder(
        itemCount: CardsList.length,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.1,
        ),
        itemBuilder: (context, index) => cardsStyle(CardsList[index].imagePath,
            CardsList[index].name, index, color[index], CardsList[index].page),
      ),
    );
  }

  Widget cardsStyle(
      String imagePath, String name, int index, Color c, Widget page) {
    return InkWell(
      onTap: () => {
        setState(
          () => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => page),
            )
          },
        ),
      },
      child: Container(
        margin: const EdgeInsets.only(right: 18, bottom: 18, left: 18),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: c,
            boxShadow: const [
              BoxShadow(
                color: AppColors.secondary,
                blurRadius: 2,
              )
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              color: Colors.transparent,
              height: 100,
              width: 105,
              child: Image.asset(imagePath, fit: BoxFit.fill),
            ),
            PrimaryText(text: name, fontWeight: FontWeight.w600, size: 18),
          ],
        ),
      ),
    );
  }
}

class Card {
  final String imagePath;
  final String name;
  final Widget page;
  Card({
    required this.page,
    required this.imagePath,
    required this.name,
  });

  static List<Card> CardsList = [
    Card(
      imagePath: 'assets/image/home/read.png',
      name: 'Read Story',
      page: OCR(),
    ),
    Card(
      imagePath: 'assets/image/home/objectdetection.png',
      name: 'What\'s this',
      page: ObjectDetection(),
    ),
    Card(
      imagePath: 'assets/image/home/learn.png',
      name: 'Learning',
      page: Learning(),
    ),
    Card(
      imagePath: 'assets/image/home/quizzes.png',
      name: 'Quizzes',
      page: QuestionPage(),
    ),
    Card(
      imagePath: 'assets/image/home/kidvideos.png',
      name: 'Cartoon',
      page: CartoonVideo(),
    ),
    Card(
      imagePath: 'assets/image/home/report.png',
      name: 'Report',
      page: Charts(),
    ),
  ];
}
