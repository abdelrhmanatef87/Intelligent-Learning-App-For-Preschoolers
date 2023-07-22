import 'package:flutter/material.dart';
import 'package:intelligent_learning/Learning/models/animal.dart';
import 'package:intelligent_learning/Question/components/card_details.dart';
import 'package:intelligent_learning/model/color.dart';

class ObjectCard extends StatelessWidget {
  ObjectCard({required this.object, required this.onPressed,});
  final Info object;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(10.0),
        width: double.infinity,
        height: 185,
        child: Stack(
          children: <Widget>[
            Positioned(
                left: width * 0.12,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 10),
                        blurRadius: 20,
                        color: AppColors.kActiveShadowColor,
                      ),
                    ],
                  ),
                  constraints:
                      BoxConstraints(maxWidth: width * 0.79, maxHeight: 150),
                )),
            Positioned(
              child: AnimatedRotation(
                turns: object.turns,
                duration: const Duration(milliseconds: 900),
                child: Image(
                  image: AssetImage(object.iconImage),
                  width: 150,
                  height: 150,
                ),
              ),),
            Positioned(
                bottom: width*0.05,
                right: width*0.05,
                child: Text(
                  object.name,
                  style: TextStyle(
                    color: getIndexColor(object.index,opacity: 0.9),
                    fontSize: object.name.length < 10 ? 50 : 40,
                    fontFamily: 'CabinSketch',
                    fontWeight: FontWeight.w700,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
