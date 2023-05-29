import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_language_fonts/google_language_fonts.dart';
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
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await fetchData();
          },
          child: FutureBuilder<List<ProductDescription>>(
            future: data,
            builder: (BuildContext context,
                AsyncSnapshot<List<ProductDescription>> snapshot) {
              if (!snapshot.hasData) {
                return Container();
              } else if (snapshot.hasError) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return CustomScrollView(
                  slivers: [
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 8,
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: Center(
                        child: Text(
                          "Каталог",
                          style: TextStyle(
                              fontFamily: 'PoiretOne',
                              fontWeight: FontWeight.bold,
                              fontSize: 32),
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 8,
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
                            if (!snapshot.hasData) {
                              return Container();
                            } else {
                              if (snapshot.hasError) {
                                return const Center(
                                    child: CircularProgressIndicator());
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
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                      sliver: SliverGrid(
                        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 300,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: 0.5,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return ProductCard(product: snapshot.data![index]);
                          },
                          childCount: snapshot.data!.length,
                        ),
                      ),
                    )
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
