import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intelligent_learning/Question/components/card_details.dart';
import 'package:intelligent_learning/Question/components/close_button.dart';
import 'package:intelligent_learning/Question/score_screen.dart';
import 'package:just_audio/just_audio.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:string_similarity/string_similarity.dart';

class QustionsRead extends StatefulWidget {
  final int categoryIndex;
  final List<String> questionsRead;
  final int difficulty;
  const QustionsRead({
    required this.categoryIndex,
    required this.questionsRead,
    required this.difficulty,
  });

  @override
  _QustionsReadState createState() => _QustionsReadState();
}

class _QustionsReadState extends State<QustionsRead> {
  int index = 0, score = 0;
  List<String>? images;
  final player = AudioPlayer();
  stt.SpeechToText? _speech;
  bool _isListening = false;
  String _text = '';
  double _confidence = 1.0;
  List<String> name = [];
  Map<String, String> num = {
    "0": "zero",
    "1": "one",
    "2": "two",
    "3": "three",
    "4": "four",
    "5": "five",
    "6": "six",
    "7": "seven",
    "8": "eight",
    "9": "nine",
  };

  @override
  void initState() {
    images = widget.questionsRead;
    name = List.from(images!);
    for (int i = 0; i < widget.questionsRead.length; i++) {
      name[i] = widget.questionsRead[i].split('/').last.split('.').first;
    }
    _speech = stt.SpeechToText();
    images!.shuffle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(name);
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: AvatarGlow(
          animate: _isListening,
          glowColor: Theme.of(context).primaryColor,
          endRadius: 35.0,
          duration: const Duration(milliseconds: 2000),
          repeatPauseDuration: const Duration(milliseconds: 100),
          repeat: true,
          child: FloatingActionButton(
            onPressed: _listen,
            child: Icon(_isListening ? Icons.mic : Icons.mic_none),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
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
                Center(
                  child: Text(
                      'Confidence: ${(_confidence * 100.0).toStringAsFixed(1)}%'),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Image.asset(
                    images![index],
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {
                          setState(() {
                            if (index < images!.length - 1)
                              index++;
                            else {
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
                          });
                        },
                        icon: Icon(
                          Icons.next_plan_outlined,
                          color: Colors.green,
                        ))
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    images![index].split('/').last.split('.').first,
                    style: const TextStyle(
                      fontSize: 32.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech!.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech!.listen(
          onResult: (val) => setState(() {
            _text = (num.containsKey(val.recognizedWords)
                ? num[val.recognizedWords]
                : val.recognizedWords)!;

            if (val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;
            }
            final bestMatch = _text.bestMatch(name);
            print(name[bestMatch.bestMatchIndex]);
            next(name[bestMatch.bestMatchIndex]);
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech!.stop();
    }
  }

  next(String ans) {
    if (ans.split(' ').first.toLowerCase() ==
        images![index].split('/').last.split('.').first) {
      if (index < images!.length - 1) {
        setState(() {
          _isListening = false;
          index++;
          score++;
          _text = '';
          player.setAsset('assets/audio/game/true.wav');
          player.setVolume(2.0);
          player.play();
        });
      } else if (index >= images!.length - 1) {
        score++;
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
    }
  }
}
