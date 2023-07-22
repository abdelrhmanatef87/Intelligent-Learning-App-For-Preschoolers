class QuestionBodyVoice {
  final String voicePath;
  final String answer;
  final List<String> imagePath;

  QuestionBodyVoice({
    required this.voicePath,
    required this.answer,
    required this.imagePath,
  });
}

class QuestionBodyDataVoice {
  List<QuestionBodyVoice> questions = [
    QuestionBodyVoice(
      voicePath: 'ear',
      answer: 'assets/image/body/ear.png',
      imagePath: ['assets/image/body/ear.png', 'assets/image/body/face.png', 'assets/image/body/heart.png', 'assets/image/body/teeth.png'],
    ),
    QuestionBodyVoice(
      voicePath: 'eye',
      answer: 'assets/image/body/eye.png',
      imagePath: ['assets/image/body/eye.png', 'assets/image/body/hair.png', 'assets/image/body/hand.png', 'assets/image/body/mouth.png'],
    ),
    QuestionBodyVoice(
      voicePath: 'face',
      answer: 'assets/image/body/face.png',
      imagePath: ['assets/image/body/face.png', 'assets/image/body/ear.png', 'assets/image/body/heart.png', 'assets/image/body/nose.png'],
    ),
    QuestionBodyVoice(
      voicePath: 'hair',
      answer: 'assets/image/body/hair.png',
      imagePath: ['assets/image/body/hair.png', 'assets/image/body/eye.png', 'assets/image/body/leg.png', 'assets/image/body/teeth.png'],
    ),
    QuestionBodyVoice(
      voicePath: 'hand',
      answer: 'assets/image/body/hand.png',
      imagePath: ['assets/image/body/hand.png', 'assets/image/body/face.png', 'assets/image/body/mouth.png', 'assets/image/body/nose.png'],
    ),
    QuestionBodyVoice(
      voicePath: 'heart',
      answer: 'assets/image/body/heart.png',
      imagePath: ['assets/image/body/heart.png', 'assets/image/body/ear.png', 'assets/image/body/leg.png', 'assets/image/body/teeth.png'],
    ),
    QuestionBodyVoice(
      voicePath: 'leg',
      answer: 'assets/image/body/leg.png',
      imagePath: ['assets/image/body/leg.png', 'assets/image/body/eye.png', 'assets/image/body/hand.png', 'assets/image/body/nose.png'],
    ),
    QuestionBodyVoice(
      voicePath: 'mouth',
      answer: 'assets/image/body/mouth.png',
      imagePath: ['assets/image/body/mouth.png', 'assets/image/body/ear.png', 'assets/image/body/hair.png', 'assets/image/body/heart.png'],
    ),
    QuestionBodyVoice(
      voicePath: 'nose',
      answer: 'assets/image/body/nose.png',
      imagePath: ['assets/image/body/nose.png', 'assets/image/body/face.png', 'assets/image/body/hand.png', 'assets/image/body/leg.png'],
    ),
    QuestionBodyVoice(
      voicePath: 'teeth',
      answer: 'assets/image/body/teeth.png',
      imagePath: ['assets/image/body/teeth.png', 'assets/image/body/eye.png', 'assets/image/body/hair.png', 'assets/image/body/mouth.png'],
    ),
  ];
}
