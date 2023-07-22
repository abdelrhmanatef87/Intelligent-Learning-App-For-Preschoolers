
class QuestionClothesMcq {
  final String imagePath;
  final String answer;
  final List<String> choice;

  QuestionClothesMcq({
    required this.imagePath,
    required this.answer,
    required this.choice,
  });
}

class QuestionClothesDataMcq {
  List<QuestionClothesMcq> questions = [

    QuestionClothesMcq(
      imagePath: 'assets/image/clothes/bag.png',
      answer: 'Bag',
      choice: ['Bag', 'Hat', 'Suit', 'Watch'],
    ),
    QuestionClothesMcq(
      imagePath: 'assets/image/clothes/dress.png',
      answer: 'Dress',
      choice: ['Dress', 'Hat', 'Socks', 'Watch'],
    ),
    QuestionClothesMcq(
      imagePath: 'assets/image/clothes/hat.png',
      answer: 'Hat',
      choice: ['Hat', 'Jacket', 'Socks', 'Shirt'],
    ),
    QuestionClothesMcq(
      imagePath: 'assets/image/clothes/jacket.png',
      answer: 'Jacket',
      choice: ['Jacket', 'Hat', 'Suit', 'Shirt'],
    ),
    QuestionClothesMcq(
      imagePath: 'assets/image/clothes/sneaker.png',
      answer: 'Sneaker',
      choice: ['Sneaker', 'Jacket', 'Socks', 'Trousers'],
    ),
    QuestionClothesMcq(
      imagePath: 'assets/image/clothes/socks.png',
      answer: 'Socks',
      choice: ['Socks', 'Jacket', 'Suit', 'Shirt'],
    ),
    QuestionClothesMcq(
      imagePath: 'assets/image/clothes/suit.png',
      answer: 'Suit',
      choice: ['Suit', 'Bag', 'Sneaker', 'Trousers'],
    ),
    QuestionClothesMcq(
      imagePath: 'assets/image/clothes/trousers.png',
      answer: 'Trousers',
      choice: ['Trousers', 'Dress', 'Sneaker', 'Watch'],
    ),
    QuestionClothesMcq(
      imagePath: 'assets/image/clothes/shirt.png',
      answer: 'Shirt',
      choice: ['Shirt', 'Dress', 'Socks', 'Trousers'],
    ),
    QuestionClothesMcq(
      imagePath: 'assets/image/clothes/watch.png',
      answer: 'Watch',
      choice: ['Watch', 'Dress', 'Sneaker', 'Shirt'],
    ),
  ];

  List<String> clothingNames = [
    'T-shirt',
    'Jeans',
    'Dress',
    'Shirt',
    'Skirt',
    'Sweater',
    'Jacket',
    'Coat',
    'Shorts',
    'Hoodie',
    'Pants',
    'Blouse',
    'Suit',
    'Socks',
    'Shoes',
    'Boots',
    'Sandals',
    'Hat',
    'Gloves',
    'Scarf',
    'Belt',
    'Tie',
    'Sunglasses',
  ];
}
