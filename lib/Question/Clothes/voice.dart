class QuestionClothesVoice {
  final String voicePath;
  final String answer;
  final List<String> imagePath;

  QuestionClothesVoice({
    required this.voicePath,
    required this.answer,
    required this.imagePath,
  });
}

class QuestionClothesDataVoice {
  List<QuestionClothesVoice> questions = [
    QuestionClothesVoice(
      voicePath: 'bag',
      answer: 'assets/image/clothes/bag.png',
      imagePath: ['assets/image/clothes/bag.png', 'assets/image/clothes/jacket.png', 'assets/image/clothes/socks.png', 'assets/image/clothes/shirt.png'],
    ),
    QuestionClothesVoice(
      voicePath: 'dress',
      answer: 'assets/image/clothes/dress.png',
      imagePath: ['assets/image/clothes/dress.png', 'assets/image/clothes/jacket.png', 'assets/image/clothes/shirt.png', 'assets/image/clothes/watch.png'],
    ),
    QuestionClothesVoice(
      voicePath: 'hat',
      answer: 'assets/image/clothes/hat.png',
      imagePath: ['assets/image/clothes/hat.png', 'assets/image/clothes/dress.png', 'assets/image/clothes/socks.png', 'assets/image/clothes/watch.png'],
    ),
    QuestionClothesVoice(
      voicePath: 'jacket',
      answer: 'assets/image/clothes/jacket.png',
      imagePath: ['assets/image/clothes/jacket.png', 'assets/image/clothes/hat.png', 'assets/image/clothes/scooter.png', 'assets/image/clothes/shirt.png'],
    ),
    QuestionClothesVoice(
      voicePath: 'sneaker',
      answer: 'assets/image/clothes/sneaker.png',
      imagePath: ['assets/image/clothes/sneaker.png', 'assets/image/clothes/dress.png', 'assets/image/clothes/jacket.png', 'assets/image/clothes/trousers.png'],
    ),
    QuestionClothesVoice(
      voicePath: 'socks',
      answer: 'assets/image/clothes/socks.png',
      imagePath: ['assets/image/clothes/socks.png', 'assets/image/clothes/bag.png', 'assets/image/clothes/suit.png', 'assets/image/clothes/boat.png'],
    ),
    QuestionClothesVoice(
      voicePath: 'suit',
      answer: 'assets/image/clothes/suit.png',
      imagePath: ['assets/image/clothes/suit.png', 'assets/image/clothes/hat.png', 'assets/image/clothes/socks.png', 'assets/image/clothes/trousers.png'],
    ),
    QuestionClothesVoice(
      voicePath: 'trousers',
      answer: 'assets/image/clothes/trousers.png',
      imagePath: ['assets/image/clothes/trousers.png', 'assets/image/clothes/hat.png', 'assets/image/clothes/sneaker.png', 'assets/image/clothes/suit.png'],
    ),
    QuestionClothesVoice(
      voicePath: 'shirt',
      answer: 'assets/image/clothes/shirt.png',
      imagePath: ['assets/image/clothes/shirt.png', 'assets/image/clothes/bag.png', 'assets/image/clothes/sneaker.png', 'assets/image/clothes/suit.png'],
    ),
    QuestionClothesVoice(
      voicePath: 'watch',
      answer: 'assets/image/clothes/watch.png',
      imagePath: ['assets/image/clothes/watch.png', 'assets/image/clothes/dress.png', 'assets/image/clothes/sneaker.png', 'assets/image/clothes/trousers.png'],
    ),
  ];
}
