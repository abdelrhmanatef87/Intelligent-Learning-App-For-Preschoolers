import 'package:flutter/material.dart';
import 'package:intelligent_learning/Games/Connect4/Connect4Screen.dart';
import 'package:intelligent_learning/Games/Connect4/ScreenParts/Bar.dart';
import 'package:intelligent_learning/Games/Connect4/ScreenParts/Startedcoin.dart';

class Welcome extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
        title: const Text(
          "Connect 4 ",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              onPressed: () {
                coin = [
                  ['w', 'w', 'w', 'w', 'w', 'w', 'w'],
                  ['w', 'w', 'w', 'w', 'w', 'w', 'w'],
                  ['w', 'w', 'w', 'w', 'w', 'w', 'w'],
                  ['w', 'w', 'w', 'w', 'w', 'w', 'w'],
                  ['w', 'w', 'w', 'w', 'w', 'w', 'w'],
                  ['w', 'w', 'w', 'w', 'w', 'w', 'w']
                ];
                checkk = start_coin;

                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const Connect4Screen();
                }));
              },
              child: const Text(
                "Let’s Go",
                style: TextStyle(color: Colors.black),
              ),
              color: Colors.deepOrange,
            ),
            const SizedBox(
              height: 15,
            ),
            MaterialButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Started_coin();
                }));
              },
              child: const Text(
                "Which coin will start",
                style: TextStyle(color: Colors.black),
              ),
              color: Colors.deepOrange,
            ),
          ],
        ),
      ),
    );
  }
}
