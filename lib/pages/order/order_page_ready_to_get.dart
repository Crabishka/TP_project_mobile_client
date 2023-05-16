import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../client_api/user_repository.dart';
import '../../data/order.dart';
import '../../widgets/product_little_card.dart';

class OrderPageReadyToGet extends StatelessWidget {
   OrderPageReadyToGet({super.key, required this.order});
  final GetIt getIt = GetIt.instance;
  final Order order;

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
                      child: Padding(
                    padding: const EdgeInsets.fromLTRB(50, 80, 50, 30),
                    child: QrImage(
                      padding: const EdgeInsets.all(30),
                      data:  getIt<UserRepository>().getUser().toString(),
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
                onPressed: () {
                  // FIXME
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
