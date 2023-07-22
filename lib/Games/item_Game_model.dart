class Game{
  final String gameName;
  final String imagePath;
  final String route;

  Game({required this.gameName, required this.imagePath, required this.route});

}
List<Game> GamesList = [
  Game(
    gameName: 'TicTacToc',
    imagePath: 'assets/image/game/tictactoc.png',
    route: 'TicTacToc',
  ),
  Game(
    gameName: 'Connect 4',
    imagePath: 'assets/image/game/connect4.png',
    route: 'connect4',
  ),
  Game(
    gameName: 'Memory',
    imagePath: 'assets/image/game/memo.png',
    route: 'memory',
  ),
  Game(
    gameName: 'Flappy Bird',
    imagePath: 'assets/image/game/flappy.png',
    route: 'flappy',
  ),
];
