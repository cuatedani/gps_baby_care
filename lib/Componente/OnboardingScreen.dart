import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({
    Key? key,
    this.text,
    this.image,
  }) : super(key: key);
  final String? text, image;

  @override
  State<OnboardingScreen> createState() => _SplashContentState();
}

class _SplashContentState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Spacer(flex: 2,),
        const Text(
          "BABY CARE",
          style: TextStyle(
            fontSize: 32,
            color: Colors.brown,
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacer(),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            widget.text!,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
        ),
        const Spacer(flex: 2),
        Image.asset(
          widget.image!,
          height: 265,
          width: 235,
        ),
      ],
    );
  }
}