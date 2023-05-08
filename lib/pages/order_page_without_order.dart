import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sportique/app.dart';
import 'package:sportique/pages/catalog_page.dart';

class OrderPageWithoutOrder extends StatelessWidget {
  const OrderPageWithoutOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        color: const Color(0xFFEFFBFD),
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            const Padding(
                padding: EdgeInsets.all(30),
                child: Text(
                  "Вы пока не выбрали ни одного товара. Перейдите на страницу каталога",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 36,
                      fontFamily: 'PoiretOne',
                      fontWeight: FontWeight.bold),
                )),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15))),
              onPressed: () {
                App.changeIndex(0);
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => App()));
              },
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Text("В каталог",
                    style: TextStyle(
                      color: Colors.cyanAccent,
                      fontFamily: 'PoiretOne',
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    )),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
