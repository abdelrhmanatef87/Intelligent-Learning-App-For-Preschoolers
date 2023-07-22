import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intelligent_learning/HomePage.dart';
import 'package:intelligent_learning/backend/crud.dart';
import 'package:intelligent_learning/model/color.dart';
import 'package:intelligent_learning/backend/linkapi.dart';
import 'package:intelligent_learning/main.dart';


class RoundedButton extends StatelessWidget {
  const RoundedButton({
    required this.title,
    required this.email,
    required this.password,
  });
  final String title, email, password;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Crud _crud = Crud();

    return InkWell(
      onTap: () async {
        try {
          showLoading(context);
          //firebase
          await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email,
            password: password,
          );

          //php
          var response = await _crud.postRequest(linkLogin, {
            "email": email,
            "password": password,
          });
          sharedPref.setString("id", response['data']['id'].toString());

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        } on FirebaseAuthException catch (e) {
          Navigator.of(context).pop();
          if (e.code == 'user-not-found') {
            AwesomeDialog(
              context: context,
              dialogType: DialogType.error,
              animType: AnimType.LEFTSLIDE,
              title: "Error",
              body: Text("No user found for that email."),
              btnCancelOnPress: () {},
            )..show();
          } else if (e.code == 'wrong-password') {
            AwesomeDialog(
              context: context,
              dialogType: DialogType.warning,
              animType: AnimType.rightSlide,
              title: "Error",
              body: Text("Wrong password provided for that user."),
              btnCancelOnPress: () {},
            )..show();
          }
        }
      },
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: size.width * 0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: AppColors.kRecoverColor,
        ),
        padding: EdgeInsets.symmetric(vertical: 20),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
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
