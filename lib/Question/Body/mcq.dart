class QuestionBodyMcq {
  final String imagePath;
  final String answer;
  final List<String> choice;

  QuestionBodyMcq({
    required this.imagePath,
    required this.answer,
    required this.choice,
  });
}

class QuestionBodyDataMcq {
  List<QuestionBodyMcq> questions = [
    QuestionBodyMcq(
      imagePath: 'assets/image/body/ear.png',
      answer: 'Ear',
      choice: ['Ear', 'Face', 'Hair', 'Heart'],
    ),
    QuestionBodyMcq(
      imagePath: 'assets/image/body/eyes.png',
      answer: 'Eyes',
      choice: ['Eyes', 'Hair', 'Hand', 'Nose'],
    ),
    QuestionBodyMcq(
      imagePath: 'assets/image/body/face.png',
      answer: 'Face',
      choice: ['Face', 'Hair', 'Teeth', 'Leg'],
    ),
    QuestionBodyMcq(
      imagePath: 'assets/image/body/hair.png',
      answer: 'Hair',
      choice: ['Hair', 'Ear', 'Mouth', 'Nose'],
    ),
    QuestionBodyMcq(
      imagePath: 'assets/image/body/hand.png',
      answer: 'Hand',
      choice: ['Hand', 'Eyes', 'Teeth', 'Mouth'],
    ),
    QuestionBodyMcq(
      imagePath: 'assets/image/body/heart.png',
      answer: 'Heart',
      choice: ['Heart', 'Ear', 'Teeth', 'Leg'],
    ),
    QuestionBodyMcq(
      imagePath: 'assets/image/body/leg.png',
      answer: 'Leg',
      choice: ['Leg', 'Eyes', 'Hand', 'Nose'],
    ),
    QuestionBodyMcq(
      imagePath: 'assets/image/body/mouth.png',
      answer: 'Mouth',
      choice: ['Mouth', 'Ear', 'Heart', 'Monkey'],
    ),
    QuestionBodyMcq(
      imagePath: 'assets/image/body/nose.png',
      answer: 'Nose',
      choice: ['Nose', 'Face', 'Hand', 'Mouth'],
    ),
    QuestionBodyMcq(
      imagePath: 'assets/image/body/teeth.png',
      answer: 'Teeth',
      choice: ['Teeth', 'Eyes', 'Face', 'Leg'],
    ),
  ];

  List<String> bodyPartNames = [
    'Head',
    'Neck',
    'Shoulder',
    'Arm',
    'Hand',
    'Finger',
    'Leg',
    'Knee',
    'Ankle',
    'Foot',
    'Eye',
    'Ear',
    'Nose',
    'Mouth',
    'Teeth',
    'Tongue',
    'Chin',
  ];

}
