import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intelligent_learning/Question/components/card_details.dart';
import 'package:intelligent_learning/Question/components/close_button.dart';
import 'package:intelligent_learning/Question/score_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:just_audio/just_audio.dart';

class QustionsComplete extends StatefulWidget {
  final int categoryIndex;
  final List<String> questionsComplete;
  final int difficulty;
  const QustionsComplete({
    required this.categoryIndex,
    required this.questionsComplete,
    required this.difficulty,
  });

  @override
  _QustionsCompleteState createState() => _QustionsCompleteState();
}

class _QustionsCompleteState extends State<QustionsComplete> {
  int index = 0, clickHint = 0, score = 0, tries = 0;
  String correctAnswer = "", suggest = "";
  Map<int, int> correctAnswerKey = new Map();
  Map<int, int> showSuggestAnswerMap = new Map();
  Map<int, bool> showCorrectAnswerMap = new Map();
  List<String>? images;
  bool flag = true;
  final player = AudioPlayer();

  @override
  void initState() {
    images = widget.questionsComplete;
    images!.shuffle();
    super.initState();
    startGame();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
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
        return shouldPop!;
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      color: cardDetailList[widget.categoryIndex]
                          .gradients[1]
                          .withOpacity(0.5),
                    ),
                    child: Text(
                      'Score: $score',
                      style: const TextStyle(
                        fontSize: 30,
                        fontFamily: 'Pumpkin Story',
                      ),
                    ),
                  ),
                  CustomCloseButton2(categoryIndex: widget.categoryIndex),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text('Question num: ${index + 1} / ${images!.length}',
                  style: TextStyle(
                    fontSize: 35,
                    fontFamily: 'Pumpkin Story',
                  )),
              Expanded(
                  flex: 4,
                  child: Image.asset(
                    images![index],
                    fit: BoxFit.contain,
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(Icons.help,
                        size: 25,
                        color:
                            cardDetailList[widget.categoryIndex].gradients[1]),
                    onPressed: () {
                      if (clickHint < 3) {
                        int? hint;
                        for (var i in showCorrectAnswerMap.entries) {
                          if (i.value == false) {
                            showCorrectAnswerMap[i.key] = true;
                            hint = correctAnswerKey[i.key]!;
                            break;
                          }
                        }
                        var list = suggest.runes.toList();
                        for (int i = 0; i < list.length; i++) {
                          if (list[i] == hint) {
                            if (showSuggestAnswerMap[i] != 1) {
                              showSuggestAnswerMap[i] = 1;
                              break;
                            } else {
                              continue;
                            }
                          }
                        }
                        setState(() {
                          clickHint++;
                        });
                      } else {
                        Fluttertoast.showToast(
                            msg: "You only have 3 times",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor:
                                cardDetailList[widget.categoryIndex]
                                    .gradients[1]
                                    .withOpacity(0.9),
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    },
                  ),
                ],
              ),
              Expanded(
                  flex: 2,
                  child: GridView.builder(
                      itemCount: correctAnswer.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 8),
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          color: Colors.black,
                          child: showCorrectAnswerMap[index] == true
                              ? Center(
                                  child: Text(
                                    String.fromCharCode(
                                        correctAnswerKey[index]!),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                )
                              : Container(),
                        );
                      })),
              Expanded(
                  flex: 3,
                  child: GridView.builder(
                      itemCount: suggest.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 8),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: !flag
                              ? null
                              : () {
                                  if (correctAnswer
                                      .toUpperCase()
                                      .contains(suggest[index].toUpperCase())) {
                                    correctAnswerKey.forEach((key, value) {
                                      if (String.fromCharCode(value)
                                              .toUpperCase() ==
                                          suggest[index].toUpperCase()) {
                                        setState(() {
                                          showCorrectAnswerMap[key] = true;
                                          showSuggestAnswerMap[index] = 1;
                                          if (!showCorrectAnswerMap.values
                                              .contains(false)) flag = false;
                                        });
                                      }
                                    });
                                  } else {
                                    setState(() {
                                      showSuggestAnswerMap[index] = 0;
                                      tries++;
                                      print(tries);
                                    });
                                  }
                                },
                          child: Card(
                            color: showSuggestAnswerMap[index] == -1
                                ? Colors.blueGrey
                                : showSuggestAnswerMap[index] == 0
                                    ? Colors.red
                                    : Colors.green,
                            child: Center(
                              child: showSuggestAnswerMap[index] == 1
                                  ? const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                    )
                                  : showSuggestAnswerMap[index] == 0
                                      ? const Icon(
                                          Icons.clear,
                                        )
                                      : Text(
                                          suggest[index],
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                            ),
                          ),
                        );
                      })),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: showCorrectAnswerMap.values.contains(false)
                      ? null
                      : () {
                          setState(() {
                            tries > 2 ? score : score++;
                            if (index < images!.length - 1) {
                              index++;
                              flag = true;
                              tries > 2
                                  ? player
                                      .setAsset('assets/audio/game/false.wav')
                                  : player
                                      .setAsset('assets/audio/game/true.wav');
                              player.setVolume(2.0);
                              player.play();
                            } else {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ScoreScreen(
                                    score: score,
                                    index: widget.categoryIndex,
                                    numQuestions: images!.length,
                                    difficulty: widget.difficulty,
                                  ),
                                ),
                              );
                            }
                            clickHint = 0;
                            tries = 0;
                          });
                          startGame();
                        },
                  child: const Text('NEXT'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void startGame() {
    correctAnswer = suggest = "";
    showCorrectAnswerMap.clear();
    showSuggestAnswerMap.clear();
    correctAnswerKey = new Map();

    correctAnswer = images![index]
        .substring(images![index].lastIndexOf('/') + 1,
            images![index].lastIndexOf('.'))
        .toUpperCase();

    correctAnswerKey = correctAnswer.runes.toList().asMap();
    correctAnswerKey.forEach((key, value) {
      showCorrectAnswerMap.putIfAbsent(key, () => false);
    });

    suggest = randomWithAnswer(correctAnswer).toUpperCase();

    var list = suggest.runes.toList();
    list.shuffle();
    list.asMap().forEach((key, value) {
      showSuggestAnswerMap.putIfAbsent(key, () => -1);
    });
    suggest = String.fromCharCodes(list);
    setState(() {});
  }

  String randomWithAnswer(String correctAnswer) {
    const aToZ = 'abcdefghijklmnopqrstuvwxyz';
    int originalLenght = correctAnswer.length;
    var randomText = "";
    for (int i = 0; i < originalLenght; i++) {
      randomText += aToZ[Random().nextInt(aToZ.length)];
    }
    randomText = String.fromCharCodes(randomText.runes.toSet().toList());
    correctAnswer += randomText;
    return correctAnswer;
  }
}
