class QuestionNumberMcq {
  final String imagePath;
  final String answer;
  final List<String> choice;

  QuestionNumberMcq({
    required this.imagePath,
    required this.answer,
    required this.choice,
  });
}

class QuestionNumberDataMcq {
  List<QuestionNumberMcq> questions = [
    QuestionNumberMcq(
      imagePath: 'assets/image/numbers/zero.png',
      answer: 'Zero',
      choice: ['Zero', 'Eight', 'Two', 'Seven'],
    ),
    QuestionNumberMcq(
      imagePath: 'assets/image/numbers/one.png',
      answer: 'One',
      choice: ['One', 'Four', 'Three', 'Five'],
    ),
    QuestionNumberMcq(
      imagePath: 'assets/image/numbers/two.png',
      answer: 'Two',
      choice: ['Two', 'Zero', 'Nine', 'Seven'],
    ),
    QuestionNumberMcq(
      imagePath: 'assets/image/numbers/three.png',
      answer: 'Three',
      choice: ['Three', 'Eight', 'Zero', 'Six'],
    ),
    QuestionNumberMcq(
      imagePath: 'assets/image/numbers/four.png',
      answer: 'Four',
      choice: ['Four', 'Zero', 'Eight', 'Nine'],
    ),
    QuestionNumberMcq(
      imagePath: 'assets/image/numbers/five.png',
      answer: 'Five',
      choice: ['Five', 'One', 'Three', 'Seven'],
    ),
    QuestionNumberMcq(
      imagePath: 'assets/image/numbers/six.png',
      answer: 'Six',
      choice: ['Six', 'One', 'Four', 'Eight'],
    ),
    QuestionNumberMcq(
      imagePath: 'assets/image/numbers/seven.png',
      answer: 'Seven',
      choice: ['Seven', 'Zero', 'Two', 'Five'],
    ),
    QuestionNumberMcq(
      imagePath: 'assets/image/numbers/eight.png',
      answer: 'Eight',
      choice: ['Eight', 'Six', 'Four', 'Nine'],
    ),
    QuestionNumberMcq(
      imagePath: 'assets/image/numbers/nine.png',
      answer: 'Nine',
      choice: ['Nine', 'One', 'Two', 'Six'],
    ),
  ];

  List<String> numberNames = [
    'Zero',
    'One',
    'Two',
    'Three',
    'Four',
    'Five',
    'Six',
    'Seven',
    'Eight',
    'Nine',
    'Ten',
  ];
}
