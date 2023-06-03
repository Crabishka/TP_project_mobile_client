import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../firebase/analytics_service.dart';
import '../../../model/data/order.dart';
import '../../../viewmodel/custom/ColorCustom.dart';
import '../../../viewmodel/user_model.dart';
import '../../widgets/date_show.dart';
import '../../widgets/product_little_card.dart';
import '../../widgets/progress_order_bar.dart';

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
        body: SafeArea(
      child: Stack(
        children: [
          CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 8,
                ),
              ),
              SliverToBoxAdapter(
                child: Center(
                  child: Text(
                    "Корзина",
                    style: TextStyle(
                        color: ColorCustom().titleColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 32),
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 16,
                ),
              ),
              SliverToBoxAdapter(
                  child: ProgressOrderBar(
                order: widget.order,
              )),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 16,
                ),
              ),
              SliverToBoxAdapter(
                  child: DateShow(dateTime: widget.order.date, height: 24)),
              SliverToBoxAdapter(
                child: Text(
                  widget.order.status.getStatusText(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ),
              SliverToBoxAdapter(
                  child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: Center(
                  child: QrImageView(
                    padding: const EdgeInsets.all(30),
                    size: 300,
                    data: widget.order.id.toString(),
                    backgroundColor: Colors.white,
                  ),
                ),
              )),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 16,
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                    childCount: widget.order.products.length, (context, index) {
                  return Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: ProductLittleCard(
                        product: widget.order.products[index],
                      ));
                }),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 60,
                ),
              )
            ],
          ),
          Positioned(
            bottom: 8,
            right: 16,
            left: 16,
            child: Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFb43e69),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4))),
                onPressed: () {
                  getIt.get<AnalyticsService>().cancelOrder();
                  Provider.of<UserModel>(context, listen: false).cancelOrder();
                },
                child: const Text("Отменить",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    )),
              ),
            ),
          ),
        ],
      ),
    ));
  }

  Row _buildStatus(Order order) {
    Color cartingColor = (order.status.index >= OrderStatus.CARTING.index)
        ? const Color(0xFFb43e69)
        : const Color(0xFF3EB489);
    Color waitingColor =
        (order.status.index >= OrderStatus.WAITING_FOR_RECEIVING.index)
            ? const Color(0xFFb43e69)
            : const Color(0xFF3EB489);
    Color fittingColor = (order.status.index >= OrderStatus.FITTING.index)
        ? const Color(0xFFb43e69)
        : const Color(0xFF3EB489);
    Color activeColor = (order.status.index >= OrderStatus.ACTIVE.index)
        ? const Color(0xFFb43e69)
        : const Color(0xFF3EB489);
    Color paymentColor =
        (order.status.index >= OrderStatus.WAITING_FOR_PAYMENT.index)
            ? const Color(0xFFb43e69)
            : const Color(0xFF3EB489);
    Color finishColor = (order.status.index >= OrderStatus.FINISHED.index)
        ? const Color(0xFFb43e69)
        : const Color(0xFF3EB489);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        circle(cartingColor,
            const Icon(Icons.shopping_basket_outlined, color: Colors.white)),
        Container(
          width: 20,
          height: 10,
          color: waitingColor,
        ),
        circle(
            waitingColor, const Icon(Icons.access_time, color: Colors.white)),
        Container(
          width: 20,
          height: 10,
          color: fittingColor,
        ),
        circle(fittingColor,
            const Icon(Icons.accessibility_new_outlined, color: Colors.white)),
        Container(
          width: 20,
          height: 10,
          color: activeColor,
        ),
        circle(
            activeColor, const Icon(Icons.directions_run, color: Colors.white)),
        Container(
          width: 20,
          height: 10,
          color: paymentColor,
        ),
        circle(paymentColor,
            const Icon(Icons.monetization_on_outlined, color: Colors.white)),
        Container(
          width: 20,
          height: 10,
          color: finishColor,
        ),
        circle(finishColor, const Icon(Icons.check, color: Colors.white))
      ],
    );
  }

  Widget circle(Color color, Icon icon) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: icon,
    );
  }
}
