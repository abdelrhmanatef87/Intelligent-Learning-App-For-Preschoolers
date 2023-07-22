class QuestionColorVoice {
  final String voicePath;
  final String answer;
  final List<String> imagePath;

  QuestionColorVoice({
    required this.voicePath,
    required this.answer,
    required this.imagePath,
  });
}

class QuestionColorDataVoice {
  List<QuestionColorVoice> questions = [
    QuestionColorVoice(
      voicePath: 'black',
      answer: 'assets/image/color/black.png',
      imagePath: ['assets/image/color/black.png', 'assets/image/color/blue.png', 'assets/image/color/yellow.png', 'assets/image/color/green.png'],
    ),
    QuestionColorVoice(
      voicePath: 'blue',
      answer: 'assets/image/color/blue.png',
      imagePath: ['assets/image/color/blue.png', 'assets/image/color/brown.png', 'assets/image/color/grey.png', 'assets/image/color/red.png'],
    ),
    QuestionColorVoice(
      voicePath: 'brown',
      answer: 'assets/image/color/brown.png',
      imagePath: ['assets/image/color/brown.png', 'assets/image/color/yellow.png', 'assets/image/color/purple.png', 'assets/image/color/red.png'],
    ),
    QuestionColorVoice(
      voicePath: 'grey',
      answer: 'assets/image/color/grey.png',
      imagePath: ['assets/image/color/grey.png', 'assets/image/color/orange.png', 'assets/image/color/purple.png', 'assets/image/color/black.png'],
    ),
    QuestionColorVoice(
      voicePath: 'orange',
      answer: 'assets/image/color/orange.png',
      imagePath: ['assets/image/color/orange.png', 'assets/image/color/blue.png', 'assets/image/color/grey.png', 'assets/image/color/green.png'],
    ),
    QuestionColorVoice(
      voicePath: 'green',
      answer: 'assets/image/color/green.png',
      imagePath: ['assets/image/color/green.png', 'assets/image/color/blue.png', 'assets/image/color/red.png', 'assets/image/color/white.png'],
    ),
    QuestionColorVoice(
      voicePath: 'purple',
      answer: 'assets/image/color/purple.png',
      imagePath: ['assets/image/color/purple.png', 'assets/image/color/red.png', 'assets/image/color/brown.png', 'assets/image/color/white.png'],
    ),
    QuestionColorVoice(
      voicePath: 'red',
      answer: 'assets/image/color/red.png',
      imagePath: ['assets/image/color/red.png', 'assets/image/color/black.png', 'assets/image/color/grey.png', 'assets/image/color/yellow.png'],
    ),
    QuestionColorVoice(
      voicePath: 'white',
      answer: 'assets/image/color/white.png',
      imagePath: ['assets/image/color/white.png', 'assets/image/color/black.png', 'assets/image/color/brown.png', 'assets/image/color/green.png'],
    ),
    QuestionColorVoice(
      voicePath: 'yellow',
      answer: 'assets/image/color/yellow.png',
      imagePath: ['assets/image/color/yellow.png', 'assets/image/color/black.png', 'assets/image/color/brown.png', 'assets/image/color/green.png'],
    ),
  ];
}
