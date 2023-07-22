class QuestionFruitMcq {
  final String imagePath;
  final String answer;
  final List<String> choice;

  QuestionFruitMcq({
    required this.imagePath,
    required this.answer,
    required this.choice,
  });
}

class QuestionFruitDataMcq {
  List<QuestionFruitMcq> questions = [
    QuestionFruitMcq(
      imagePath: 'assets/image/fruits/apple.png',
      answer: 'Apple',
      choice: ['Apple', 'Banana', 'Guava', 'Mango'],
    ),
    QuestionFruitMcq(
      imagePath: 'assets/image/fruits/banana.png',
      answer: 'Banana',
      choice: ['Banana', 'Pineapple', 'Watermelon', 'Kiwi'],
    ),
    QuestionFruitMcq(
      imagePath: 'assets/image/fruits/grape.png',
      answer: 'Grape',
      choice: ['Grape', 'Guava', 'Apple', 'Orange'],
    ),
    QuestionFruitMcq(
      imagePath: 'assets/image/fruits/kiwi.png',
      answer: 'Kiwi',
      choice: ['Kiwi', 'Apple', 'Grape', 'Orange'],
    ),
    QuestionFruitMcq(
      imagePath: 'assets/image/fruits/mango.png',
      answer: 'Mango',
      choice: ['Mango', 'Orange', 'Strawberry', 'Grape'],
    ),
    QuestionFruitMcq(
      imagePath: 'assets/image/fruits/orange.png',
      answer: 'Orange',
      choice: ['Orange', 'Pineapple', 'Guava', 'Mango'],
    ),
    QuestionFruitMcq(
      imagePath: 'assets/image/fruits/guava.png',
      answer: 'Guava',
      choice: ['Guava', 'Strawberry', 'Strawberry', 'Orange'],
    ),
    QuestionFruitMcq(
      imagePath: 'assets/image/fruits/pineapple.png',
      answer: 'Pineapple',
      choice: ['Pineapple', 'Kiwi', 'Apple', 'Mango'],
    ),
    QuestionFruitMcq(
      imagePath: 'assets/image/fruits/strawberry.png',
      answer: 'Strawberry',
      choice: ['Strawberry', 'Apple', 'Banana', 'Kiwi'],
    ),
    QuestionFruitMcq(
      imagePath: 'assets/image/fruits/watermelon.png',
      answer: 'Watermelon',
      choice: ['Watermelon', 'Strawberry', 'Banana', 'Grape'],
    ),
  ];

  List<String> fruitNames = [
    'Apple',
    'Banana',
    'Orange',
    'Strawberry',
    'Grapes',
    'Watermelon',
    'Mango',
    'Pineapple',
    'Pear',
    'Peach',
    'Cherry',
    'Kiwi',
    'Blueberry',
    'Lemon',
    'Avocado',
    'Mandarin',
    'Plum',
    'Fig',
  ];
}
