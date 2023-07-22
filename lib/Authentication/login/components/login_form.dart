import 'package:flutter/material.dart';
import 'package:intelligent_learning/Authentication/components/rounded_button.dart';
import 'package:intelligent_learning/Authentication/components/rounded_input.dart';
import 'package:intelligent_learning/Authentication/components/rounded_password_input.dart';
import 'package:intelligent_learning/Authentication/login/components/Forgot_password.dart';
import 'package:intelligent_learning/model/color.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
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
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late TextEditingController controllerEmail;
  late TextEditingController controllerPassword;


  @override
  void initState() {
    super.initState();
    controllerEmail = TextEditingController();
    controllerPassword = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: widget.isLogin ? 1.0 : 0.0,
      duration: widget.animationDuration * 4,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          width: widget.size.width,
          height: widget.defaultLoginSize,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),

                Container(
                    height: 250,
                    child: Image.asset('assets/image/icon/login.png')),

                //SizedBox(height: 5),

                RoundedInput(
                    icon: Icons.mail,
                    labletext: 'E-mail',
                    hint: 'Enter e-mail',
                    controller: controllerEmail
                ),

                RoundedPasswordInput(
                  labletext: 'Password',
                  hint: 'Enter password',
                  controller: controllerPassword,
                ),

                const SizedBox(height: 5),

                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgotPasswordPage()),
                      );
                    },
                    child: const Text(
                      "Forgot your password?",
                      style: TextStyle(
                        color: AppColors.Kforget,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 10),

                RoundedButton(title: 'LOGIN', email: controllerEmail.text, password: controllerPassword.text, ),

                SizedBox(height: 5),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
