import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:get_it/get_it.dart';
import 'package:intelligent_learning/Games/FlappyBird/game_manager.dart';

GetIt getIt = GetIt.instance;
class ScoreDisplay extends TextComponent with HasGameRef {
  ScoreDisplay()
      : super(
          text: 'Score: 0',
          priority: 10,
          textRenderer: TextPaint(
            style: const TextStyle(
              fontSize: 24.0,
              package: 'GoogleFonts',
              fontFamily: 'Lobster',
              color: Color.fromARGB(255, 1, 74, 111),
            ),
          ),
        );

  @override
  void update(double dt) {
    int score = getIt<GameManager>().score;
    super.text = 'Score\n${score.toString()}';
  }

  Future<void> onLoad() async {
    super.onLoad();

    super.anchor = Anchor.topRight;
    super.x = gameRef.size.x - 15;
    super.y = 15.0;
  }
}
