import 'package:flutter/material.dart';
import 'package:intelligent_learning/model/color.dart';

class InputContainer extends StatelessWidget {
  const InputContainer({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: AppColors.kPrimaryColor12.withAlpha(50)
      ),

      child: child
    );
  }
}