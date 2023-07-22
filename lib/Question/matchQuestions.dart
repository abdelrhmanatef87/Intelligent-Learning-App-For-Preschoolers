import 'package:google_fonts/google_fonts.dart';
import 'package:intelligent_learning/Question/components/close_button.dart';
import 'package:intelligent_learning/Question/score_screen.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter/material.dart';
import 'package:intelligent_learning/Question/components/card_details.dart';

class QuestionsMatch extends StatefulWidget {
  final int categoryIndex;
  final List<ItemModel> questionsMatch;
  final int difficulty;
  const QuestionsMatch(
      {required this.categoryIndex,
        required this.questionsMatch,
        required this.difficulty,});

  @override
  _matchMatching createState() => _matchMatching();
}

class _matchMatching extends State<QuestionsMatch> {
  final player = AudioPlayer();
  List<ItemModel> items = [];
  List<ItemModel> items2 = [];
  List<ItemModel> backupItems = [];
  List<ItemModel> backupItems2 = [];
  int score = 0;
  bool? gameOver;

  void initGame() {
    if (items.isEmpty && items2.isEmpty) {
      gameOver = false;
      items = widget.questionsMatch;
      items2 = List<ItemModel>.from(items);
      items.shuffle();
      items2.shuffle();
      backupItems = List<ItemModel>.from(items);
      backupItems2 = List<ItemModel>.from(items2);
    }
  }

  @override
  void initState() {
    super.initState();
    initGame();
  }

  @override
  Widget build(BuildContext context) {
    if (backupItems.length == 0) {
      gameOver = true;
      Future.delayed(Duration.zero, () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ScoreScreen(
              score: score,
              index: widget.categoryIndex,
              numQuestions: widget.questionsMatch.length,
              difficulty: widget.difficulty,
            ),
          ),
        );
      });
    }

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
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Score: ',
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontFamily: 'Pumpkin Story',
                                    ),
                                  ),
                                  TextSpan(
                                    text: '$score',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline2
                                        ?.copyWith(color: Colors.teal),
                                  ),
                                ],
                              ),
                            )),
                        CustomCloseButton2(categoryIndex: widget.categoryIndex),
                      ],
                    ),
                  ),
                  const Divider(
                    //color: Colors.black,
                    thickness: 2,
                    indent: 5,
                    endIndent: 5,
                  ),
                  if (!gameOver!)
                    Row(
                      children: [
                        SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                        Column(
                          children: backupItems.map((item) {
                            return Container(
                              margin: EdgeInsets.all(8),
                              child: Draggable<ItemModel>(
                                data: item,
                                childWhenDragging: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Image.asset(
                                    item.img,
                                    fit: BoxFit.contain,
                                  ),
                                  radius: 50,
                                ),
                                feedback: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Image.asset(
                                    item.img,
                                    fit: BoxFit.contain,
                                  ),
                                  radius: 30,
                                ),
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Image.asset(
                                    item.img,
                                    fit: BoxFit.contain,
                                  ),
                                  radius: 30,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        Spacer(
                          flex: 2,
                        ),
                        Column(
                          children: backupItems2.map((item) {
                            return DragTarget<ItemModel>(
                              onAccept: (receivedItem) {
                                if (item.value == receivedItem.value) {
                                  setState(() {
                                    backupItems.remove(receivedItem);
                                    backupItems2.remove(item);
                                  });
                                  item.accepting = false;
                                  score++;
                                  if (items.length > 0) {
                                    player.setAsset('assets/audio/game/true.wav');
                                    player.setVolume(2.0);
                                    player.play();
                                  }
                                } else {
                                  setState(() {
                                    item.accepting = false;
                                    if (items.length > 0) {
                                      score = score > 0 ? --score : 0;
                                      player.setAsset('assets/audio/game/false.wav');
                                      player.setVolume(2.0);
                                      player.play();
                                    }
                                  });
                                }
                              },
                              onWillAccept: (receivedItem) {
                                setState(() {
                                  item.accepting = true;
                                });
                                return true;
                              },
                              onLeave: (receivedItem) {
                                setState(() {
                                  item.accepting = false;
                                });
                              },
                              builder: (context, acceptedItems, rejectedItems) =>
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: item.accepting
                                          ? Colors.grey[400]
                                          : Colors.grey[200],
                                    ),
                                    alignment: Alignment.center,
                                    height: MediaQuery.of(context).size.width / 6.5,
                                    width: MediaQuery.of(context).size.width / 2.7,
                                    margin: EdgeInsets.all(8),
                                    child: Text(
                                      item.name,
                                      style: Theme.of(context).textTheme.headline6,
                                    ),
                                  ),
                            );
                          }).toList(),
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                      ],
                    ),
                ],
              ),
            ),
          )),
    );
  }
}
