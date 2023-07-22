class QuestionNumberVoice {
  final String voicePath;
  final String answer;
  final List<String> imagePath;

  QuestionNumberVoice({
    required this.voicePath,
    required this.answer,
    required this.imagePath,
  });
}

class QuestionNumberDataVoice {
  List<QuestionNumberVoice> questions = [
    QuestionNumberVoice(
      voicePath: 'zero',
      answer: 'assets/image/numbers/zero.png',
      imagePath: ['assets/image/numbers/zero.png', 'assets/image/numbers/two.png', 'assets/image/numbers/five.png', 'assets/image/numbers/eight.png'],
    ),
    QuestionNumberVoice(
      voicePath: 'one',
      answer: 'assets/image/numbers/one.png',
      imagePath: ['assets/image/numbers/one.png', 'assets/image/numbers/six.png', 'assets/image/numbers/three.png', 'assets/image/numbers/four.png'],
    ),
    QuestionNumberVoice(
      voicePath: 'two',
      answer: 'assets/image/numbers/two.png',
      imagePath: ['assets/image/numbers/two.png', 'assets/image/numbers/five.png', 'assets/image/numbers/eight.png', 'assets/image/numbers/four.png'],
    ),
    QuestionNumberVoice(
      voicePath: 'three',
      answer: 'assets/image/numbers/three.png',
      imagePath: ['assets/image/numbers/three.png', 'assets/image/numbers/zero.png', 'assets/image/numbers/nine.png', 'assets/image/numbers/eight.png'],
    ),
    QuestionNumberVoice(
      voicePath: 'four',
      answer: 'assets/image/numbers/four.png',
      imagePath: ['assets/image/numbers/four.png', 'assets/image/numbers/one.png', 'assets/image/numbers/six.png', 'assets/image/numbers/nine.png'],
    ),
    QuestionNumberVoice(
      voicePath: 'five',
      answer: 'assets/image/numbers/five.png',
      imagePath: ['assets/image/numbers/five.png', 'assets/image/numbers/one.png', 'assets/image/numbers/three.png', 'assets/image/numbers/eight.png'],
    ),
    QuestionNumberVoice(
      voicePath: 'six',
      answer: 'assets/image/numbers/six.png',
      imagePath: ['assets/image/numbers/six.png', 'assets/image/numbers/zero.png', 'assets/image/numbers/nine.png', 'assets/image/numbers/two.png'],
    ),
    QuestionNumberVoice(
      voicePath: 'seven',
      answer: 'assets/image/numbers/seven.png',
      imagePath: ['assets/image/numbers/seven.png', 'assets/image/numbers/two.png', 'assets/image/numbers/three.png', 'assets/image/numbers/four.png'],
    ),
    QuestionNumberVoice(
      voicePath: 'eight',
      answer: 'assets/image/numbers/eight.png',
      imagePath: ['assets/image/numbers/eight.png', 'assets/image/numbers/zero.png', 'assets/image/numbers/six.png', 'assets/image/numbers/four.png'],
    ),
    QuestionNumberVoice(
      voicePath: 'nine',
      answer: 'assets/image/numbers/nine.png',
      imagePath: ['assets/image/numbers/nine.png', 'assets/image/numbers/one.png', 'assets/image/numbers/five.png', 'assets/image/numbers/two.png'],
    ),
  ];
}
