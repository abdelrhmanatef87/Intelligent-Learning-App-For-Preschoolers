import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:intelligent_learning/Learning/models/animal.dart';
import 'package:intelligent_learning/Learning/widgets/object_card.dart';
import 'package:intelligent_learning/Learning/page_header.dart';

class ShowObjects extends StatefulWidget {
  final String title;
  final Color primaryColor;
  final Color secondaryColor;
  final List<Info> items;

  const ShowObjects({
    required this.title,
    required this.primaryColor,
    required this.secondaryColor,
    required this.items,
  });

  @override
  State<ShowObjects> createState() => _ShowObjectsState();
}

class _ShowObjectsState extends State<ShowObjects> {
  List<Info> items = [];

  @override
  void initState() {
    items = widget.items;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          PageHeader(
            title: widget.title,
            primaryColor: widget.primaryColor,
            secondaryColor: widget.secondaryColor,
            offset: 0,
          ),
          ListView.builder(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.all(5.0),
              itemCount: items.length,
              itemBuilder: (context, index) => ObjectCard(
                  object: items[index],
                  onPressed: () {
                    playsound(items[index].name);
                    setState(() {
                      items[index].turns+=1;
                    });
                  })),
        ],
      ),
    ));
  }

  void playsound(String imageVoice) async {
    FlutterTts ftts = FlutterTts();
    await ftts.setLanguage("en-US");
    await ftts.setSpeechRate(0.3); //speed of speech
    await ftts.setVolume(1.0); //volume of speech
    await ftts.setPitch(1.0); //pitc of sound 0.5 to 1.5
    await ftts.speak(imageVoice);
  }
}
