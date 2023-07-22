import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:intelligent_learning/Games/FlappyBird/enemy.dart';
import 'package:intelligent_learning/Games/FlappyBird/enemy_manager.dart';
import 'package:intelligent_learning/Games/FlappyBird/game_manager.dart';
import 'package:intelligent_learning/Games/FlappyBird/game_over.dart';
import 'package:intelligent_learning/Games/FlappyBird/player.dart';
import 'package:intelligent_learning/Games/FlappyBird/score.dart';
import 'package:intelligent_learning/Games/FlappyBird/world.dart';


GetIt getIt = GetIt.instance;
class FlappyDash extends FlameGame
    with KeyboardEvents, HasCollisionDetection, HasTappables {
  late Player dash = Player();
  late final World _world = World();
  EnemyManager enemyManager = EnemyManager();
  ScoreDisplay scoreDisplay = ScoreDisplay();
  StartGameButton startButton = StartGameButton();
  PauseGameButton pauseButton = PauseGameButton();
  late RestartGameButton restartButton;
  late GameOver gameOver;

  @override
  KeyEventResult onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    if (event is RawKeyUpEvent) {
      getIt<GameManager>().releaseControl();
    }

    final bool isKeyDown = event is RawKeyDownEvent;

    if (isKeyDown) {
      if (keysPressed.contains(LogicalKeyboardKey.arrowDown)) {
        getIt<GameManager>().setDirection(Direction.down);
      }
      if (keysPressed.contains(LogicalKeyboardKey.arrowUp)) {
        getIt<GameManager>().setDirection(Direction.up);
      }
    }

    return KeyEventResult.handled;
  }

  @override
  Future<void> onLoad() async {
    await add(_world);
    await add(dash);
    await add(scoreDisplay);
    add(enemyManager);
    dash.position = Vector2(_world.size.x / 8, _world.size.y / 3);
    dash.add(startButton);
    startButton.position = Vector2(75, 10);
  }

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
  }

  void addPauseButton() {
    add(pauseButton);
  }

  void removePauseButton() {
    pauseButton.removeFromParent();
  }

  void addStartButton() {
    add(startButton);
  }

  void removeStartButton() {
    startButton.removeFromParent();
  }

  void activateGameOver() {
    pauseButton.removeFromParent();
    getIt<GameManager>().setGameOver(true);
    overlays.add('GameOver');
    restartButton = RestartGameButton();
    add(restartButton);
    enemyManager.stop();
  }

  void resetGame() {
    if (getIt<GameManager>().gameOver == false) {
      return;
    }
    getIt<GameManager>().resetScore();
    getIt<GameManager>().setGameOver(false);
    dash.position = Vector2(_world.size.x / 8, _world.size.y / 3);
    overlays.remove('GameOver');
    children.whereType<Enemy>().forEach((enemy) {
      enemy.removeFromParent();
    });
    pauseButton = PauseGameButton();
    add(pauseButton);
    enemyManager.start();
  }

  @override
  Color backgroundColor() => Color.fromARGB(255, 158, 230, 244);
}

class FlappyGame extends StatelessWidget {
  final game = FlappyDash();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('Flappy Bird'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, ),
        ),
      ),
      body: Stack(children: [
        Container(
          color: Colors.deepPurple,
        ),
        Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height*0.6,
                child: GameWidget(
                  game: game,
                  overlayBuilderMap: {
                    'GameOver': (BuildContext context, FlappyDash game) {
                      return const Center(
                        heightFactor: 2,
                        child: Text(
                          'GAME OVER',
                          style: TextStyle(
                              backgroundColor: Colors.red,
                              color: Colors.white,
                              fontSize: 35,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 8),
                        ),
                      );
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 25, 15, 0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTapDown: (TapDownDetails details) =>
                          {getIt<GameManager>().setDirection(Direction.up)},
                      onTapUp: (TapUpDetails) =>
                          {getIt<GameManager>().releaseControl()},
                      child: Container(
                        height: MediaQuery.of(context).size.height*0.1,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: const Icon(Icons.arrow_drop_up,
                            size: 48, color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTapDown: (TapDownDetails details) =>
                          {getIt<GameManager>().setDirection(Direction.down)},
                      onTapUp: (TapUpDetails details) =>
                          {getIt<GameManager>().releaseControl()},
                      child: Container(
                        height: MediaQuery.of(context).size.height*0.1,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: const Icon(Icons.arrow_drop_down,
                            size: 48, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

class StartGameButton extends SpriteComponent
    with HasGameRef<FlappyDash>, Tappable {
  StartGameButton()
      : super(
          size: Vector2(150, 76),
          priority: 25,
        );

  @override
  bool onTapDown(TapDownInfo info) {
    gameRef.resumeEngine();
    gameRef.addPauseButton();
    removeFromParent();
    return true;
  }

  @override
  void onMount() {
    // TODO: implement onMount
    super.onMount();
    gameRef.pauseEngine();
  }

  @override
  Future<void>? onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('flappybird/start_button.png');
  }
}

class PauseGameButton extends SpriteComponent
    with HasGameRef<FlappyDash>, Tappable {
  PauseGameButton()
      : super(size: Vector2(75, 38), priority: 25, position: Vector2(15, 15));

  @override
  bool onTapDown(TapDownInfo info) {
    gameRef.addStartButton();
    gameRef.startButton.position = Vector2(120, 120);
    removeFromParent();
    return true;
  }

  @override
  Future<void>? onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('flappybird/pause_button.png');
  }
}

class RestartGameButton extends SpriteComponent
    with HasGameRef<FlappyDash>, Tappable {
  RestartGameButton()
      : super(
            size: Vector2(150, 76), priority: 25, position: Vector2(120, 160));

  @override
  bool onTapDown(TapDownInfo info) {
    gameRef.resetGame();
    removeFromParent();
    return true;
  }

  @override
  Future<void>? onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('flappybird/restart_button.png');
  }
}
