import 'package:flutter/material.dart';
import 'package:intelligent_learning/Authentication/components/input_container.dart';
import 'package:intelligent_learning/model/color.dart';

class RoundedInput extends StatelessWidget {
   RoundedInput({
    required this.icon,
    required this.hint,
    required this.labletext,
     required this.controller,
  });

  final IconData icon;
  final String hint;
  final String labletext;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return InputContainer(
      child: TextFormField(
        controller: controller,
        validator: (value) => value != null && value.isEmpty ? 'Enter Username' : null,
        cursorColor: AppColors.kRecoverColor,
        decoration: InputDecoration(
          icon: Icon(icon, color: AppColors.kRecoverColor),
          hintText: hint,
          border: InputBorder.none,
          labelText: labletext,
        ),

      ));
  }
}