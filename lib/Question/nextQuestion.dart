import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intelligent_learning/Question/components/card_details.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';


class NextQustion extends StatefulWidget {
  final int index;
  const NextQustion({required this.index});

  @override
  State<NextQustion> createState() => _NextQustionState();
}

class _NextQustionState extends State<NextQustion> {

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      Timer(const Duration(milliseconds: 500), () {
        Navigator.of(context).pop();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LoadingAnimationWidget.halfTriangleDot(
          color: cardDetailList[widget.index].gradients[0],
          size: 50,
        ),
      ),
    );
  }
}
