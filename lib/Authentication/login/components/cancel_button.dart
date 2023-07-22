import 'package:flutter/material.dart';
import 'package:intelligent_learning/model/color.dart';

class CancelButton extends StatefulWidget {
  const CancelButton({
    Key? key,
    required this.isLogin,
    required this.animationDuration,
    required this.size,
    required this.animationController,
    required this.tapEvent
  }) : super(key: key);

  final bool isLogin;
  final Duration animationDuration;
  final Size size;
  final AnimationController? animationController;
  final GestureTapCallback? tapEvent;

  @override
  State<CancelButton> createState() => _CancelButtonState();
}

class _CancelButtonState extends State<CancelButton> {
  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: widget.isLogin ? 0.0 : 1.0,
      duration: widget.animationDuration,
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          width: widget.size.width,
          height: widget.size.height * 0.1,
          alignment: Alignment.bottomCenter,

          child: IconButton(
            icon: Icon(Icons.close,size: 30,),
            onPressed: widget.tapEvent,
            color: AppColors.darkBlue,
          ),
        ),
      ),
    );
  }
}