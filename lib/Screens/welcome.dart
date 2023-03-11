import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  double _size = 0;

  void _updateSize() {
    if (_size == 300)
      setState(() {
        _size = 250;
      });
    else {
      setState(() {
        _size = 300;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Center(
          widthFactor: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedTextKit(
                animatedTexts: [
                  WavyAnimatedText(
                    'Welcome to',
                    textStyle: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                      fontFamily: 'Times',
                    ),
                  ),
                ],
                isRepeatingAnimation: false,

                onFinished: () => _updateSize(),
                // totalRepeatCount: 4,
                pause: const Duration(milliseconds: 1),
                // displayFullTextOnTap: true,
                // stopPauseOnTap: true,
              ),
              AnimatedSize(
                curve: Curves.easeIn,
                duration: Duration(milliseconds: 1500),
                child: Image.asset(
                  'assets/images/bitebuddy_black.png',
                  height: _size,
                  width: _size,
                ),
              )
            ],
          ),
        ));
  }
}
