class QuestionFruitVoice {
  final String voicePath;
  final String answer;
  final List<String> imagePath;

  QuestionFruitVoice({
    required this.voicePath,
    required this.answer,
    required this.imagePath,
  });
}

class QuestionFruitDataVoice {
  List<QuestionFruitVoice> questions = [
    QuestionFruitVoice(
      voicePath: 'apple',
      answer: 'assets/image/fruits/apple.png',
      imagePath: ['assets/image/fruits/apple.png', 'assets/image/fruits/grape.png', 'assets/image/fruits/kiwi.png', 'assets/image/fruits/orange.png'],
    ),
    QuestionFruitVoice(
      voicePath: 'banana',
      answer: 'assets/image/fruits/banana.png',
      imagePath: ['assets/image/fruits/banana.png', 'assets/image/fruits/apple.png', 'assets/image/fruits/guava.png', 'assets/image/fruits/strawberry.png'],
    ),
    QuestionFruitVoice(
      voicePath: 'grape',
      answer: 'assets/image/fruits/grape.png',
      imagePath: ['assets/image/fruits/grape.png', 'assets/image/fruits/banana.png', 'assets/image/fruits/kiwi.png', 'assets/image/fruits/strawberry.png'],
    ),
    QuestionFruitVoice(
      voicePath: 'guava',
      answer: 'assets/image/fruits/guava.png',
      imagePath: ['assets/image/fruits/guava.png', 'assets/image/fruits/apple.png', 'assets/image/fruits/mango.png', 'assets/image/fruits/watermelon.png'],
    ),
    QuestionFruitVoice(
      voicePath: 'kiwi',
      answer: 'assets/image/fruits/kiwi.png',
      imagePath: ['assets/image/fruits/kiwi.png', 'assets/image/fruits/banana.png', 'assets/image/fruits/orange.png', 'assets/image/fruits/strawberry.png'],
    ),
    QuestionFruitVoice(
      voicePath: 'mango',
      answer: 'assets/image/fruits/mango.png',
      imagePath: ['assets/image/fruits/mango.png', 'assets/image/fruits/apple.png', 'assets/image/fruits/orange.png', 'assets/image/fruits/pineapple.png'],
    ),
    QuestionFruitVoice(
      voicePath: 'orange',
      answer: 'assets/image/fruits/orange.png',
      imagePath: ['assets/image/fruits/orange.png', 'assets/image/fruits/guava.png', 'assets/image/fruits/kiwi.png', 'assets/image/fruits/watermelon.png'],
    ),
    QuestionFruitVoice(
      voicePath: 'pineapple',
      answer: 'assets/image/fruits/pineapple.png',
      imagePath: ['assets/image/fruits/pineapple.png', 'assets/image/fruits/grape.png', 'assets/image/fruits/mango.png', 'assets/image/fruits/watermelon.png'],
    ),
    QuestionFruitVoice(
      voicePath: 'strawberry',
      answer: 'assets/image/fruits/strawberry.png',
      imagePath: ['assets/image/fruits/strawberry.png', 'assets/image/fruits/banana.png', 'assets/image/fruits/guava.png', 'assets/image/fruits/pineapple.png'],
    ),
    QuestionFruitVoice(
      voicePath: 'watermelon',
      answer: 'assets/image/fruits/watermelon.png',
      imagePath: ['assets/image/fruits/watermelon.png', 'assets/image/fruits/grape.png', 'assets/image/fruits/mango.png', 'assets/image/fruits/pineapple.png'],
    ),
  ];
}
