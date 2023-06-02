import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sportique/view/widgets/progress_order_bar.dart';


import '../../../firebase/analytics_service.dart';
import '../../../model/data/order.dart';
import '../../../viewmodel/custom/ColorCustom.dart';
import '../../../viewmodel/user_model.dart';
import '../../widgets/order_product_cart.dart';

class OrderPageCarting extends StatefulWidget {
  final Order order;

  OrderPageCarting({super.key, required this.order});

  @override
  State<OrderPageCarting> createState() => _OrderPageCartingState();
}

class _OrderPageCartingState extends State<OrderPageCarting> {
  GetIt getIt = GetIt.instance;
  bool shouldRefresh = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(children: [
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
                      fontFamily: 'PoiretOne',
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
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Text(
                      "Ваш заказ на ${DateFormat('dd-MMM').format(widget.order.date)}",
                      style: const TextStyle(
                          fontFamily: 'PoiretOne',
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    Flexible(child: Container()),
                    InkWell(
                      onTap: () {
                        Provider.of<UserModel>(context, listen: false)
                            .clearOrder();
                      },
                      child: const Text(
                        "Очистить",
                        style: TextStyle(fontFamily: 'PoiretOne', fontSize: 20),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                  childCount: widget.order.products.length, (context, index) {
                return Padding(
                    padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
                    child: OrderProductCard(
                      product: widget.order.products[index],
                    ));
              }),
            ),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 0, 0, 8),
                child: Text(
                  'Сумма заказа',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'PoiretOne',
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Row(
                  children: [
                    const Text(
                      "Количество товаров ",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'PoiretOne',
                        fontSize: 20,
                      ),
                    ),
                    Flexible(child: Container()),
                    Text(
                      "${widget.order.products.length} шт.",
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'PoiretOne',
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 4,
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Row(
                  children: [
                    const Text(
                      "Общая стоимость ",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'PoiretOne',
                        fontSize: 20,
                      ),
                    ),
                    Flexible(child: Container()),
                    Text(
                      "${widget.order.sum.truncate().toString()} руб/час",
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'PoiretOne',
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
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
          child: Row(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3EB489),
                    fixedSize: Size(MediaQuery.of(context).size.width - 32, 40),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4))),
                onPressed: () {
                  getIt.get<AnalyticsService>().doOrder();
                  Provider.of<UserModel>(context, listen: false).makeOrder();
                },
                child: const Text("Заказать",
                    style: TextStyle(

                      fontFamily: 'PoiretOne',
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    )),
              ),
            ],
          ),
        ),
      ]),
    ));
  }


}
