import 'package:flutter/material.dart';
import 'package:intelligent_learning/Learning/page_header.dart';
import 'package:intelligent_learning/Learning/tile_card.dart';
import 'package:intelligent_learning/Question/components/card_details.dart';
import 'package:just_audio/just_audio.dart';

class NumericEnScreen extends StatefulWidget {
  final String title;
  final Color primaryColor;
  final Color secondaryColor;
  final List letter;

  const NumericEnScreen({
    required this.title,
    required this.primaryColor,
    required this.secondaryColor, required this.letter,
  });

  @override
  State<NumericEnScreen> createState() => _NumericEnScreenState();
}

class _NumericEnScreenState extends State<NumericEnScreen> {
  final _scrollController = ScrollController();
  final _audioPlayer = AudioPlayer();
  double offset = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  void onScroll() {
    setState(() {
      offset = (_scrollController.hasClients) ? _scrollController.offset : 0;
    });
  }

  void _playAudio(String assetPath) async {
    try {
      await _audioPlayer.setAsset(assetPath);
      _audioPlayer.play();
    } catch (e) {
      debugPrint("Error loading audio source: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: PageHeader(
              title: widget.title,
              primaryColor: widget.primaryColor,
              secondaryColor: widget.secondaryColor,
              offset: offset,
            ),
          ),
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20.0,
            ),
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                return Padding(
                  padding: index % 2 == 0
                      ? const EdgeInsets.only(bottom: 20, left: 20)
                      : const EdgeInsets.only(bottom: 20, right: 20),
                  child: TileCard(
                    title: widget.letter[index].text,
                    textColor: getIndexColor(index),
                    onTap: () => _playAudio(widget.letter[index].audio),
                  ),
                );
              },
              childCount: widget.letter.length,
            ),
          ),
        ],
      ),
    );
  }
}
