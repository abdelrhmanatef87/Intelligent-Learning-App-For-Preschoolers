import 'package:flutter/material.dart';
import 'package:intelligent_learning/Question/components/card_details.dart';
import 'package:intelligent_learning/Question/components/close_button.dart';
import 'package:intelligent_learning/Question/components/difficulty_tile.dart';

class DifficultyScreen extends StatelessWidget {
  const DifficultyScreen({required this.selectedIndex,});
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: cardDetailList[selectedIndex].gradients,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomCloseButton(),
              ],
            ),
            Text(
              cardDetailList[selectedIndex].title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 35,
              ),
            ),
            Expanded(
              child: Hero(
                tag: cardDetailList[selectedIndex].iconTag,
                child: Image.asset(
                  cardDetailList[selectedIndex].iconAssetName,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(height: 10),
                DifficultyTile(selectedIndex: selectedIndex, difficulty: 0, ),
                const SizedBox(height: 20),
                DifficultyTile(selectedIndex: selectedIndex, difficulty: 1, ),
                const SizedBox(height: 20),
                DifficultyTile(selectedIndex: selectedIndex, difficulty: 2, ),
                const SizedBox(height: 20),
                DifficultyTile(selectedIndex: selectedIndex, difficulty: 3, ),
                const SizedBox(height: 20),
                DifficultyTile(selectedIndex: selectedIndex, difficulty: 4, ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
