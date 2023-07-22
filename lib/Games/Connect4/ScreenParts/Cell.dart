import 'package:flutter/material.dart';

class Cell extends StatelessWidget {
  final String col;
  const Cell({Key? key, required this.col}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Color c;
    if (col == 'w') {
      c = Colors.white;
    } else if (col == 'o') {
      c = Colors.deepOrangeAccent;
    } else {
      c = Colors.black;
    }
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.13,
          height: MediaQuery.of(context).size.height * 0.065,
          decoration: const BoxDecoration(
            color: Colors.amber,
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.11,
          height: MediaQuery.of(context).size.height * 0.052,
          decoration: BoxDecoration(
              color: c, borderRadius: const BorderRadius.all(Radius.circular(40))),
        ),
      ],
    );
  }
}
