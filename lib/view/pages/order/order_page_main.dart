import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';


import '../../../model/data/order.dart';
import '../../../viewmodel/internal/app_data.dart';
import '../../../viewmodel/user_model.dart';
import 'order_page_carting.dart';
import 'order_page_ready_to_get.dart';
import 'order_page_without_order.dart';

class OrderPage extends StatefulWidget {
  OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  GetIt getIt = GetIt.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB6CFD8),
      body: FutureBuilder<Order>(
        future:  Provider.of<UserModel>(context).getActiveOrder(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const OrderPageWithoutOrder();
          } else {
            if (snapshot.hasData){
              getIt.get<AppData>().setDate(snapshot.data!.date);
            }
            return returnWidget(snapshot.data);
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
