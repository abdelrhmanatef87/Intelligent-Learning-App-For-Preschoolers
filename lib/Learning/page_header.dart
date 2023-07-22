import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intelligent_learning/Question/components/card_details.dart';
import 'package:just_audio/just_audio.dart';

class PageHeader extends StatefulWidget {
  final String title;
  final Color primaryColor;
  final Color secondaryColor;
  final double offset;

  const PageHeader({
    Key? key,
    required this.title,
    required this.primaryColor,
    required this.secondaryColor,
    required this.offset,
  }) : super(key: key);

  @override
  State<PageHeader> createState() => _PageHeaderState();
}

class _PageHeaderState extends State<PageHeader> {
  final _audioPlayer = AudioPlayer();

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _popAudio() async {
    try {
      await _audioPlayer.setAsset(
        'assets/audio/screen_transition/pop-page-back-chime.wav',
      );
      _audioPlayer.play();
    } catch (e) {
      debugPrint("Error loading Navigator.pop audio: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyClipper(),
      child: Container(
        padding: const EdgeInsets.only(left: 30, top: 60, right: 30),
        height: 300,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [widget.primaryColor, widget.secondaryColor],
          ),
          image: const DecorationImage(
            image: AssetImage("assets/image/learning/bg-stars.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                onTap: () {
                  _popAudio();
                  HapticFeedback.lightImpact();
                  Navigator.pop(context);
                },
                child: const Text(
                  '<<',
                  style: TextStyle(
                    fontSize: 42,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: 30 - widget.offset / 4,
                    child: Text(
                      widget.title,
                      style: kHeadingTextStyle.copyWith(
                        fontSize: widget.title.length < 8 ? 55 : 45,
                        letterSpacing: 4.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height + 0, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
