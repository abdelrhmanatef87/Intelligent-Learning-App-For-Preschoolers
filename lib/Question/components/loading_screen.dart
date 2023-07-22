import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intelligent_learning/Question/Animals/complete.dart';
import 'package:intelligent_learning/Question/Animals/match.dart';
import 'package:intelligent_learning/Question/Animals/mcq.dart';
import 'package:intelligent_learning/Question/Animals/voice.dart';
import 'package:intelligent_learning/Question/Body/complete.dart';
import 'package:intelligent_learning/Question/Body/match.dart';
import 'package:intelligent_learning/Question/Body/mcq.dart';
import 'package:intelligent_learning/Question/Body/voice.dart';
import 'package:intelligent_learning/Question/Car/complete.dart';
import 'package:intelligent_learning/Question/Car/match.dart';
import 'package:intelligent_learning/Question/Car/mcq.dart';
import 'package:intelligent_learning/Question/Car/voice.dart';
import 'package:intelligent_learning/Question/Clothes/complete.dart';
import 'package:intelligent_learning/Question/Clothes/match.dart';
import 'package:intelligent_learning/Question/Clothes/mcq.dart';
import 'package:intelligent_learning/Question/Clothes/voice.dart';
import 'package:intelligent_learning/Question/Colors/colorMatch.dart';
import 'package:intelligent_learning/Question/Colors/complete.dart';
import 'package:intelligent_learning/Question/Colors/mcq.dart';
import 'package:intelligent_learning/Question/Colors/voice.dart';
import 'package:intelligent_learning/Question/Country/complete.dart';
import 'package:intelligent_learning/Question/Country/match.dart';
import 'package:intelligent_learning/Question/Country/mcq.dart';
import 'package:intelligent_learning/Question/Country/voice.dart';
import 'package:intelligent_learning/Question/Fruits/complete.dart';
import 'package:intelligent_learning/Question/Fruits/match.dart';
import 'package:intelligent_learning/Question/Fruits/mcq.dart';
import 'package:intelligent_learning/Question/Fruits/voice.dart';
import 'package:intelligent_learning/Question/General/complete.dart';
import 'package:intelligent_learning/Question/General/match.dart';
import 'package:intelligent_learning/Question/General/mcq.dart';
import 'package:intelligent_learning/Question/General/voice.dart';
import 'package:intelligent_learning/Question/Numbers/complete.dart';
import 'package:intelligent_learning/Question/Numbers/match.dart';
import 'package:intelligent_learning/Question/Numbers/mcq.dart';
import 'package:intelligent_learning/Question/Numbers/voice.dart';
import 'package:intelligent_learning/Question/Vegetables/complete.dart';
import 'package:intelligent_learning/Question/Vegetables/match.dart';
import 'package:intelligent_learning/Question/Vegetables/mcq.dart';
import 'package:intelligent_learning/Question/Vegetables/voice.dart';
import 'package:intelligent_learning/Question/completeQuestions.dart';
import 'package:intelligent_learning/Question/components/card_details.dart';
import 'package:intelligent_learning/Question/components/questionpage.dart';
import 'package:intelligent_learning/Question/matchQuestions.dart';
import 'package:intelligent_learning/Question/mcqQuestions.dart';
import 'package:intelligent_learning/Question/listenQuetions.dart';
import 'package:intelligent_learning/Question/readQuetions.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingScreen extends StatefulWidget {
  final int index;
  final String selectedDif;
  final int difficulty;
  const LoadingScreen({required this.index, required this.selectedDif, required this.difficulty,});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      Timer(const Duration(seconds: 1), () {
        getQuestions();
      });
    });
  }

  getQuestions(){
    Navigator.pushReplacement(context,
    MaterialPageRoute(
      builder: ((context) => page()),
    ),);
  }

  page(){
    switch(widget.index*5 + widget.difficulty){
      case 0:
        return QuestionsMcq(categoryIndex: widget.index, questionsMcq: QuestionAnimalDataMcq().questions, difficulty: widget.difficulty, chooses: QuestionAnimalDataMcq().animalNames,);
      case 1:
        return QustionsComplete(categoryIndex: widget.index, questionsComplete: animal_complete, difficulty: widget.difficulty,);
      case 2:
        return QuestionsMatch(categoryIndex: widget.index, questionsMatch: animalMatch, difficulty: widget.difficulty,);
      case 3:
        return QuestionsListen(categoryIndex: widget.index, quetionsListen: QuestionAnimalDataVoice().questions, difficulty: widget.difficulty, );
      case 4:
        return QustionsRead(categoryIndex: widget.index, questionsRead: animal_complete, difficulty: widget.difficulty, );

      case 5:
        return QuestionsMcq(categoryIndex: widget.index, questionsMcq: QuestionFruitDataMcq().questions, difficulty: widget.difficulty, chooses: QuestionFruitDataMcq().fruitNames,);
      case 6:
        return QustionsComplete(categoryIndex: widget.index, questionsComplete: fruit_complete, difficulty: widget.difficulty, );
      case 7:
        return QuestionsMatch(categoryIndex: widget.index, questionsMatch: fruitMatch, difficulty: widget.difficulty,);
      case 8:
        return QuestionsListen(categoryIndex: widget.index, quetionsListen: QuestionFruitDataVoice().questions, difficulty: widget.difficulty, );
      case 9:
        return QustionsRead(categoryIndex: widget.index, questionsRead: fruit_complete, difficulty: widget.difficulty, );

      case 10:
        return QuestionsMcq(categoryIndex: widget.index, questionsMcq: QuestionVegetableDataMcq().questions, difficulty: widget.difficulty, chooses: QuestionVegetableDataMcq().vegetableNames,);
      case 11:
        return QustionsComplete(categoryIndex: widget.index, questionsComplete: vegetable_complete, difficulty: widget.difficulty, );
      case 12:
        return QuestionsMatch(categoryIndex: widget.index, questionsMatch: vegetableMatch, difficulty: widget.difficulty,);
      case 13:
        return QuestionsListen(categoryIndex: widget.index, quetionsListen: QuestionVegetableDataVoice().questions, difficulty: widget.difficulty, );
      case 14:
        return QustionsRead(categoryIndex: widget.index, questionsRead: vegetable_complete, difficulty: widget.difficulty, );

      case 15:
        return QuestionsMcq(categoryIndex: widget.index, questionsMcq: QuestionBodyDataMcq().questions, difficulty: widget.difficulty, chooses: QuestionBodyDataMcq().bodyPartNames,);
      case 16:
        return QustionsComplete(categoryIndex: widget.index, questionsComplete: body_complete, difficulty: widget.difficulty, );
      case 17:
        return QuestionsMatch(categoryIndex: widget.index, questionsMatch: bodyMatch, difficulty: widget.difficulty, );
      case 18:
        return QuestionsListen(categoryIndex: widget.index, quetionsListen: QuestionBodyDataVoice().questions, difficulty: widget.difficulty, );
      case 19:
        return QustionsRead(categoryIndex: widget.index, questionsRead: body_complete, difficulty: widget.difficulty, );

      case 20:
        return QuestionsMcq(categoryIndex: widget.index, questionsMcq: QuestionNumberDataMcq().questions, difficulty: widget.difficulty, chooses: QuestionNumberDataMcq().numberNames,);
      case 21:
        return QustionsComplete(categoryIndex: widget.index, questionsComplete: number_complete, difficulty: widget.difficulty,);
      case 22:
        return QuestionsMatch(categoryIndex: widget.index, questionsMatch: numberMatch, difficulty: widget.difficulty, );
      case 23:
        return QuestionsListen(categoryIndex: widget.index, quetionsListen: QuestionNumberDataVoice().questions, difficulty: widget.difficulty, );
      case 24:
        return QustionsRead(categoryIndex: widget.index, questionsRead: number_complete, difficulty: widget.difficulty, );

      case 25:
        return QuestionsMcq(categoryIndex: widget.index, questionsMcq: QuestionCarDataMcq().questions, difficulty: widget.difficulty, chooses: QuestionCarDataMcq().vehicleNames,);
      case 26:
        return QustionsComplete(categoryIndex: widget.index, questionsComplete: car_complete, difficulty: widget.difficulty, );
      case 27:
        return QuestionsMatch(categoryIndex: widget.index, questionsMatch: carMatch, difficulty: widget.difficulty, );
      case 28:
        return QuestionsListen(categoryIndex: widget.index, quetionsListen: QuestionCarDataVoice().questions, difficulty: widget.difficulty, );
      case 29:
        return QustionsRead(categoryIndex: widget.index, questionsRead: car_complete, difficulty: widget.difficulty, );

      case 30:
        return QuestionsMcq(categoryIndex: widget.index, questionsMcq: QuestionColorDataMcq().questions, difficulty: widget.difficulty, chooses: QuestionColorDataMcq().colorNames,);
      case 31:
        return QustionsComplete(categoryIndex: widget.index, questionsComplete: color_complete, difficulty: widget.difficulty, );
      case 32:
        return ColorMatch(categoryIndex: widget.index, difficulty: widget.difficulty, );
      case 33:
        return QuestionsListen(categoryIndex: widget.index, quetionsListen: QuestionColorDataVoice().questions, difficulty: widget.difficulty, );
      case 34:
        return QustionsRead(categoryIndex: widget.index, questionsRead: color_complete, difficulty: widget.difficulty, );

      case 35:
        return QuestionsMcq(categoryIndex: widget.index, questionsMcq: QuestionClothesDataMcq().questions, difficulty: widget.difficulty, chooses: QuestionClothesDataMcq().clothingNames,);
      case 36:
        return QustionsComplete(categoryIndex: widget.index, questionsComplete: clothes_complete, difficulty: widget.difficulty, );
      case 37:
        return QuestionsMatch(categoryIndex: widget.index, questionsMatch: clothesMatch, difficulty: widget.difficulty, );
      case 38:
        return QuestionsListen(categoryIndex: widget.index, quetionsListen: QuestionClothesDataVoice().questions, difficulty: widget.difficulty, );
      case 39:
        return QustionsRead(categoryIndex: widget.index, questionsRead: clothes_complete, difficulty: widget.difficulty, );

      case 40:
        return QuestionsMcq(categoryIndex: widget.index, questionsMcq: QuestionCountryDataMcq().questions, difficulty: widget.difficulty, chooses: QuestionCountryDataMcq().countryNames,);
      case 41:
        return QustionsComplete(categoryIndex: widget.index, questionsComplete: country_complete, difficulty: widget.difficulty, );
      case 42:
        return QuestionsMatch(categoryIndex: widget.index, questionsMatch: countryMatch, difficulty: widget.difficulty, );
      case 43:
        return QuestionsListen(categoryIndex: widget.index, quetionsListen: QuestionCountryDataVoice().questions, difficulty: widget.difficulty, );
      case 44:
        return QustionsRead(categoryIndex: widget.index, questionsRead: country_complete, difficulty: widget.difficulty, );

      case 45:
        return QuestionsMcq(categoryIndex: widget.index, questionsMcq: QuestionGeneralDataMcq().questions, difficulty: widget.difficulty, chooses: QuestionGeneralDataMcq().itemNames,);
      case 46:
        return QustionsComplete(categoryIndex: widget.index, questionsComplete: general_complete, difficulty: widget.difficulty, );
      case 47:
        return QuestionsMatch(categoryIndex: widget.index, questionsMatch: generalMatch, difficulty: widget.difficulty,);
      case 48:
        return QuestionsListen(categoryIndex: widget.index, quetionsListen: QuestionGeneralDataVoice().questions, difficulty: widget.difficulty,);
      case 49:
        return QustionsRead(categoryIndex: widget.index, questionsRead: general_complete, difficulty: widget.difficulty,);

      default:
        return QuestionPage();
    }
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
        body: Center(
          child: LoadingAnimationWidget.halfTriangleDot(
            color: Colors.white,
            size: 50,
          ),
        ),
      ),
    );
  }
}
