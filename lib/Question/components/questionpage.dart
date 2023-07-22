import 'package:flutter/material.dart';
import 'package:intelligent_learning/Question/components/card_details.dart';
import 'package:intelligent_learning/Question/components/close_button.dart';
import 'package:intelligent_learning/Question/components/list_card.dart';

class QuestionPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
          child: Column(
            children: [
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomCloseButton(),
                ],
              ),
              ListView.builder(
                itemCount: cardDetailList.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ListCard(index);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
