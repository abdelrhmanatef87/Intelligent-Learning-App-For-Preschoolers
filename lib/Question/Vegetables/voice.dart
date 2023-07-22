class QuestionVegetableVoice {
  final String voicePath;
  final String answer;
  final List<String> imagePath;

  QuestionVegetableVoice({
    required this.voicePath,
    required this.answer,
    required this.imagePath,
  });
}

class QuestionVegetableDataVoice {
  List<QuestionVegetableVoice> questions = [
    QuestionVegetableVoice(
      voicePath: 'broccoli',
      answer: 'assets/image/vegetables/broccoli.png',
      imagePath: ['assets/image/vegetables/broccoli.png', 'assets/image/vegetables/carrot.png', 'assets/image/vegetables/cucumber.png', 'assets/image/vegetables/potato.png'],
    ),
    QuestionVegetableVoice(
      voicePath: 'carrot',
      answer: 'assets/image/vegetables/carrot.png',
      imagePath: ['assets/image/vegetables/carrot.png', 'assets/image/vegetables/broccoli.png', 'assets/image/vegetables/eggplant.png', 'assets/image/vegetables/potato.png'],
    ),
    QuestionVegetableVoice(
      voicePath: 'corn',
      answer: 'assets/image/vegetables/corn.png',
      imagePath: ['assets/image/vegetables/corn.png', 'assets/image/vegetables/broccoli.png', 'assets/image/vegetables/eggplant.png', 'assets/image/vegetables/potato.png'],
    ),
    QuestionVegetableVoice(
      voicePath: 'cucumber',
      answer: 'assets/image/vegetables/cucumber.png',
      imagePath: ['assets/image/vegetables/cucumber.png', 'assets/image/vegetables/carrot.png', 'assets/image/vegetables/eggplant.png', 'assets/image/vegetables/pepper.png'],
    ),
    QuestionVegetableVoice(
      voicePath: 'eggplant',
      answer: 'assets/image/vegetables/eggplant.png',
      imagePath: ['assets/image/vegetables/eggplant.png', 'assets/image/vegetables/carrot.png', 'assets/image/vegetables/onion.png', 'assets/image/vegetables/salad.png'],
    ),
    QuestionVegetableVoice(
      voicePath: 'onion',
      answer: 'assets/image/vegetables/onion.png',
      imagePath: ['assets/image/vegetables/onion.png', 'assets/image/vegetables/corn.png', 'assets/image/vegetables/pepper.png', 'assets/image/vegetables/tomato.png'],
    ),
    QuestionVegetableVoice(
      voicePath: 'pepper',
      answer: 'vegetables/pepper.png',
      imagePath: ['assets/image/vegetables/pepper.png', 'assets/image/vegetables/corn.png', 'assets/image/vegetables/onion.png', 'assets/image/vegetables/salad.png'],
    ),
    QuestionVegetableVoice(
      voicePath: 'potato',
      answer: 'assets/image/vegetables/potato.png',
      imagePath: ['assets/image/vegetables/potato.png', 'assets/image/vegetables/corn.png', 'assets/image/vegetables/onion.png', 'assets/image/vegetables/tomato.png'],
    ),
    QuestionVegetableVoice(
      voicePath: 'salad',
      answer: 'assets/image/vegetables/salad.png',
      imagePath: ['assets/image/vegetables/salad.png', 'assets/image/vegetables/cucumber.png', 'assets/image/vegetables/pepper.png', 'assets/image/vegetables/tomato.png'],
    ),
    QuestionVegetableVoice(
      voicePath: 'tomato',
      answer: 'assets/image/vegetables/tomato.png',
      imagePath: ['assets/image/vegetables/tomato.png', 'assets/image/vegetables/cucumber.png', 'assets/image/vegetables/pepper.png', 'assets/image/vegetables/salad.png'],
    ),
  ];
}
