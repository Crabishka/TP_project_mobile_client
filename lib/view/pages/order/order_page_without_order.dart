import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sportique/app.dart';

class OrderPageWithoutOrder extends StatelessWidget {
  const OrderPageWithoutOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SafeArea(
        child: Container(
          color: const Color(0xFFEFFBFD),
          child: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              const Center(
                child: Text(
                  "Корзина",
                  style: TextStyle(
                      fontFamily: 'PoiretOne',
                      fontWeight: FontWeight.bold,
                      fontSize: 32),
                ),
              ),
              const Spacer(),
              Image.asset("./assets/images/bike.png"),
              const Text(
                "Вы пока не выбрали ни одного товара. \n"
                " Перейдите на страницу каталога.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'PoiretOne',
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 8,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: const Color(0xFF3EB489)),
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
                        fontSize: 28,
                      )),
                ),
              ),
              const Spacer(),
              const Spacer(),
              const SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
