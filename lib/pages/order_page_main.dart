import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sportique/client_api/user_repository.dart';
import 'package:sportique/pages/order_page_ready_to_get.dart';

import '../data/order.dart';
import '../data/user.dart';
import 'order_page_carting.dart';
import 'order_page_without_order.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB6CFD8),
      body: FutureBuilder<User>(
        future: UserRepository.instance.getUser(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const OrderPageWithoutOrder();
          } else {
            final order = snapshot.data?.orders?.first;
            return returnWidget(order);
          }
        },
      ),
    );
  }

  Widget returnWidget(Order? order) {
    if (order != null) {
      if (order.status == OrderStatus.WAITING_FOR_RECEIVING) {
        return OrderPageReadyToGet(order: order);
      } else if (order.status == OrderStatus.CARTING) {
        return OrderPageCarting(order: order);
      }
    }
    return const OrderPageWithoutOrder();
  }
}
