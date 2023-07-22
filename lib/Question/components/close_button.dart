import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intelligent_learning/Question/components/card_details.dart';

class CustomCloseButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black26),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(
          Icons.close_rounded,
          //color: Colors.transparent,
          size: 30,
        ),
      ),
    );
  }
}

class CustomCloseButton1 extends StatefulWidget {
  final CountDownController controller;
  final int categoryIndex;
  const CustomCloseButton1({ required this.controller, required this.categoryIndex});

  @override
  State<CustomCloseButton1> createState() => _CustomCloseButton1State();
}

class _CustomCloseButton1State extends State<CustomCloseButton1> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: cardDetailList[widget.categoryIndex].gradients[0]),
      ),
      child: GestureDetector(
        onTap: () async{
          widget.controller.pause();
          await showDialog<bool>(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                insetPadding: EdgeInsets.zero,
                contentTextStyle: GoogleFonts.mulish(),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                title: const Text('Quit Quiz?'),
                content: const Text(
                  'Are you sure you want exit!',
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                      Navigator.pop(context, false);
                      // Navigator.pushReplacement(context,
                      //     MaterialPageRoute(builder: (context) => exit(0)));
                    },
                    child: const Text(
                      'Yes',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                      widget.controller.resume();
                    },
                    child: const Text('No'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(
          Icons.close_rounded,
          //color: Colors.transparent,
          size: 30,
        ),
      ),
    );
  }
}



class CustomCloseButton2 extends StatefulWidget {
  final int categoryIndex;

  const CustomCloseButton2({ required this.categoryIndex});

  @override
  State<CustomCloseButton2> createState() => _CustomCloseButton2State();
}

class _CustomCloseButton2State extends State<CustomCloseButton2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: cardDetailList[widget.categoryIndex].gradients[0]),

      ),
      child: GestureDetector(
        onTap: () async{
          await showDialog<bool>(
            context: context,
            //barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                insetPadding: EdgeInsets.zero,
                contentTextStyle: GoogleFonts.mulish(),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                title: const Text('Quit Quiz?'),
                content: const Text(
                  'Are you sure you want exit!',
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                      Navigator.pop(context, false);
                      // Navigator.pushReplacement(context,
                      //     MaterialPageRoute(builder: (context) => exit(0)));
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
        child: const Icon(
          Icons.close_rounded,
          //color: Colors.transparent,
          size: 30,
        ),
      ),
    );
  }
}
