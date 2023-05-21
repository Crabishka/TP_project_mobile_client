import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../model/client_api/product_description_repository.dart';
import '../../../model/data/order.dart';
import '../../../model/data/product_description.dart';
import '../../../viewmodel/user_model.dart';
import '../../widgets/product_card.dart';

class CatalogPage extends StatefulWidget {
  CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  GetIt getIt = GetIt.instance;
  late Future<List<ProductDescription>> data;

  @override
  void initState() {
    super.initState();
    data = getIt<ProductDescriptionRepository>().getAllProductDescription();
  }

  Future<void> fetchData() async {
    var productsList =
        await getIt<ProductDescriptionRepository>().getAllProductDescription();
    setState(() {
      data = Future.value(productsList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB6CFD8),
      body: RefreshIndicator(
        onRefresh: () async {
          await fetchData();
        },
        child: FutureBuilder<List<ProductDescription>>(
          future: data,
          builder: (BuildContext context,
              AsyncSnapshot<List<ProductDescription>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Text('Ошибка загрузки данных');
            } else {
              return CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 20,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                      child: FutureBuilder<Order>(
                        future:
                            Provider.of<UserModel>(context).getActiveOrder(),
                        builder: (BuildContext context,
                            AsyncSnapshot<Order> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else {
                            if (snapshot.hasError) {
                              return Container();
                            } else if (snapshot.data!.status ==
                                OrderStatus.WAITING_FOR_RECEIVING) {
                              return Column(
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Center(
                                    child: Text(
                                      "Ваш заказ на ${DateFormat('dd-MMM').format(snapshot.data!.date)}",
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontFamily: 'PoiretOne',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  QrImageView(
                                    padding: const EdgeInsets.all(30),
                                    data: snapshot.data!.id.toString(),
                                    backgroundColor: Colors.white,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  )
                                ],
                              );
                            } else {
                              return Container();
                            }
                          }
                        },
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                        childCount: snapshot.data!.length, (context, index) {
                      return Padding(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                          child: ProductCard(product: snapshot.data![index]));
                    }),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
