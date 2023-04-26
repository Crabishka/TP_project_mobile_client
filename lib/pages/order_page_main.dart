import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sportique/client_api/user_repository.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sportique/data/order_status.dart';
import 'package:sportique/pages/order_page_ready_to_get.dart';
import 'package:sportique/widgets/product_little_card.dart';

import '../data/order.dart';
import 'order_page_carting.dart';
import 'order_page_wothout_order.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    Order order = UserRepository.instance.getUser().getUserActiveOrder();

    return Scaffold(
      backgroundColor: const Color(0xFFB6CFD8),
      body: returnWidget(order),
    );
  }

  Widget returnWidget(Order order) {
    if (order.status == OrderStatus.CARTING) {
      return OrderPageReadyToGet(order: order);
    }
    if (order.status == OrderStatus.CARTING) {
      return OrderPageCarting(order: order);
    } else {
      return const OrderPageWithoutOrder();
    }
  }
}
