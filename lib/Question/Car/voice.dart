class QuestionCarVoice {
  final String voicePath;
  final String answer;
  final List<String> imagePath;

  QuestionCarVoice({
    required this.voicePath,
    required this.answer,
    required this.imagePath,
  });
}

class QuestionCarDataVoice {
  List<QuestionCarVoice> questions = [
    QuestionCarVoice(
      voicePath: 'airplane',
      answer: 'assets/image/car/airplane.png',
      imagePath: ['assets/image/car/airplane.png', 'assets/image/car/car.png', 'assets/image/car/motorcycle.png', 'assets/image/car/taxi.png'],
    ),
    QuestionCarVoice(
      voicePath: 'bike',
      answer: 'assets/image/car/bike.png',
      imagePath: ['assets/image/car/bike.png', 'assets/image/car/car.png', 'assets/image/car/scooter.png', 'assets/image/car/taxi.png'],
    ),
    QuestionCarVoice(
      voicePath: 'bus',
      answer: 'assets/image/car/bus.png',
      imagePath: ['assets/image/car/bus.png', 'assets/image/car/airplane.png', 'assets/image/car/motorcycle.png', 'assets/image/car/boat.png'],
    ),
    QuestionCarVoice(
      voicePath: 'car',
      answer: 'assets/image/car/car.png',
      imagePath: ['assets/image/car/car.png', 'assets/image/car/train.png', 'assets/image/car/scooter.png', 'assets/image/car/airplane.png'],
    ),
    QuestionCarVoice(
      voicePath: 'train',
      answer: 'assets/image/car/train.png',
      imagePath: ['assets/image/car/train.png', 'assets/image/car/bike.png', 'assets/image/car/car.png', 'assets/image/car/rocket.png'],
    ),
    QuestionCarVoice(
      voicePath: 'motorcycle',
      answer: 'assets/image/car/motorcycle.png',
      imagePath: ['assets/image/car/motorcycle.png', 'assets/image/car/airplane.png', 'assets/image/car/taxi.png', 'assets/image/car/boat.png'],
    ),
    QuestionCarVoice(
      voicePath: 'rocket',
      answer: 'assets/image/car/rocket.png',
      imagePath: ['assets/image/car/rocket.png', 'assets/image/car/car.png', 'assets/image/car/boat.png', 'assets/image/car/bus.png'],
    ),
    QuestionCarVoice(
      voicePath: 'scooter',
      answer: 'assets/image/car/scooter.png',
      imagePath: ['assets/image/car/scooter.png', 'assets/image/car/bike.png', 'assets/image/car/train.png', 'assets/image/car/rocket.png'],
    ),
    QuestionCarVoice(
      voicePath: 'taxi',
      answer: 'assets/image/car/taxi.png',
      imagePath: ['assets/image/car/taxi.png', 'assets/image/car/airplane.png', 'assets/image/car/motorcycle.png', 'assets/image/car/scooter.png'],
    ),
    QuestionCarVoice(
      voicePath: 'boat',
      answer: 'assets/image/car/boat.png',
      imagePath: ['assets/image/car/boat.png', 'assets/image/car/bike.png', 'assets/image/car/train.png', 'assets/image/car/rocket.png'],
    ),
  ];
}
