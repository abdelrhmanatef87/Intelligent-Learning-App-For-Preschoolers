class QuestionGeneralVoice {
  final String voicePath;
  final String answer;
  final List<String> imagePath;

  QuestionGeneralVoice({
    required this.voicePath,
    required this.answer,
    required this.imagePath,
  });
}

class QuestionGeneralDataVoice {
  List<QuestionGeneralVoice> questions = [
    QuestionGeneralVoice(
      voicePath: 'ball',
      answer: 'assets/image/general/ball.png',
      imagePath: ['assets/image/general/ball.png', 'assets/image/general/chair.png', 'assets/image/general/computer.png', 'assets/image/general/umbrella.png'],
    ),
    QuestionGeneralVoice(
      voicePath: 'book',
      answer: 'assets/image/general/book.png',
      imagePath: ['assets/image/general/book.png', 'assets/image/general/chair.png', 'assets/image/general/pen.png', 'assets/image/general/school.png'],
    ),
    QuestionGeneralVoice(
      voicePath: 'chair',
      answer: 'assets/image/general/chair.png',
      imagePath: ['assets/image/general/chair.png', 'assets/image/general/clock.png', 'assets/image/general/lamp.png', 'assets/image/general/pizza.png'],
    ),
    QuestionGeneralVoice(
      voicePath: 'clock',
      answer: 'assets/image/general/clock.png',
      imagePath: ['assets/image/general/clock.png', 'assets/image/general/chair.png', 'assets/image/general/lamp.png', 'assets/image/general/school.png'],
    ),
    QuestionGeneralVoice(
      voicePath: 'computer',
      answer: 'assets/image/general/computer.png',
      imagePath: ['assets/image/general/computer.png', 'assets/image/general/book.png', 'assets/image/general/lamp.png', 'assets/image/general/pen.png'],
    ),
    QuestionGeneralVoice(
      voicePath: 'lamp',
      answer: 'assets/image/general/lamp.png',
      imagePath: ['assets/image/general/lamp.png', 'assets/image/general/book.png', 'assets/image/general/computer.png', 'assets/image/general/pen.png'],
    ),
    QuestionGeneralVoice(
      voicePath: 'pen',
      answer: 'assets/image/general/pen.png',
      imagePath: ['assets/image/general/pen.png', 'assets/image/general/chair.png', 'assets/image/general/clock.png', 'assets/image/general/pizza.png'],
    ),
    QuestionGeneralVoice(
      voicePath: 'pizza',
      answer: 'assets/image/general/pizza.png',
      imagePath: ['assets/image/general/pizza.png', 'assets/image/general/ball.png', 'assets/image/general/pen.png', 'assets/image/general/school.png'],
    ),
    QuestionGeneralVoice(
      voicePath: 'school',
      answer: 'assets/image/general/school.png',
      imagePath: ['assets/image/general/school.png', 'assets/image/general/ball.png', 'assets/image/general/clock.png', 'assets/image/general/pizza.png'],
    ),
    QuestionGeneralVoice(
      voicePath: 'umbrella',
      answer: 'assets/image/general/umbrella.png',
      imagePath: ['assets/image/general/umbrella.png', 'assets/image/general/ball.png', 'assets/image/general/computer.png', 'assets/image/general/pen.png'],
    ),
  ];
}
