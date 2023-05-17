import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../model/data/order.dart';
import '../../../viewmodel/user_model.dart';
import '../../widgets/product_little_card.dart';

class OrderPageReadyToGet extends StatefulWidget {
  OrderPageReadyToGet({super.key, required this.order});

  final Order order;

  @override
  State<OrderPageReadyToGet> createState() => _OrderPageReadyToGetState();
}

class _OrderPageReadyToGetState extends State<OrderPageReadyToGet> {
  final GetIt getIt = GetIt.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFB6CFD8),
        body: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 40,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Text(
                      "Ваш заказ на ${DateFormat('dd-MMM').format(widget.order.date)}",
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
                      data: widget.order.id.toString(),
                      backgroundColor: Colors.white,
                    ),
                  )),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                        childCount: widget.order.products.length,
                        (context, index) {
                      return Padding(
                          padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                          child: ProductLittleCard(
                            product: widget.order.products[index],
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
                onPressed: () {
                  Provider.of<UserModel>(context, listen: false).cancelOrder();
                },
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
