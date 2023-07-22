class QuestionColorMcq {
  final String imagePath;
  final String answer;
  final List<String> choice;

  QuestionColorMcq({
    required this.imagePath,
    required this.answer,
    required this.choice,
  });
}

class QuestionColorDataMcq {
  List<QuestionColorMcq> questions = [
    QuestionColorMcq(
      imagePath: 'assets/image/color/black.png',
      answer: 'Black',
      choice: ['Black', 'Orange', 'Purple', 'White'],
    ),
    QuestionColorMcq(
      imagePath: 'assets/image/color/blue.png',
      answer: 'Blue',
      choice: ['Blue', 'Black', 'Grey', 'Purple'],
    ),
    QuestionColorMcq(
      imagePath: 'assets/image/color/brown.png',
      answer: 'Brown',
      choice: ['Brown', 'Orange', 'Red', 'White'],
    ),
    QuestionColorMcq(
      imagePath: 'assets/image/color/grey.png',
      answer: 'Gray',
      choice: ['Grey', 'Green', 'Orange', 'Orange'],
    ),
    QuestionColorMcq(
      imagePath: 'assets/image/color/orange.png',
      answer: 'Orange',
      choice: ['Orange', 'Blue', 'Black', 'Yellow'],
    ),
    QuestionColorMcq(
      imagePath: 'assets/image/color/green.png',
      answer: 'Green',
      choice: ['Green', 'Brown', 'Black', 'Yellow'],
    ),
    QuestionColorMcq(
      imagePath: 'assets/image/color/purple.png',
      answer: 'Purple',
      choice: ['Purple', 'Black', 'Green', 'Red'],
    ),
    QuestionColorMcq(
      imagePath: 'assets/image/color/red.png',
      answer: 'Red',
      choice: ['Red', 'Brown', 'Grey', 'White'],
    ),
    QuestionColorMcq(
      imagePath: 'assets/image/color/white.png',
      answer: 'White',
      choice: ['White', 'Blue', 'Green', 'Purple'],
    ),
    QuestionColorMcq(
      imagePath: 'assets/image/color/yellow.png',
      answer: 'Yellow',
      choice: ['Yellow', 'Blue', 'Brown', 'Red'],
    ),
  ];

  List<String> colorNames = [
    'Red',
    'Blue',
    'Green',
    'Yellow',
    'Orange',
    'Purple',
    'Pink',
    'Brown',
    'Black',
    'White',
    'Gray',
    'Silver',
    'Gold',
    'Beige',
    'Teal',
    'Turquoise',
    'Navy',
    'Lavender',
    'Magenta',
    'Cyan',
  ];
}
