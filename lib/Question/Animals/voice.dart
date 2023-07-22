class QuestionAnimalVoice {
  final String voicePath;
  final String answer;
  final List<String> imagePath;

  QuestionAnimalVoice({
    required this.voicePath,
    required this.answer,
    required this.imagePath,
  });
}

class QuestionAnimalDataVoice {
  List<QuestionAnimalVoice> questions = [
    QuestionAnimalVoice(
      voicePath: 'cat',
      answer: 'assets/image/animals/cat.png',
      imagePath: ['assets/image/animals/cat.png', 'assets/image/animals/dog.png', 'assets/image/animals/fish.png', 'assets/image/animals/lion.png'],
    ),
    QuestionAnimalVoice(
      voicePath: 'cow',
      answer: 'assets/image/animals/cow.png',
      imagePath: ['assets/image/animals/cow.png', 'assets/image/animals/dog.png', 'assets/image/animals/fish.png', 'assets/image/animals/rabbit.png'],
    ),
    QuestionAnimalVoice(
      voicePath: 'dog',
      answer: 'assets/image/animals/dog.png',
      imagePath: ['assets/image/animals/dog.png', 'assets/image/animals/elephant.png', 'assets/image/animals/horse.png', 'assets/image/animals/rabbit.png'],
    ),
    QuestionAnimalVoice(
      voicePath: 'elephant',
      answer: 'assets/image/animals/elephant.png',
      imagePath: ['assets/image/animals/elephant.png', 'assets/image/animals/dog.png', 'assets/image/animals/giraffe.png', 'assets/image/animals/lion.png'],
    ),
    QuestionAnimalVoice(
      voicePath: 'fish',
      answer: 'assets/image/animals/fish.png',
      imagePath: ['assets/image/animals/fish.png', 'assets/image/animals/cat.png', 'assets/image/animals/giraffe.png', 'assets/image/animals/lion.png'],
    ),
    QuestionAnimalVoice(
      voicePath: 'giraffe',
      answer: 'assets/image/animals/giraffe.png',
      imagePath: ['assets/image/animals/giraffe.png', 'assets/image/animals/cow.png', 'assets/image/animals/horse.png', 'assets/image/animals/rabbit.png'],
    ),
    QuestionAnimalVoice(
      voicePath: 'horse',
      answer: 'assets/image/animals/horse.png',
      imagePath: ['assets/image/animals/horse.png', 'assets/image/animals/cat.png', 'assets/image/animals/monkey.png', 'assets/image/animals/lion.png'],
    ),
    QuestionAnimalVoice(
      voicePath: 'monkey',
      answer: 'assets/image/animals/monkey.png',
      imagePath: ['assets/image/animals/monkey.png', 'assets/image/animals/cat.png', 'assets/image/animals/giraffe.png', 'assets/image/animals/lion.png'],
    ),
    QuestionAnimalVoice(
      voicePath: 'rabbit',
      answer: 'assets/image/animals/rabbit.png',
      imagePath: ['assets/image/animals/rabbit.png', 'assets/image/animals/cow.png', 'assets/image/animals/fish.png', 'assets/image/animals/horse.png'],
    ),
    QuestionAnimalVoice(
      voicePath: 'lion',
      answer: 'assets/image/animals/lion.png',
      imagePath: ['assets/image/animals/lion.png', 'assets/image/animals/cow.png', 'assets/image/animals/elephant.png', 'assets/image/animals/monkey.png'],
    ),
  ];
}
