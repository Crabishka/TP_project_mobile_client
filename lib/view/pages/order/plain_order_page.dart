import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../model/data/order.dart';
import '../../widgets/product_little_card.dart';

class PlainOrderPage extends StatelessWidget {
  final Order order;

  PlainOrderPage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFB6CFD8),
        body: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 40,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Text(
                      "Ваш заказ на ${DateFormat('dd-MMM').format(order.date)}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontFamily: 'PoiretOne',
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Text(
                      "В статусе ${order.status.getStatusText()}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontFamily: 'PoiretOne',
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                  SliverToBoxAdapter(
                      child: Padding(
                    padding: const EdgeInsets.fromLTRB(50, 20, 50, 30),
                    child: QrImage(
                      padding: const EdgeInsets.all(30),
                      data: order.id.toString(),
                      backgroundColor: Colors.white,
                    ),
                  )),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                        childCount: order.products.length, (context, index) {
                      return Padding(
                          padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                          child: ProductLittleCard(
                            product: order.products[index],
                          ));
                    }),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
