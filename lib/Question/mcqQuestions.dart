import 'dart:math';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:just_audio/just_audio.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:intelligent_learning/Question/components/card_details.dart';
import 'package:intelligent_learning/Question/components/close_button.dart';
import 'package:intelligent_learning/Question/nextQuestion.dart';
import 'package:intelligent_learning/Question/score_screen.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';


class QuestionsMcq extends StatefulWidget {
  final int categoryIndex;
  final List questionsMcq;
  final int difficulty;
  final List<String> chooses;
  const QuestionsMcq({ required this.categoryIndex, required this.questionsMcq, required this.difficulty, required this.chooses, });

  @override
  State<QuestionsMcq> createState() => _QuestionsMcqState();
}

class _QuestionsMcqState extends State<QuestionsMcq> {
  List questions = [];
  List<String> randomChoose =[];
  String answer='';
  int index = 0;
  int score = 0;
  final int duration = 10;
  final CountDownController _controller = CountDownController();
  final player = AudioPlayer();

  @override
  void initState() {
    questions = widget.questionsMcq;
    questions.shuffle();
    super.initState();
  }

  void nextQuestion(bool f) async{
    f? await Future.delayed(Duration(seconds: 1)):null;
    if (index < questions.length - 1) {
      await Navigator.push(context,
        MaterialPageRoute(
          builder: ((context) => NextQustion(index: widget.categoryIndex,)),
        ),);
      index++;
      _controller.restart(duration:  10);
      setState(() {});
    } else {
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ScoreScreen(
            score: score,
            index: widget.categoryIndex,
            numQuestions: questions.length,
            difficulty: widget.difficulty,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    randomChoose = [];
    questions[index].choice.shuffle();
    final question = questions[index];
    randomChoose.add(question.answer);

    while (randomChoose.length < 4) {
      String item = widget.chooses[Random().nextInt(widget.chooses.length)];
      if (!randomChoose.contains(item)) {
        randomChoose.add(item);
      }
    }
    randomChoose.shuffle();

    return WillPopScope(
      onWillPop: () async {
       _controller.pause();
        final shouldPop = await showDialog<bool>(
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
                  },
                  child: const Text(
                    'Yes',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                    _controller.resume();
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
        body: Container(
          height: MediaQuery.of(context).size.height * 1,
          margin: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10.0), ),
                      color: cardDetailList[widget.categoryIndex].gradients[1].withOpacity(0.5),
                    ),
                    child: Text(
                      'Score: $score',
                      style: const TextStyle(fontSize: 30, fontFamily: 'Pumpkin Story',),
                    ),
                  ),
                  CircularCountDownTimer(
                    width: 50,
                    height: 50,
                    duration: duration,
                    fillColor: Colors.grey,
                    ringColor: Colors.pink,
                    textStyle: const TextStyle(
                      fontSize: 25,
                      color: Colors.pink,
                      fontWeight: FontWeight.bold,
                    ),
                    autoStart: true,
                    isReverse: true,
                    controller: _controller,
                    onComplete: () {
                      Fluttertoast.showToast(
                          msg: "correct: ${questions[index].answer}",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: cardDetailList[widget.categoryIndex].gradients[1],
                          textColor: Colors.white,
                          fontSize: 16.0);
                      if (index < questions.length-1) {
                        setState(() {
                          player.setAsset('assets/audio/game/false.wav');
                          player.setVolume(2.0);
                          player.play();
                          nextQuestion(true);
                        });
                        _controller.restart();
                      } else {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ScoreScreen(
                              score: score,
                              index: widget.categoryIndex,
                              numQuestions: questions.length,
                              difficulty: widget.difficulty,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  CustomCloseButton1(controller: _controller, categoryIndex: widget.categoryIndex),
                ],
              ),
              Text('Question num: ${index + 1} / ${questions.length}',
                  style: const TextStyle(fontSize: 40, fontFamily: 'Pumpkin Story', ),
              ),
              SizedBox(
                height: 350,
                width: 350,
                child: Image.asset(
                  question.imagePath,
                  fit: BoxFit.contain,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ButtonChoice(Colors.red, 0),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.005,
                  ),
                  ButtonChoice(Colors.green, 1),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ButtonChoice(Colors.blue, 2),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.005,
                  ),
                  ButtonChoice(Colors.orange, 3),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  SizedBox ButtonChoice(Color col, int ListIndex) {
    return SizedBox(
      height: 60,
      width: MediaQuery.of(context).size.width * 0.41,
      child: NeumorphicButton(
        onPressed: () {
          bool f = false;
          setState(() {
            answer = questions[index].answer;
            if (answer == randomChoose[ListIndex]) {
              score += 1;
              f = false;
              if (index < questions.length - 1) {
                // Play a positive sound effect
                player.setAsset('assets/audio/game/true.wav');
                player.setVolume(2.0);
                player.play();
              }
            } else {
              Fluttertoast.showToast(
                msg: "Correct answer: $answer",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: cardDetailList[widget.categoryIndex].gradients[1],
                textColor: Colors.white,
                fontSize: 16.0,
              );
              if (index < questions.length - 1) {
                // Play a negative sound effect
                player.setAsset('assets/audio/game/false.wav');
                player.setVolume(2.0);
                player.play();
              }
              f = true;
            }
            _controller.restart();
          });
          nextQuestion(f);
        },
        style: NeumorphicStyle(
          shape: NeumorphicShape.concave, // Use concave shape for a softer look
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(30.0)),
          depth: 10, // Control the depth of the 3D effect
          intensity: 0.8, // Control the intensity of the shadow
          lightSource: LightSource.topLeft,
          color: col,
        ),
        child: Center(
          child: Text(
            randomChoose[ListIndex],
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
