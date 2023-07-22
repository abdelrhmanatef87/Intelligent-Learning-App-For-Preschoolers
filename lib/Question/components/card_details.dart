import 'package:flutter/material.dart';

class ListDetail {
  ListDetail({
      required this.title,
      required this.iconAssetName,
      required this.gradients,
      required this.shadowColor,
      required this.iconTag,
      // required this.category,
      required this.textColor
    });
  final String title;
  final String iconAssetName;
  final List<Color> gradients;
  final Color shadowColor;
  final String iconTag;
  // final String category;
  final Color textColor;
}

const double opacity = 0.4;

final List<ListDetail> cardDetailList = [
  ListDetail(
    title: 'Animals',
    iconAssetName: 'assets/image/question/animals.png',
    gradients: [
      const Color(0xff089e44),
      const Color(0xff3dd178),
    ],
    shadowColor: const Color(0xff3dd178).withOpacity(opacity),
    iconTag: 'animals',
    // category: 'animals',
     textColor: const Color(0xff089e44),
  ),
  ListDetail(
    title: 'Fruits',
    iconAssetName: 'assets/image/question/fruits.png',
    gradients: [
      const Color(0xff5718d6),
      const Color(0xff8048f0),
    ],
    shadowColor: const Color(0xff8048f0).withOpacity(opacity),
    iconTag: 'fruits',
    // category: 'fruits',
    textColor: const Color(0xff5718d6),
  ),
  ListDetail(
    title: 'Vegetables',
    iconAssetName: 'assets/image/question/vegetable.png',
    gradients: [
      const Color(0xffd6182e),
      const Color(0xffed475a),
    ],
    shadowColor: const Color(0xffed475a).withOpacity(opacity),
    iconTag: 'vegetables',
    // category: 'cegetables',
    textColor: const Color(0xffd6182e),
  ),
  ListDetail(
    title: 'Body',
    iconAssetName: 'assets/image/question/body.png',
    gradients: [
      const Color(0xff0846a3),
      const Color(0xff387ee8),
    ],
    shadowColor: const Color(0xff387ee8).withOpacity(opacity),
    iconTag: 'body',
    // category: 'body',
    textColor: const Color(0xff0846a3),
  ),
  ListDetail(
    title: 'Numbers',
    iconAssetName: 'assets/image/question/number.png',
    gradients: [
      const Color(0xffd97014),
      const Color(0xfff2a057),
    ],
    shadowColor: const Color(0xfff2a057).withOpacity(opacity),
    iconTag: 'numbers',
    // category: 'numbers',
    textColor: const Color(0xffd97014),
  ),
  ListDetail(
    title: 'Car',
    iconAssetName: 'assets/image/question/vehicle.png',
    gradients: [
      const Color(0xff1c0659),
      const Color(0xff3c2a70),
    ],
    shadowColor: const Color(0xff3c2a70).withOpacity(opacity),
    iconTag: 'car',
    // category: 'car',
    textColor: const Color(0xff3c2a70),
  ),
  ListDetail(
    title: 'Color',
    iconAssetName: 'assets/image/question/color.png',
    gradients: [
      const Color(0xff28272b),
      const Color(0xff48474a),
    ],
    shadowColor: const Color(0xff48474a).withOpacity(opacity),
    iconTag: 'color',
    // category: 'color',
    textColor: const Color(0xff28272b),
  ),
  ListDetail(
    title: 'Clothes',
    iconAssetName: 'assets/image/question/clothes.png',
    gradients: [
      const Color(0xffeb2aeb),
      const Color(0xfffc7efc),
    ],
    shadowColor: const Color(0xfffc7efc).withOpacity(opacity),
    iconTag: 'clothes',
    // category: 'clothes',
    textColor: const Color(0xffeb2aeb),
  ),
  ListDetail(
    title: 'Country',
    iconAssetName: 'assets/image/question/country.png',
    gradients: [
      const Color(0xfff2bd05),
      const Color(0xffe6c657),
    ],
    shadowColor: const Color(0xffe6c657).withOpacity(opacity),
    iconTag: 'country',
    // category: 'country',
    textColor: const Color(0xfff2bd05),
  ),
  ListDetail(
    title: 'General',
    iconAssetName: 'assets/image/question/general.png',
    gradients: [
      const Color(0xff395c91),
      const Color(0xff75aafa),
    ],
    shadowColor: const Color(0xff75aafa).withOpacity(opacity),
    iconTag: 'general',
    // category: 'general',
    textColor: const Color(0xff395c91),
  ),
];


class ItemModel{
  final String name;
  final String img;
  final String value;
  bool accepting;
  ItemModel({required this.name,required this.value,required this.img,this.accepting=false});
}

const kHeadingTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 64,
  fontWeight: FontWeight.w700,
  letterSpacing: 4.0,
);

Color getIndexColor(int index, {double opacity = 0.8}) {
  return Colors.primaries[index % Colors.primaries.length].withOpacity(opacity);
}