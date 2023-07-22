import 'package:just_audio/just_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intelligent_learning/Question/components/card_details.dart';
import 'package:intelligent_learning/Question/components/close_button.dart';
import 'package:intelligent_learning/Question/score_screen.dart';


class QuestionsListen extends StatefulWidget {
  final int categoryIndex;
  final List quetionsListen;
  final int difficulty;
  const QuestionsListen({Key? key, required this.categoryIndex, required this.quetionsListen, required this.difficulty,}) : super(key: key);

  @override
  State<QuestionsListen> createState() => _QuestionsListenState();
}

class _QuestionsListenState extends State<QuestionsListen> {
  List questions =[] ;
  int index = 0;
  int score = 0;
  final player = AudioPlayer();


  @override
  void initState() {
    questions= widget.quetionsListen;
    questions.shuffle();
    super.initState();
  }

  Future<void> nextQuestion() async {
     if (index < questions.length - 1) {
      index++;
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
    questions[index].imagePath.shuffle();
    final question = questions[index];
    playsound(question.voicePath);
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
        body: Container(
          height: MediaQuery.of(context).size.height * 1,
          margin: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                height: 10,
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

                  CustomCloseButton2(categoryIndex: widget.categoryIndex),
                ],
              ),
              Text('Question num: ${index + 1} / ${questions.length}',
                  style: TextStyle(fontSize: 40, fontFamily: 'Pumpkin Story', )
              ),
              SizedBox(
                child: IconButton(
                  icon: const Icon(Icons.volume_up),
                iconSize: 40,
                color: Colors.blue,
                onPressed: (){
                    playsound(question.voicePath);
                  },
                )
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ButtonChoice(Colors.red, 0),
                      ButtonChoice(Colors.green, 1),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ButtonChoice(Colors.blue, 2),
                      ButtonChoice(Colors.orange, 3),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox ButtonChoice(Color col, int ListIndex) {
    return SizedBox(
      height: MediaQuery.of(context).size.width*0.52,
      width: MediaQuery.of(context).size.width*0.474,
      child: GridView.builder(
        itemCount: 1,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 1.1,
        ),
        itemBuilder: (context, ind)=>cardsStyle(questions[index].imagePath, ListIndex, col),
      ),
    );
  }

  Widget cardsStyle(List<String> imagePath, int ListIndex, Color c) {
    return InkWell(
      onTap: () => {
        setState(() {
              if (questions[index].answer == questions[index].imagePath[ListIndex]) {
                score += 1;
                if(index<questions.length-1) {
                  player.setAsset('assets/audio/game/true.wav');
                  player.setVolume(2.0);
                  player.play();
                }
              }
              else{
                if(index<questions.length-1) {
                  player.setAsset('assets/audio/game/false.wav');
                  player.setVolume(2.0);
                  player.play();
                }
              }
                nextQuestion();
          },
        ),
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10, bottom: 10, left: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white.withOpacity(0.9),
            boxShadow: const [
              BoxShadow(
                //color: AppColors.secondary,
                blurRadius: 2,
              )
            ]),
        child: Container(
            color: Colors.transparent,
            child: Image.asset(imagePath[ListIndex], fit: BoxFit.contain)),
      ),
    );
  }

  void playsound(String imageVoice) async {
    FlutterTts ftts = FlutterTts();
    await ftts.setLanguage("en-US");
    await ftts.setSpeechRate(0.3); //speed of speech
    await ftts.setVolume(1.0); //volume of speech
    await ftts.setPitch(1.0); //pitc of sound 0.5 to 1.5
    await ftts.speak(imageVoice);
  }
}
