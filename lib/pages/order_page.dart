import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
        body: CustomScrollView(
          slivers: [
            if (order != null)
              SliverToBoxAdapter(
                  child: Padding(
                padding: const EdgeInsets.fromLTRB(50, 80, 50, 30),
                child: QrImage(
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
            )
          ],
        ));
  }
}
