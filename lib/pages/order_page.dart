import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sportique/client_api/user_repository.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sportique/widgets/product_little_card.dart';

import '../data/order.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    Order order = UserRepository.instance.getUser().getUserActiveOrder();

    return Scaffold(
        backgroundColor: const Color(0xFFB6CFD8),
        body: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  if (order != null)
                    SliverToBoxAdapter(
                        child: Padding(
                      padding: const EdgeInsets.fromLTRB(50, 80, 50, 30),
                      child: QrImage(
                        padding: const EdgeInsets.all(30),
                        data: UserRepository.instance.getUser().toString(),
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
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                onPressed: () {},
                child: const Text("Отменить",
                    style: TextStyle(
                      color: Colors.cyanAccent,
                      fontFamily: 'PoiretOne',
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    )),
              ),
            ),
          ],
        ));
  }
}
