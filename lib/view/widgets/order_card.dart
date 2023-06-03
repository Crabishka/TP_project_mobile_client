import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../model/data/order.dart';
import '../../viewmodel/user_model.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key, required this.order});

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 1,
        color: const Color(0xFFEFFBFD),
        child: Container(
          padding: const EdgeInsets.fromLTRB(8, 16, 16, 0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                child: Text(
                  "Стоимость: ${order.sum.truncate()} руб/час",
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                )),
            Container(
                padding: const EdgeInsets.fromLTRB(8, 8, 0, 0),
                child: Text("Дата: ${DateFormat('dd-MM-yyyy').format(order.date)}",
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ))),
            Container(
                padding: const EdgeInsets.fromLTRB(8, 8, 0, 0),
                child: Text(order.status.getStatusText(),
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ))),
            Container(
              height: (MediaQuery.of(context).size.width - 7 * 4) / 4,
              padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: order.products.length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Image.network(
                              order.products[index].description.image),
                        ));
                  }),
            ),
            if (order.status == OrderStatus.WAITING_FOR_RECEIVING)
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 0, 8),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFb43e69),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4))),
                  onPressed: () {
                    Provider.of<UserModel>(context, listen: false)
                        .cancelOrder();
                  },
                  child: const Text("Отменить",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      )),
                ),
              ),
            const SizedBox(
              height: 8,
            )
          ]),
        ));
  }
}
