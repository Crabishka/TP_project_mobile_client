import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sportique/app.dart';

import '../../../viewmodel/custom/ColorCustom.dart';

class OrderPageWithoutOrder extends StatefulWidget {
  const OrderPageWithoutOrder({super.key});

  @override
  State<OrderPageWithoutOrder> createState() => _OrderPageWithoutOrderState();
}

class _OrderPageWithoutOrderState extends State<OrderPageWithoutOrder> {
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
              Center(
                child: Text(
                  "Корзина",
                  style: TextStyle(
                      color: ColorCustom().titleColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 32),
                ),
              ),
              const Spacer(),
              Image.asset("./assets/images/bike.png"),
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Text(
                  "Вы пока не выбрали ни одного товара. "
                  " Перейдите на страницу каталога.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 0, backgroundColor: const Color(0xFF3EB489)),
                onPressed: () {
                  App.changeIndex(0);
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => App()));
                },
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text("В каталог",
                      style: TextStyle(
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
