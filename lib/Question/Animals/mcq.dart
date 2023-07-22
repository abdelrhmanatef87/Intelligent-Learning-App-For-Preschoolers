class QuestionAnimalMcq {
  final String imagePath;
  final String answer;
  final List<String> choice;

  QuestionAnimalMcq({
    required this.imagePath,
    required this.answer,
    required this.choice,
  });
}

class QuestionAnimalDataMcq {
  List<QuestionAnimalMcq> questions = [

    QuestionAnimalMcq(
      imagePath: 'assets/image/animals/cat.png',
      answer: 'Cat',
      choice: ['Cat', 'Camel', 'Lion', 'Monkey'],
    ),
    QuestionAnimalMcq(
      imagePath: 'assets/image/animals/cow.png',
      answer: 'Cow',
      choice: ['Cow', 'Fish', 'Monkey', 'Tiger'],
    ),
    QuestionAnimalMcq(
      imagePath: 'assets/image/animals/dog.png',
      answer: 'Dog',
      choice: ['Dog', 'Cat', 'Horse', 'Lion'],
    ),
    // QuestionAnimalMcq(
    //   imagePath: 'assets/image/animals/elephant.png',
    //   answer: 'Elephant',
    //   choice: ['Elephant', 'Giraffe', 'Rabbit', 'Lion'],
    // ),
    QuestionAnimalMcq(
      imagePath: 'assets/image/animals/fish.png',
      answer: 'Fish',
      choice: ['Fish', 'Elephant', 'Cat', 'Lion'],
    ),
    QuestionAnimalMcq(
      imagePath: 'assets/image/animals/giraffe.png',
      answer: 'Giraffe',
      choice: ['Giraffe', 'Monkey', 'Tiger', 'Lion'],
    ),
    QuestionAnimalMcq(
      imagePath: 'assets/image/animals/horse.png',
      answer: 'Horse',
      choice: ['Horse', 'Dog', 'Rabbit', 'Tiger'],
    ),
    QuestionAnimalMcq(
      imagePath: 'assets/image/animals/monkey.png',
      answer: 'Monkey',
      choice: ['Monkey', 'Cow', 'Rabbit', 'Elephant'],
    ),
    // QuestionAnimalMcq(
    //   imagePath: 'assets/image/animals/rabbit.png',
    //   answer: 'Rabbit',
    //   choice: ['Rabbit', 'Dog', 'Fish', 'Horse'],
    // ),
    QuestionAnimalMcq(
      imagePath: 'assets/image/animals/tiger.png',
      answer: 'Tiger',
      choice: ['Tiger', 'Cow', 'Elephant', 'Giraffe'],
    ),
    QuestionAnimalMcq(
      imagePath: 'assets/image/animals/lion.png',
      answer: 'Lion',
      choice: ['Lion', 'Crab', 'Elephant', 'Fish'],
    ),
    QuestionAnimalMcq(
      imagePath: 'assets/image/animals/crab.png',
      answer: 'Crab',
      choice: ['Crab', 'Cow', 'Rabbit', 'Lion'],
    ),
  ];

  List<String> animalNames = [
    'Dog',
    'Cat',
    'Horse',
    'Elephant',
    'Lion',
    'Tiger',
    'Giraffe',
    'Monkey',
    'Bear',
    'Bird',
    'Snake',
    'Fish',
    'Dolphin',
    'Kangaroo',
    'Sheep',
    'Cow',
    'Penguin',
    'Rabbit',
    'Fox',
    'Owl',
    'Crocodile',
    'Turtle',
    'Deer',
    'Wolf',
    'Zebra',
  ];
}
