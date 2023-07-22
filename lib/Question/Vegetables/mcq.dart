class QuestionVegetableMcq {
  final String imagePath;
  final String answer;
  final List<String> choice;

  QuestionVegetableMcq({
    required this.imagePath,
    required this.answer,
    required this.choice,
  });
}

class QuestionVegetableDataMcq {
  List<QuestionVegetableMcq> questions = [
    QuestionVegetableMcq(
      imagePath: 'assets/image/vegetables/broccoli.png',
      answer: 'Broccoli',
      choice: ['Broccoli', 'Corn', 'Cucumber', 'Tomato'],
    ),
    QuestionVegetableMcq(
      imagePath: 'assets/image/vegetables/carrot.png',
      answer: 'Carrot',
      choice: ['Carrot', 'Broccoli', 'Onion', 'Salad'],
    ),
    QuestionVegetableMcq(
      imagePath: 'assets/image/vegetables/corn.png',
      answer: 'Corn',
      choice: ['Corn', 'Cucumber', 'Pepper', 'Tomato'],
    ),
    QuestionVegetableMcq(
      imagePath: 'assets/image/vegetables/cucumber.png',
      answer: 'Cucumber',
      choice: ['Cucumber', 'Broccoli', 'Onion', 'Potato'],
    ),
    QuestionVegetableMcq(
      imagePath: 'assets/image/vegetables/eggplant.png',
      answer: 'Eggplant',
      choice: ['Eggplant', 'Carrot', 'Pepper', 'Tomato'],
    ),
    QuestionVegetableMcq(
      imagePath: 'assets/image/vegetables/onion.png',
      answer: 'Onion',
      choice: ['Onion', 'Broccoli', 'Pepper', 'Potato'],
    ),
    QuestionVegetableMcq(
      imagePath: 'assets/image/vegetables/pepper.png',
      answer: 'Pepper',
      choice: ['Pepper', 'Carrot', 'Cucumber', 'Salad'],
    ),
    QuestionVegetableMcq(
      imagePath: 'assets/image/vegetables/potato.png',
      answer: 'Potato',
      choice: ['Potato', 'Corn', 'Eggplant', 'Salad'],
    ),
    QuestionVegetableMcq(
      imagePath: 'assets/image/vegetables/salad.png',
      answer: 'Salad',
      choice: ['Salad', 'Corn', 'Eggplant', 'Potato'],
    ),
    QuestionVegetableMcq(
      imagePath: 'assets/image/vegetables/tomato.png',
      answer: 'Tomato',
      choice: ['Tomato', 'Carrot', 'Eggplant', 'Onion'],
    ),
  ];

  List<String> vegetableNames = [
    'Carrot',
    'Broccoli',
    'Tomato',
    'Potato',
    'Cucumber',
    'Onion',
    'Pepper',
    'Eggplant',
    'Peas',
    'Corn',
    'Beans',
    'Salad',
  ];

}
