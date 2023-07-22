import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:get_it/get_it.dart';
import 'package:intelligent_learning/Games/FlappyBird/game.dart';
import 'package:intelligent_learning/Games/FlappyBird/game_manager.dart';


GetIt getIt = GetIt.instance;

class Player extends SpriteComponent
    with HasGameRef<FlappyDash>, CollisionCallbacks {
  Player() : super(size: Vector2.all(75));
  bool hasCollided = false;
  Vector2 velocityVector = Vector2(0, 0);

  @override
  void onCollision(
      Set<Vector2> intersectionPoints, PositionComponent other) async {
    super.onCollision(intersectionPoints, other);
    gameRef.activateGameOver();
  }

  @override
  void update(double dt) {
    Direction? direction = getIt<GameManager>().direction;
    if (direction == null) {
      velocityVector = Vector2(0, 0);
    } else if (direction == Direction.up) {
      if (position.y <= 0) return;
      velocityVector = Vector2(0, -200);
    } else if (direction == Direction.down) {
      if (position.y >= gameRef.size.y - size.y) return;
      velocityVector = Vector2(0, 200);
    }

    position.add(velocityVector * dt);
  }

  Future<void> onLoad() async {
    super.onLoad();
    add(CircleHitbox());
    sprite = await gameRef.loadSprite('flappybird/dash.png');
  }
}
