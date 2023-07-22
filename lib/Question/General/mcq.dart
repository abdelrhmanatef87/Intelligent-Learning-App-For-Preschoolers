class QuestionGeneralMcq {
  final String imagePath;
  final String answer;
  final List<String> choice;

  QuestionGeneralMcq({
    required this.imagePath,
    required this.answer,
    required this.choice,
  });
}

class QuestionGeneralDataMcq {
  List<QuestionGeneralMcq> questions = [
    QuestionGeneralMcq(
      imagePath: 'assets/image/general/ball.png',
      answer: 'Ball',
      choice: ['Ball', 'Clock', 'Lamp', 'Umbrella'],
    ),
    QuestionGeneralMcq(
      imagePath: 'assets/image/general/book.png',
      answer: 'Book',
      choice: ['Book', 'Chair', 'Computer', 'Lamp'],
    ),
    QuestionGeneralMcq(
      imagePath: 'assets/image/general/chair.png',
      answer: 'Chair',
      choice: ['Chair', 'Ball', 'Pen', 'Pizza'],
    ),
    QuestionGeneralMcq(
      imagePath: 'assets/image/general/clock.png',
      answer: 'Clock',
      choice: ['Clock', 'Book', 'Pen', 'Umbrella'],
    ),
    QuestionGeneralMcq(
      imagePath: 'assets/image/general/computer.png',
      answer: 'Computer',
      choice: ['Computer', 'Book', 'Pizza', 'School'],
    ),
    QuestionGeneralMcq(
      imagePath: 'assets/image/general/lamp.png',
      answer: 'Lamp',
      choice: ['Lamp', 'Ball', 'Clock', 'School'],
    ),
    QuestionGeneralMcq(
      imagePath: 'assets/image/general/pen.png',
      answer: 'Pen',
      choice: ['Pen', 'Chair', 'Computer', 'School'],
    ),
    QuestionGeneralMcq(
      imagePath: 'assets/image/general/glasses.png',
      answer: 'Glasses',
      choice: ['Glasses', 'Chair', 'Clock', 'Pen'],
    ),
    QuestionGeneralMcq(
      imagePath: 'assets/image/general/school.png',
      answer: 'School',
      choice: ['School', 'Ball', 'Computer', 'Pizza'],
    ),
    QuestionGeneralMcq(
      imagePath: 'assets/image/general/umbrella.png',
      answer: 'Umbrella',
      choice: ['Umbrella', 'Book', 'Clock', 'Lamp'],
    ),
  ];

  List<String> itemNames = [
    'Watch',
    'Ball',
    'Computer',
    'Chair',
    'Table',
    'Book',
    'Pen',
    'Bag',
    'Glasses',
    'Phone',
    'Wallet',
    'Key',
    'Headphones',
    'Camera',
    'Umbrella',
    'Knife',
    'Plate',
    'Cup',
    'Spoon',
    'Fork',
    'Scissors',
    'Brush',
    'Mirror',
    'Lamp',
  ];
}
