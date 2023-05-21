import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


import '../../../model/data/order.dart';
import '../../../viewmodel/internal/app_data.dart';
import '../../../viewmodel/user_model.dart';
import '../../widgets/order_product_cart.dart';


class OrderPageCarting extends StatefulWidget {
  final Order order;

  OrderPageCarting({super.key, required this.order});

  @override
  State<OrderPageCarting> createState() => _OrderPageCartingState();
}

class _OrderPageCartingState extends State<OrderPageCarting> {
  GetIt getIt = GetIt.instance;
  bool shouldRefresh = false;

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
                      childCount: widget.order.products.length, (context, index) {
                    return Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                        child: OrderProductCard(
                          product: widget.order.products[index],
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
                  "Общая стоимость ${widget.order.sum} руб/час",
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
                      " ${DateFormat('dd-MMM').format(widget.order.date)}",
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
                Provider.of<UserModel>(context, listen: false).makeOrder();
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
