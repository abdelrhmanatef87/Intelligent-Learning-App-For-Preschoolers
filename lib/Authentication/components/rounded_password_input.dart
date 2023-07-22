import 'package:flutter/material.dart';
import 'package:intelligent_learning/Authentication/components/input_container.dart';
import 'package:intelligent_learning/model/color.dart';


class RoundedPasswordInput extends StatefulWidget {
  const RoundedPasswordInput({
    required this.hint, required this.labletext, required this.controller,
  });

  final String hint;
  final String labletext;
  final TextEditingController controller;

  @override
  State<RoundedPasswordInput> createState() => _RoundedPasswordInputState();
}

class _RoundedPasswordInputState extends State<RoundedPasswordInput> {
  @override
  Widget build(BuildContext context) {
    return InputContainer(
      child: TextFormField(
        controller: widget.controller,
        cursorColor: AppColors.kPrimaryColor12,
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(Icons.lock, color: AppColors.kRecoverColor),
          hintText: widget.hint,
          labelText: widget.labletext,
          border: InputBorder.none
        ),
        validator: (value) => value != null && value.length < 2 ? 'Enter a valid password' : null,
      ));
  }
}