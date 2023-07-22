class QuestionCountryMcq {
  final String imagePath;
  final String answer;
  final List<String> choice;

  QuestionCountryMcq({
    required this.imagePath,
    required this.answer,
    required this.choice,
  });
}

class QuestionCountryDataMcq {
  List<QuestionCountryMcq> questions = [
    QuestionCountryMcq(
      imagePath: 'assets/image/country/brazil.png',
      answer: 'Brazil',
      choice: ['Brazil', 'England', 'Germany', 'KSA'],
    ),
    QuestionCountryMcq(
      imagePath: 'assets/image/country/egypt.png',
      answer: 'Egypt',
      choice: ['Egypt', 'Brazil', 'Italy', 'Japan'],
    ),
    QuestionCountryMcq(
      imagePath: 'assets/image/country/england.png',
      answer: 'England',
      choice: ['England', 'France', 'KSA', 'Japan'],
    ),
    QuestionCountryMcq(
      imagePath: 'assets/image/country/france.png',
      answer: 'France',
      choice: ['France', 'Brazil', 'Germany', 'Japan'],
    ),
    QuestionCountryMcq(
      imagePath: 'assets/image/country/germany.png',
      answer: 'Germany',
      choice: ['Germany', 'Egypt', 'Italy', 'USA'],
    ),
    QuestionCountryMcq(
      imagePath: 'assets/image/country/italy.png',
      answer: 'Italy',
      choice: ['Italy', 'England', 'KSA', 'Spain'],
    ),
    QuestionCountryMcq(
      imagePath: 'assets/image/country/japan.png',
      answer: 'Japan',
      choice: ['Japan', 'Egypt', 'Italy', 'USA'],
    ),
    QuestionCountryMcq(
      imagePath: 'assets/image/country/ksa.png',
      answer: 'KSA',
      choice: ['KSA', 'England', 'France', 'Spain'],
    ),
    QuestionCountryMcq(
      imagePath: 'assets/image/country/spain.png',
      answer: 'Spain',
      choice: ['Spain', 'Brazil', 'France', 'USA'],
    ),
    QuestionCountryMcq(
      imagePath: 'assets/image/country/usa.png',
      answer: 'USA',
      choice: ['USA', 'Egypt', 'Germany', 'Spain'],
    ),
  ];

  List<String> countryNames = [
    'Argentina',
    'Australia',
    'Brazil',
    'Canada',
    'China',
    'Croatia',
    'Denmark',
    'Egypt',
    'France',
    'Germany',
    'Iran',
    'Italy',
    'Japan',
    'Mexico',
    'Morocco',
    'Netherlands',
    'USA'
    'Nigeria',
    'Norway',
    'Portugal',
    'KSA',
    'Spain',
  ];
}
