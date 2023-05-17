import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:sportique/widgets/order_product_cart.dart';

import '../../client_api/user_repository.dart';
import '../../data/order.dart';
import '../../internal/app_data.dart';
import '../../widgets/product_little_card.dart';

class OrderPageCarting extends StatelessWidget {
  final Order order;

  OrderPageCarting({super.key, required this.order});
  GetIt getIt = GetIt.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFB6CFD8),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(
            height: 40,
          ),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                      childCount: order.products.length, (context, index) {
                    return Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                        child: OrderProductCard(
                          product: order.products[index],
                        ));
                  }),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Количество товаров в корзине ${order.products.length}",
                  style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'PoiretOne',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Text(
                  "Общая стоимость ${order.sum} руб/час",
                  style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'PoiretOne',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15))),
              onPressed: null,
              child: Text(
                  getIt<AppData>().getDate() == null
                      ? "Выберите удобную дату"
                      : "Выбранная дата: "
                      " ${DateFormat('dd-MMM').format(getIt<AppData>().getDate()!)}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'PoiretOne',
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  )),
            ),
          ),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15))),
              onPressed: () {
                // FIXME
              },
              child: const Text("Заказать",
                  style: TextStyle(
                    color: Colors.cyanAccent,
                    fontFamily: 'PoiretOne',
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  )),
            ),
          )
        ]));
  }
}
