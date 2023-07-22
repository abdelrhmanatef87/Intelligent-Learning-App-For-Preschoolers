import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intelligent_learning/Question/components/close_button.dart';
import 'package:intelligent_learning/Question/score_screen.dart';
import 'package:just_audio/just_audio.dart';

class ColorMatch extends StatefulWidget {
  final int categoryIndex;
  final int difficulty;
  const ColorMatch({
    required this.categoryIndex,
    required this.difficulty,
  });

  @override
  _ColorMatching createState() => _ColorMatching();
}

class _ColorMatching extends State<ColorMatch> {
  final player = AudioPlayer();
  List<ItemModel2> items = [];
  List<ItemModel2> items2 = [];
  int score = 10;
  bool? gameOver;

  void initGame() {
    gameOver = false;
    items = [
      ItemModel2(value: 'Red', name: 'Red', color: Colors.red),
      ItemModel2(value: 'Black', name: 'Black', color: Colors.black),
      ItemModel2(value: 'Blue', name: 'Blue', color: Colors.blue),
      ItemModel2(value: 'Green', name: 'Green', color: Colors.green),
      ItemModel2(value: 'Yellow', name: 'Yellow', color: Colors.yellow),
      ItemModel2(value: 'Brown', name: 'Brown', color: Colors.brown),
      ItemModel2(value: 'Orange', name: 'Orange', color: Colors.orange),
      ItemModel2(value: 'Purple', name: 'Purple', color: Colors.purple),
      ItemModel2(value: 'Grey', name: 'Grey', color: Colors.grey),
      ItemModel2(value: 'White', name: 'White', color: Colors.white),
    ];
    items2 = List<ItemModel2>.from(items);
    items.shuffle();
    items2.shuffle();
  }

  @override
  void initState() {
    super.initState();
    initGame();
  }

  @override
  Widget build(BuildContext context) {
    if (items.length == 0) {
      gameOver = true;
      Future.delayed(Duration.zero, () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ScoreScreen(
              score: score,
              index: widget.categoryIndex,
              numQuestions: items.length,
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
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text.rich(
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
                      ),
                      CustomCloseButton2(categoryIndex: widget.categoryIndex),
                    ],
                  ),
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
                      children: items.map((item) {
                        return Container(
                          margin: EdgeInsets.all(8),
                          child: Draggable<ItemModel2>(
                            data: item,
                            childWhenDragging: Container(
                              padding: EdgeInsets.only(top: 20),
                              height: MediaQuery.of(context).size.width / 6.5,
                              child: Text(
                                item.name,
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            feedback: Container(
                              padding: EdgeInsets.only(top: 20),
                              child: Text(
                                item.name,
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            child: Container(
                              padding: EdgeInsets.only(top: 20),
                              height: MediaQuery.of(context).size.width / 6.5,
                              child: Text(
                                item.name,
                                style: TextStyle(fontSize: 18),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    Spacer(
                      flex: 2,
                    ),
                    Column(
                      children: items2.map((item) {
                        return DragTarget<ItemModel2>(
                          onAccept: (receivedItem) {
                            if (item.value == receivedItem.value) {
                              setState(() {
                                items.remove(receivedItem);
                                items2.remove(item);
                              });
                              item.accepting = false;
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
                                  player
                                      .setAsset('assets/audio/game/false.wav');
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
                                    ? item.color.withOpacity(1)
                                    : item.color,
                                boxShadow: [
                                  item.accepting
                                      ? BoxShadow(
                                          color: item.color.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        )
                                      : BoxShadow(),
                                ]),
                            alignment: Alignment.center,
                            height: MediaQuery.of(context).size.width / 6.5,
                            width: MediaQuery.of(context).size.width / 3,
                            margin: EdgeInsets.symmetric(vertical: 8),
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

class ItemModel2 {
  final String name;
  final String value;
  Color color;
  bool accepting;
  ItemModel2(
      {required this.name,
      required this.value,
      required this.color,
      this.accepting = false});
}
