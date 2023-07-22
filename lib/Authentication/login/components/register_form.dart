import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intelligent_learning/Authentication/components/input_container.dart';
import 'package:intelligent_learning/Authentication/components/rounded_input.dart';
import 'package:intelligent_learning/Authentication/components/rounded_password_input.dart';
import 'package:intelligent_learning/GoogleSheet/user.dart';
import 'package:intelligent_learning/GoogleSheet/user_sheets_api.dart';
import 'package:intelligent_learning/HomePage.dart';
import 'package:intelligent_learning/backend/crud.dart';
import 'package:intelligent_learning/model/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intelligent_learning/backend/linkapi.dart';
import 'package:intelligent_learning/main.dart';


class RegisterForm extends StatefulWidget {
  RegisterForm({
    required this.isLogin,
    required this.animationDuration,
    required this.size,
    required this.defaultLoginSize,
  });

  final bool isLogin;
  final Duration animationDuration;
  final Size size;
  final double defaultLoginSize;

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController controllerUsername;
  late TextEditingController controllerEmail;
  late TextEditingController controllerPassword;
  String? gender;
  Crud _crud = Crud();

  @override
  void initState() {
    super.initState();

    controllerUsername = TextEditingController();
    controllerEmail = TextEditingController();
    controllerPassword = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: widget.isLogin ? 0.0 : 1.0,
      duration: widget.animationDuration * 5,
      child: Visibility(
        visible: !widget.isLogin,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: widget.size.width,
            height: widget.defaultLoginSize,
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/image/icon/signup.png', height: 125),
                    RoundedInput(
                        icon: Icons.face_rounded,
                        labletext: 'Username',
                        hint: 'Enter username',
                        controller: controllerUsername),
                    InputContainer(
                      child: TextFormField(
                        controller: controllerEmail,
                        cursorColor: AppColors.kPrimaryColor12,
                        decoration: const InputDecoration(
                          icon:
                              Icon(Icons.mail, color: AppColors.kRecoverColor),
                          hintText: 'Enter e-mail',
                          border: InputBorder.none,
                          labelText: 'E-mail',
                        ),
                        validator: (email) {
                          if ((email!.isEmpty) ||
                              !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                  .hasMatch(email)) {
                            return "Enter a valid email address";
                          }
                          return null;
                        },
                      ),
                    ),
                    RoundedPasswordInput(
                      labletext: 'Password',
                      hint: 'Enter password',
                      controller: controllerPassword,
                    ),
                    GenderKids(),
                    InkWell(
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          try {
                            if (gender == null)
                              Fluttertoast.showToast(
                                  msg: "Select Gender",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            else {
                              showLoading(context);
                              UserCredential userCredential = await FirebaseAuth
                                  .instance
                                  .createUserWithEmailAndPassword(
                                email: controllerEmail.text,
                                password: controllerPassword.text,
                              );

                              final user = User_Info(
                                  userId: FirebaseAuth.instance.currentUser!.uid,
                                  username: controllerUsername.text,
                                  email: controllerEmail.text,
                                  gender: gender!,
                                  review: '',
                                  positive: 0.0,
                                  negative: 0.0,
                                  choose: 0,
                                  complete: 0,
                                  match: 0,
                                  listen: 0,
                                  read: 0,
                                  duration: Duration.zero.toString(),
                                  closeApp: 0,
                                  avgDuration: Duration.zero.toString(),
                              );
                              await UserSheetsApi.insert([user.toJson()]);

                              //firebase
                              await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).set({
                                "username": controllerUsername.text,
                                "email": controllerEmail.text,
                                "password": controllerPassword.text,
                                "gender": gender,
                                "review": '',
                                "positive": 0.0,
                                "negative": 0.0,
                                "scores": List.filled(50, 0),
                                "userid": userCredential.user!.uid,
                                "show": true,
                                "duration": Duration.zero.toString(),
                                "closeApp": 0,
                                "AvgUsage": Duration.zero.toString(),
                              });

                              //php
                             await _crud.postRequest(linkSignUp, {
                                "username": controllerUsername.text,
                                "email": controllerEmail.text,
                                "password": controllerPassword.text,
                                "gender": gender,
                              });
                              var response = await _crud.postRequest(linkLogin, {
                                "email": controllerEmail.text,
                                "password": controllerPassword.text,
                              });
                              sharedPref.setString("id", response['data']['id'].toString());

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()),
                              );
                            }
                          } on FirebaseAuthException catch (e) {
                            Navigator.of(context).pop();
                            if (e.code == 'weak-password') {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.info,
                                animType: AnimType.rightSlide,
                                title: "Error",
                                body: Text("password is to weak"),
                                btnCancelOnPress: () {},
                              )..show();
                            } else if (e.code == 'email-already-in-use') {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.infoReverse,
                                animType: AnimType.LEFTSLIDE,
                                title: "Error",
                                body: Text(
                                    "The account already exists for that email."),
                                btnCancelOnPress: () {},
                              )..show();
                            }
                          } catch (e) {
                            print(e);
                          }
                        }
                      },
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        width: widget.size.width * 0.8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: AppColors.kRecoverColor,
                        ),
                        padding: EdgeInsets.symmetric(vertical: 20),
                        alignment: Alignment.center,
                        child: const Text(
                          'SIGN UP',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      "Or create account using social media",
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          child: FaIcon(
                            FontAwesomeIcons.googlePlus,
                            size: 35,
                            color: HexColor("#EC2D2F"),
                          ),
                          onTap: () async {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return alartDialog(
                                    "Google Plus",
                                    "You tap on GooglePlus social icon.",
                                    context);
                              },
                            );
                          },
                        ),
                        SizedBox(
                          width: 30.0,
                        ),
                        GestureDetector(
                          child: Container(
                            padding: EdgeInsets.all(0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                  width: 5, color: HexColor("#40ABF0")),
                              color: HexColor("#40ABF0"),
                            ),
                            child: FaIcon(
                              FontAwesomeIcons.twitter,
                              size: 23,
                              color: HexColor("#FFFFFF"),
                            ),
                          ),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return alartDialog("Twitter",
                                    "You tap on Twitter social icon.", context);
                              },
                            );
                          },
                        ),
                        SizedBox(
                          width: 30.0,
                        ),
                        GestureDetector(
                          child: FaIcon(
                            FontAwesomeIcons.facebook,
                            size: 35,
                            color: HexColor("#3E529C"),
                          ),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return alartDialog(
                                    "Facebook",
                                    "You tap on Facebook social icon.",
                                    context);
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  AlertDialog alartDialog(String title, String content, BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          child: const Text(
            "OK",
            style: TextStyle(color: Colors.white),
          ),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.black38)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  GenderKids() {
    return Column(
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
  }

  showLoading(context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Please Wait"),
            content: Container(
                height: 50,
                child: Center(
                  child: CircularProgressIndicator(),
                )),
          );
        });
  }
}
