import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.all(40),
      child: OnBoardContent(
        image: "./assets/images/img.png",
        text: "Выберите спортивный инвентарь, который хотите забронировать",
      )
    ));
  }
}

class OnBoardContent extends StatelessWidget{

  final String image;
  final String text;

  const OnBoardContent({super.key, required this.image, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Image.asset(
          image,
        ),
        const Spacer(),
        Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 28,
              fontFamily: "PoiretOne",
              fontWeight: FontWeight.w900),
        ),
        const Spacer()
      ],
    );
  }

}