class QuestionCountryVoice {
  final String voicePath;
  final String answer;
  final List<String> imagePath;

  QuestionCountryVoice({
    required this.voicePath,
    required this.answer,
    required this.imagePath,
  });
}

class QuestionCountryDataVoice {
  List<QuestionCountryVoice> questions = [
    QuestionCountryVoice(
      voicePath: 'brazil',
      answer: 'assets/image/country/brazil.png',
      imagePath: ['assets/image/country/brazil.png', 'assets/image/country/egypt.png', 'assets/image/country/spain.png', 'assets/image/country/italy.png'],
    ),
    QuestionCountryVoice(
      voicePath: 'egypt',
      answer: 'assets/image/country/egypt.png',
      imagePath: ['assets/image/country/egypt.png', 'assets/image/country/japan.png', 'assets/image/country/argentina.png', 'assets/image/country/spain.png'],
    ),
    QuestionCountryVoice(
      voicePath: 'england',
      answer: 'assets/image/country/england.png',
      imagePath: ['assets/image/country/england.png', 'assets/image/country/brazil.png', 'assets/image/country/japan.png', 'assets/image/country/spain.png'],
    ),
    QuestionCountryVoice(
      voicePath: 'france',
      answer: 'assets/image/country/france.png',
      imagePath: ['assets/image/country/france.png', 'assets/image/country/england.png', 'assets/image/country/usa.png', 'assets/image/country/brazil.png'],
    ),
    QuestionCountryVoice(
      voicePath: 'germany',
      answer: 'assets/image/country/germany.png',
      imagePath: ['assets/image/country/germany.png', 'assets/image/country/egypt.png', 'assets/image/country/italy.png', 'assets/image/country/usa.png'],
    ),
    QuestionCountryVoice(
      voicePath: 'italy',
      answer: 'assets/image/country/italy.png',
      imagePath: ['assets/image/country/italy.png', 'assets/image/country/brazil.png', 'assets/image/country/japan.png', 'assets/image/country/spain.png'],
    ),
    QuestionCountryVoice(
      voicePath: 'japan',
      answer: 'assets/image/country/japan.png',
      imagePath: ['assets/image/country/japan.png', 'assets/image/country/england.png', 'assets/image/country/ksa.png', 'assets/image/country/spain.png'],
    ),
    QuestionCountryVoice(
      voicePath: 'ksa',
      answer: 'assets/image/country/ksa.png',
      imagePath: ['assets/image/country/ksa.png', 'assets/image/country/egypt.png', 'assets/image/country/italy.png', 'assets/image/country/usa.png'],
    ),
    QuestionCountryVoice(
      voicePath: 'spain',
      answer: 'assets/image/country/spain.png',
      imagePath: ['assets/image/country/spain.png', 'assets/image/country/brazil.png', 'assets/image/country/ksa.png', 'assets/image/country/usa.png'],
    ),
    QuestionCountryVoice(
      voicePath: 'usa',
      answer: 'assets/image/country/usa.png',
      imagePath: ['assets/image/country/usa.png', 'assets/image/country/england.png', 'assets/image/country/italy.png', 'assets/image/country/ksa.png'],
    ),
  ];
}
