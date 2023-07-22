import 'package:flutter/material.dart';
import 'package:intelligent_learning/model/color.dart';
import 'package:intelligent_learning/model/primary_text.dart';
import 'package:just_audio/just_audio.dart';


class Memory1 extends StatefulWidget {
  @override
  _Memory1State createState() => _Memory1State();
}

class _Memory1State extends State<Memory1> {
  final player = AudioPlayer();
  GameLogic _gameLogic = GameLogic();
  int tries = 0;
  int score = 0;

  @override
  void initState() {
    super.initState();
    _gameLogic.initGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: AppColors.Lpink,
      appBar: AppBar(
          foregroundColor: AppColors.black,
          title: Text('Memory game'),
          actions: [
            FloatingActionButton(
              elevation: 0,
              //backgroundColor: AppColors.Lpink,
              mini: true,
              child: Icon(Icons.refresh, color: AppColors.black),
              onPressed: () {
                setState(() {
                  _gameLogic.initGame();
                  tries = 0;
                  score = 0;
                });
              },
            ),
          ],
          centerTitle: true,
          elevation: 0,
          //backgroundColor: AppColors.Lpink
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 45),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              scoreBoard("Tries", "$tries"),
              scoreBoard("Score", "$score"),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width,
            child: GridView.builder(
                itemCount: _gameLogic.gameImg.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 15.0,
                  mainAxisSpacing: 15.0,
                ),
                padding: const EdgeInsets.all(15),
                itemBuilder: (context, index) {
                  return InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppColors.crimson,
                        image: DecorationImage(
                            image: AssetImage(_gameLogic.gameImg[index]),
                            fit: BoxFit.contain
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: AppColors.crimson,
                            blurRadius: 2,
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        tries++;
                        _gameLogic.gameImg[index] = _gameLogic.cardsList[index];
                        _gameLogic.matchCheck.add({index: _gameLogic.cardsList[index]});
                        print(_gameLogic.matchCheck);
                      });
                      if (_gameLogic.matchCheck.length == 2) {
                        if (_gameLogic.matchCheck[0].values.first == _gameLogic.matchCheck[1].values.first &&
                            _gameLogic.matchCheck[0].keys.first != _gameLogic.matchCheck[1].keys.first) {
                          score += 10;

                          player.setAsset('assets/audio/game/true.wav');
                          player.setVolume(2.0);
                          player.play();
                          _gameLogic.matchCheck.clear();
                        } else {
                          player.setAsset('assets/audio/game/false.wav');
                          player.setVolume(2.0);
                          player.play();

                          Future.delayed(Duration(milliseconds: 500), () {
                            setState(() {
                              _gameLogic.gameImg[_gameLogic.matchCheck[0].keys
                                  .first] = _gameLogic.hiddenCardPath;
                              _gameLogic.gameImg[_gameLogic.matchCheck[1].keys
                                  .first] = _gameLogic.hiddenCardPath;
                              _gameLogic.matchCheck.clear();
                            });
                          });
                        }

                        if (!_gameLogic.gameImg.contains("assets/image/game/hidden.png") && score >= 40) {
                          player.setAsset('assets/audio/game/success.wav');
                          player.setVolume(2.0);
                          player.play();
                          Future.delayed(
                            Duration(seconds: 2),
                            () {
                              //setState(() => score = 0);
                              //setState(() => tries = 0);
                              //setState(() => _gameLogic.initGame());
                              Navigator.of(context).pushNamed('mem2');
                            },
                          );
                        }
                      }
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }
}

Widget scoreBoard(String title, String info) {
  return Expanded(
    child: Container(
      margin: EdgeInsets.all(25.0),
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      decoration: BoxDecoration(
          color: AppColors.white, borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PrimaryText(text: title, fontWeight: FontWeight.w800, size: 22),
          SizedBox(height: 10),
          PrimaryText(text: info, fontWeight: FontWeight.w800, size: 22),
        ],
      ),
    ),
  );
}

class GameLogic {
  final String hiddenCardPath = 'assets/image/game/hidden.png';
  late List<String> gameImg;

  final List<String> cardList1 = [
    "assets/image/game/circle.png",
    "assets/image/game/triangle.png",
    "assets/image/game/heart.png",
    "assets/image/game/star.png",
  ];

  final List<String> cardList2 = [
    "assets/image/game/circle.png",
    "assets/image/game/triangle.png",
    "assets/image/game/heart.png",
    "assets/image/game/star.png",
  ];
  List<String> cardsList = [];

  List<Map<int, String>> matchCheck = [];

  void initGame() {
    gameImg = List.generate(cardList1.length * 2, (index) => hiddenCardPath);
    cardList1.shuffle();
    cardList2.shuffle();
    cardsList=cardList1+cardList2;
  }
}
