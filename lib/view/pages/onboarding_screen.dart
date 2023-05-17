import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../app.dart';


class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late PageController _pageController;

  int _pageIndex = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Expanded(
            child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _pageIndex = index;
                  });
                },
                itemCount: datas.length,
                itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                    child: OnBoardContent(
                      image: datas[index].image,
                      text: datas[index].text,
                    ))),
          ),
          Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(),
                ...List.generate(
                    datas.length,
                    (index) => Padding(
                        padding: EdgeInsets.all(16),
                        child: DotIndicator(
                          isActive: index == _pageIndex,
                        ))),
                Spacer(),
              ],
            ),
          ),
          if (_pageIndex == datas.length - 1)
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: SizedBox(
                height: 60,
                width: 60,
                child: ElevatedButton(
                  onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder:
                      (context) => App()));
                  },
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                  ),
                  child: Icon(Icons.arrow_forward),
                ),
              ),
            ),
          if (_pageIndex != datas.length - 1)
            const SizedBox(
              height: 80,
            )
        ],
      ),
    ));
  }
}

class DotIndicator extends StatelessWidget {
  final bool isActive;

  const DotIndicator({super.key, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 20,
      decoration: BoxDecoration(
          color: isActive ? Color(0xFF2482BC) : Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(12)),
          border: Border.all(color: Color(0xFF2482BC), width: 1)),
    );
  }
}

class Data {
  final String image, text;

  Data({required this.image, required this.text});
}

final List<Data> datas = [
  Data(
      image: "./assets/images/img.png",
      text: "Выберите спортивный инвентарь, который хотите забронировать"),
  Data(
      image: "./assets/images/img_4.png",
      text:
          "Получите QR код и покажите его работяге для получения спорт инвентаря"),
  Data(
      image: "./assets/images/img_5.png",
      text:
          "После прогулки покажите QR код работяге и оплатите наличными или отсканируйте QR для получения чека"),
];

class OnBoardContent extends StatelessWidget {
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
