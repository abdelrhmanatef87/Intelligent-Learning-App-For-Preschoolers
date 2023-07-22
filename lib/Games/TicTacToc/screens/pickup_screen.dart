import 'package:flutter/material.dart';
import 'package:intelligent_learning/Games/TicTacToc/widgets/container_widget.dart';
import 'package:intelligent_learning/Games/TicTacToc/constants.dart';
import 'package:intelligent_learning/Games/TicTacToc/widgets/parent_column.dart';
import 'package:intelligent_learning/Games/TicTacToc/widgets/reusable_button.dart';
import 'package:intelligent_learning/Games/TicTacToc/screens/game_screen.dart';
import 'package:intelligent_learning/Games/TicTacToc/Models/UiLogic.dart';
import 'package:intelligent_learning/Games/TicTacToc/widgets/wp_screen_text_widget.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class PickUpScreen extends StatefulWidget {

  @override
  _PickUpScreenState createState() => _PickUpScreenState();
}

class _PickUpScreenState extends State<PickUpScreen> {

  @override
  void initState() {
    ui.colorsAndSide();
    super.initState();
  }

  void updateColor(letter selectedLetter) =>  ui.updateColor(selectedLetter);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGameScreenBackgroundColor,
      appBar: AppBar(
        backgroundColor: kGameScreenBackgroundColor,
        actions: [
          IconButton(onPressed: (){
            Alert(
                style: AlertStyle(
                  backgroundColor: Color(0xFF9b70e5),
                  alertPadding: EdgeInsets.symmetric(horizontal: 25.0),
                ),
                context: context,
                content: COLUMNWIDGET(),
                buttons: [
                  DialogButton(
                    onPressed: (){Navigator.pop(context);},
                    child: Text(
                      "Done",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ]).show();
          }, icon: Icon(Icons.view_headline,
            size: 30.0,),)
        ],
        title: Center(child: TextWidget(text: "TIC TAC TOE", fontSize: 30.0,)),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: TextWidget(text: 'Choose a side',fontSize: 30.0,fontWeight: FontWeight.w500,)
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: (){
                  setState(() {
                    updateColor(letter.cardX);
                    UI.side = "X";
                  });
                },
                child: ContainerWidget(
                  color: UI.xCardColor, text: "X",
                  textColor: UI.xTextColor,
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: (){
                  setState(() {
                    updateColor(letter.cardO);
                    UI.side = "O";
                  });
                },
                child: ContainerWidget(
                  color: UI.oCardColor, text: "O",
                  textColor: UI.oTextColor,
                ),
              ),
            ),
            // Button Code
            ReusableButton(
              onTap: (){
                ui.remainingVars();
                ui.setWinningVariables();
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => GameScreen(chosenLetter: UI.side,),
                ));
              },
              text: 'Start',
            )
          ],
        ),
      ),
    );
  }
}