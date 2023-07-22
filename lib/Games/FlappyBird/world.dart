import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:intelligent_learning/Games/FlappyBird/game.dart';

class World extends ParallaxComponent<FlappyDash> {
  @override
  Future<void> onLoad() async {
    parallax = await gameRef.loadParallax(
      [
        ParallaxImageData('flappybird/bg5.png'),
      ],
      baseVelocity: Vector2(150, 0),
      velocityMultiplierDelta: Vector2(1.8, 1.0),
    );
  }
}
