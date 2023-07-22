import 'package:flutter/material.dart';
import 'package:intelligent_learning/Learning/category_card.dart';
import 'package:intelligent_learning/Learning/models/animal.dart';
import 'package:intelligent_learning/Learning/models/fruit.dart';
import 'package:intelligent_learning/Learning/models/number.dart';
import 'package:intelligent_learning/Learning/models/transport.dart';
import 'package:intelligent_learning/Learning/models/vegetable.dart';
import 'package:intelligent_learning/Learning/screens/objects_screen.dart';
import 'package:intelligent_learning/Learning/screens/color_screen.dart';
import 'package:intelligent_learning/Learning/screens/letters_screen.dart';
import 'package:intelligent_learning/model/Theme.dart';
import 'package:provider/provider.dart';

class Learning extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _Learning();
  }
}

class _Learning extends State<Learning> {
  final List<Widget> categories = [
    CategoryCard(
      title: 'Colors',
      primaryColor: Colors.orangeAccent[100]!,
      secondaryColor: Colors.orange,
      screen: ColorScreen(
        title: 'Colors',
        primaryColor: Colors.orangeAccent[100]!,
        secondaryColor: Colors.orange,
      ),
    ),

    CategoryCard(
      title: '123',
      primaryColor: Colors.greenAccent[100]!,
      secondaryColor: Colors.green,
      screen: NumericEnScreen(
        title: '123',
        primaryColor: Colors.greenAccent[100]!,
        secondaryColor: Colors.green,
        letter: numericEnList,
      ),
    ),

    CategoryCard(
      title: 'ABC',
      primaryColor: Colors.purpleAccent[100]!,
      secondaryColor: Colors.purple,
      screen: NumericEnScreen(
        title: 'ABC',
        primaryColor: Colors.purpleAccent[100]!,
        secondaryColor: Colors.purple,
        letter: alphabetEnList,
      ),
    ),

    CategoryCard(
      title: 'Animals',
      primaryColor: Colors.yellow[100]!,
      secondaryColor: Colors.yellow,
      screen: ShowObjects(
        title: 'Animals',
        primaryColor: Colors.yellow[100]!,
        secondaryColor: Colors.yellow,
        items: animallist,
      ),
    ),

    CategoryCard(
      title: 'Fruits',
      primaryColor: Color(0xFF3383CD),
      secondaryColor: Color(0xFF11249F),
      screen: ShowObjects(
        title: 'Fruits',
        primaryColor: Color(0xFF3383CD),
        secondaryColor: Color(0xFF11249F),
        items: fruitlist,
      ),
    ),

    CategoryCard(
      title: 'Vegetables',
      primaryColor: Colors.redAccent[100]!,
      secondaryColor: Colors.red,
      screen: ShowObjects(
        title: 'Vegetables',
        primaryColor: Colors.redAccent[100]!,
        secondaryColor: Colors.red,
        items: vegetablelist,
      ),
    ),

    CategoryCard(
      title: 'Transports',
      primaryColor: Colors.brown[100]!,
      secondaryColor: Colors.brown,
      screen: ShowObjects(
        title: 'Transports',
        primaryColor: Colors.brown[100]!,
        secondaryColor: Colors.brown,
        items: transportlist,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<ModelTheme>(
      builder: (context, ModelTheme themeNotifier, child) {
        return Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/image/learning/bg-bottom.png'),
                alignment: Alignment.bottomCenter,
              ),
            ),

            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: <Widget>[
                SliverAppBar(
                  leading: IconButton(icon: const Icon(Icons.arrow_back) , onPressed: (){Navigator.pop(context);} , color: Colors.green, iconSize: 30,),
                  expandedHeight: 150.0,
                  backgroundColor: Colors.transparent,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.asset(
                      'assets/image/learning/learn.png',
                      alignment: Alignment.topCenter,
                    ),
                  ),
                ),

                SliverList(
                  delegate: SliverChildListDelegate(categories),
                ),
              ],
            ),
          ),
        );
      });
  }
}
