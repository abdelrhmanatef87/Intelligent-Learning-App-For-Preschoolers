import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:get_it/get_it.dart';
import 'package:intelligent_learning/Games/FlappyBird/game_manager.dart';


GetIt getIt = GetIt.instance;
class Enemy extends SpriteComponent with HasGameRef, CollisionCallbacks {
  Enemy({
    Vector2? position,
  }) : super(size: Vector2.all(50), position: position, priority: 2);

  @override
  void update(double dt) {
    super.update(dt);
    position -= Vector2(1, 0) * 200 * dt;
    if (position.x < -50) {
      removeFromParent();
      if (getIt<GameManager>().gameOver == false) {
        getIt<GameManager>().increaseScore();
      }
    }
  }

  @override
  Future<void>? onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('flappybird/luggage.png');
    add(RectangleHitbox());
  }
}
