import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intelligent_learning/GoogleSheet/user_sheets_api.dart';
import 'package:intelligent_learning/backend/crud.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter/material.dart';
import 'package:fl_score_bar/fl_score_bar.dart';
import 'package:confetti/confetti.dart';
import 'package:intelligent_learning/Question/components/card_details.dart';
import 'package:intelligent_learning/backend/linkapi.dart';
import 'package:intelligent_learning/main.dart';

class ScoreScreen extends StatefulWidget {
  final int score;
  final int index;
  final int numQuestions;
  final int difficulty;
  const ScoreScreen({
    required this.score,
    required this.index,
    required this.numQuestions,
    required this.difficulty,
  });

  @override
  State<ScoreScreen> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  ConfettiController? _controller;
  final player = AudioPlayer();
  CollectionReference userref = FirebaseFirestore.instance.collection('users');
  List users = [];
  Crud _crud = Crud();

  @override
  void initState() {
    readDB();
    super.initState();
    _controller = ConfettiController(
      duration: const Duration(seconds: 3),
    );
    if (widget.score / widget.numQuestions >= 0.5) {
      player.setAsset('assets/audio/game/success.wav');
      player.setVolume(2.0);
      player.play();
      _controller!.play();
    } else {
      player.setAsset('assets/audio/game/tryAgain.wav');
      player.setVolume(2.0);
      player.play();
    }
  }

  readDB() async {
    var response = await userref.where("userid", isEqualTo: FirebaseAuth.instance.currentUser!.uid).get();
    response.docs.forEach((element) {
      users.add(element.data());
    });

    List newScore = users[0]['scores'];
    newScore[widget.index * 5 + widget.difficulty] = widget.score;
    await userref.doc(FirebaseAuth.instance.currentUser!.uid).update({
      "scores": newScore,
    });

    users = [];
    response = await userref.where("userid", isEqualTo: FirebaseAuth.instance.currentUser!.uid).get();
    response.docs.forEach((element) {
      users.add(element.data());
    });

    List<int> Ques1 = [], Ques2 = [], Ques3 = [], Ques4 = [], Ques5 = [];
    int i = 0, j = 0, k = 0, m = 0, n = 0;

    for (int i = 0; i < users[0]['scores'].length; i += 5) {
      Ques1.add(users[0]['scores'][i]);
    }
    for (int i = 1; i < users[0]['scores'].length; i += 5) {
      Ques2.add(users[0]['scores'][i]);
    }
    for (int i = 2; i < users[0]['scores'].length; i += 5) {
      Ques3.add(users[0]['scores'][i]);
    }
    for (int i = 3; i < users[0]['scores'].length; i += 5) {
      Ques4.add(users[0]['scores'][i]);
    }
    for (int i = 4; i < users[0]['scores'].length; i += 5) {
      Ques5.add(users[0]['scores'][i]);
    }

    i = Ques1.fold(0, (p, c) => p + c);
    j = Ques2.fold(0, (p, c) => p + c);
    k = Ques3.fold(0, (p, c) => p + c);
    m = Ques4.fold(0, (p, c) => p + c);
    n = Ques5.fold(0, (p, c) => p + c);

    await UserSheetsApi.updateCell(id: FirebaseAuth.instance.currentUser!.uid, key: 'Choose', value: i);
    await UserSheetsApi.updateCell(id: FirebaseAuth.instance.currentUser!.uid, key: 'Complete', value: j);
    await UserSheetsApi.updateCell(id: FirebaseAuth.instance.currentUser!.uid, key: 'Match', value: k);
    await UserSheetsApi.updateCell(id: FirebaseAuth.instance.currentUser!.uid, key: 'Listen', value: m);
    await UserSheetsApi.updateCell(id: FirebaseAuth.instance.currentUser!.uid, key: 'Read', value: n);
    await _crud.postRequest(linkEditScore, {
      "choose": i.toString(),
      "complete": j.toString(),
      "match": k.toString(),
      "listen": m.toString(),
      "read": n.toString(),
      "id": sharedPref.getString("id"),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: cardDetailList[widget.index].gradients,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconScoreBar(
              scoreIcon: Icons.star_rounded,
              iconColor: Colors.yellow,
              score: widget.score == 10 ? 3 : (widget.score / 3),
              maxScore: 3,
              readOnly: true,
            ),
            const SizedBox(height: 30),
            ConfettiWidget(
              blastDirectionality: BlastDirectionality.explosive,
              confettiController: _controller!,
              particleDrag: 0.05,
              emissionFrequency: 0.05,
              numberOfParticles: 25,
              gravity: 0.05,
              shouldLoop: false,
              colors: const [
                Colors.green,
                Colors.red,
                Colors.yellow,
                Colors.blue,
                Colors.cyan,
                Colors.orange,
                Colors.lightGreenAccent,
                Colors.pinkAccent,
                Colors.lime,
              ],
            ),
            Text(
              '${widget.score.toString()}/${widget.numQuestions}',
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 0.3 * MediaQuery.of(context).size.width,
                height: 0.08 * MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(1, 3),
                      blurRadius: 0.7,
                      color: Colors.grey.withOpacity(0.8),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.exit_to_app,
                  color: cardDetailList[widget.index].textColor,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
