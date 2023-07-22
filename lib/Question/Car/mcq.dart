
class QuestionCarMcq {
  final String imagePath;
  final String answer;
  final List<String> choice;

  QuestionCarMcq({
    required this.imagePath,
    required this.answer,
    required this.choice,
  });
}

class QuestionCarDataMcq {
  List<QuestionCarMcq> questions = [

    QuestionCarMcq(
      imagePath: 'assets/image/car/bike.png',
      answer: 'Bike',
      choice: ['Bike', 'Car', 'Train', 'Boat'],
    ),
    QuestionCarMcq(
      imagePath: 'assets/image/car/bus.png',
      answer: 'Bus',
      choice: ['Bus', 'Airplane', 'Rocket', 'Taxi'],
    ),
    QuestionCarMcq(
      imagePath: 'assets/image/car/car.png',
      answer: 'Car',
      choice: ['Car', 'Motorcycle', 'Scooter', 'Boat'],
    ),
    QuestionCarMcq(
      imagePath: 'assets/image/car/train.png',
      answer: 'Train',
      choice: ['Train', 'Bike', 'Rocket', 'Taxi'],
    ),
    QuestionCarMcq(
      imagePath: 'assets/image/car/motorcycle.png',
      answer: 'Motorcycle',
      choice: ['Motorcycle', 'Airplane', 'Train', 'Boat'],
    ),
    QuestionCarMcq(
      imagePath: 'assets/image/car/rocket.png',
      answer: 'Rocket',
      choice: ['Rocket', 'Bus', 'Car', 'Taxi'],
    ),
    QuestionCarMcq(
      imagePath: 'assets/image/car/scooter.png',
      answer: 'Scooter',
      choice: ['Scooter', 'Bike', 'Train', 'Boat'],
    ),
    QuestionCarMcq(
      imagePath: 'assets/image/car/airplane.png',
      answer: 'Airplane',
      choice: ['Airplane', 'Bike', 'Bus', 'Scooter'],
    ),
    QuestionCarMcq(
      imagePath: 'assets/image/car/taxi.png',
      answer: 'Taxi',
      choice: ['Taxi', 'Airplane', 'Motorcycle', 'Scooter'],
    ),
    QuestionCarMcq(
      imagePath: 'assets/image/car/boat.png',
      answer: 'Boat',
      choice: ['Boat', 'Bus', 'Motorcycle', 'Rocket'],
    ),
  ];

  List<String> vehicleNames = [
    'Car',
    'Motorcycle',
    'Bus',
    'Truck',
    'Bicycle',
    'Scooter',
    'Train',
    'Boat',
    'Airplane',
    'Helicopter',
    'Ship',
    'Van',
    'Taxi',
    'Ambulance',
    'Firetruck',
    'Police Car',
    'Subway',
    'Golf Cart',
  ];
}
