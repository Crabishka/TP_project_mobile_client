import 'package:flutter/material.dart';
import 'package:sportique/data/order_status.dart';

import '../data/order.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key, required this.order});

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 10,
        color: const Color(0xFFEFFBFD),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: Text(
                "Стоимость : ${order.sum} ",
                textAlign: TextAlign.left,
                style: const TextStyle(
                  color: Color(0xFF3C2C9E),
                  fontFamily: 'PoiretOne',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              )),
          Container(
              padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
              child: Text(
                  "Время :  ${order.date.day}-${order.date.month}-${order.date.year}",
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    color: Color(0xFF3C2C9E),
                    fontFamily: 'PoiretOne',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ))),
          SizedBox(
            height: (MediaQuery.of(context).size.width - 7 * 6) / 4,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: order.products.length,
                itemBuilder: (context, index) {
                  return Padding(
                      padding:
                          const EdgeInsets.all(8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                            order.products[index].description.image),
                      ));
                }),
          ),
          if (order.status == OrderStatus.WAITING_FOR_RECEIVING)
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(

                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
                ),
                onPressed: () {},
                child: const Text("Отменить",
                    style: TextStyle(
                      color: Colors.cyanAccent,
                      fontFamily: 'PoiretOne',
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    )),
              ),
            ),
          const SizedBox(
            height: 8,
          )
        ]));
  }
}
