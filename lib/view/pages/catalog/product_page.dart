import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:get_it/get_it.dart';
import 'package:sportique/model/data/order.dart';

import '../../../app.dart';
import '../../../firebase/analytics_service.dart';
import '../../../model/client_api/product_description_repository.dart';
import '../../../model/data/product_description.dart';
import '../../../viewmodel/internal/app_data.dart';
import '../../../viewmodel/user_model.dart';

class ProductPage extends StatefulWidget {
  late int id;
  ProductDescription productDescription;

  ProductPage({super.key, required this.productDescription});

  @override
  State<ProductPage> createState() => _ProductPageState(productDescription);
}

class _ProductPageState extends State<ProductPage> {
  double? size;
  ProductDescription productDescription;
  final getIt = GetIt.instance;
  final _controller = ScrollController(keepScrollOffset: true);

  _ProductPageState(this.productDescription);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
            onPressed: () => Navigator.pop(context, false),
          ),
          backgroundColor: const Color(0xFFFFFFFF),
          toolbarHeight: 50,
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              controller: _controller,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: Text(
                      productDescription.title,
                      style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'PoiretOne'),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  AspectRatio(
                      aspectRatio: 1,
                      child: CachedNetworkImage(
                        imageUrl: productDescription.image,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      )),
                  const SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                    child: Text(
                        "${productDescription.price.truncate().toString()} руб/час",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'PoiretOne',
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        )),
                  ),
                  const Divider(
                    color: Color(0xFFb43e69),
                    thickness: 1,
                    indent: 16,
                    endIndent: 16,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: Text(
                      "Размеры",
                      style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'PoiretOne',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: _buildSizes(
                        Provider.of<AppData>(context).getDate() == null),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: Text(
                      "О товаре",
                      style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'PoiretOne',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: Text(
                      productDescription.description,
                      style: const TextStyle(
                          fontSize: 20, fontFamily: 'PoiretOne'),
                    ),
                  ),
                  const SizedBox(
                    height: 200,
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 16,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(
                              (MediaQuery.of(context).size.width - 48) / 2, 40),
                          backgroundColor: const Color(0xFF3EB489),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5))),
                      onPressed: () {
                        Provider.of<UserModel>(context, listen: false)
                            .getActiveOrder()
                            .then((value) {
                          if (value.status != OrderStatus.CARTING) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(_haveActiveOrderSnackBar());
                          } else if (value.products.isNotEmpty) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(_cantChangeData());
                          }
                        }).catchError((_) {
                          _selectDate(context);
                        });
                      },
                      child: Text(
                          Provider.of<AppData>(context).getDate() == null
                              ? "Выбрать дату"
                              : " ${DateFormat('dd-MMM').format(Provider.of<AppData>(context).getDate()!)}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'PoiretOne',
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          )),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(
                              (MediaQuery.of(context).size.width - 48) / 2, 40),
                          backgroundColor: const Color(0xFFb43e69),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5))),
                      onPressed: Provider.of<AppData>(context).getDate() ==
                                  null ||
                              size == null
                          ? () {
                              if (Provider.of<AppData>(context, listen: false)
                                      .getDate() ==
                                  null) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(_chooseDateError());
                              } else if (size == null) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(_chooseSizeError());
                              }
                            }
                          : () {
                              setState(() {
                                Provider.of<UserModel>(context, listen: false)
                                    .addProduct(
                                        productDescription.id,
                                        size!,
                                        Provider.of<AppData>(context,
                                                listen: false)
                                            .getDate()!)
                                    .then((_) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      _addProductSnackBar(
                                          productDescription.title, size!));
                                  Provider.of<AppData>(context, listen: false)
                                      .notify();
                                  getIt
                                      .get<AnalyticsService>()
                                      .addProduct(productDescription.id);
                                }).catchError((e) {
                                  if (e == 'access denied') {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(_errorSnackBar());
                                  } else if (e == 'have active') {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        _haveActiveOrderSnackBar());
                                  } else if (e == 'no free') {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        _getSnackBar(
                                            "К сожалению, товар закончился :(",
                                            "Грустно...",
                                            () {}));
                                  } else if (e == 'max count') {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(_maxCountSnackBar());
                                  } else {
                                    print(e);
                                  }
                                });
                              });
                            },
                      child: const Text("Заказать",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'PoiretOne',
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          )),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }

  SnackBar _getSnackBar(String content, String label, VoidCallback callback) {
    return SnackBar(
      duration: const Duration(seconds: 3),
      content: Text(content),
      action: SnackBarAction(
        label: label,
        onPressed: callback,
      ),
    );
  }

  SnackBar _chooseDateError() {
    return _getSnackBar("Выберите дату!", "Хорошо", () {});
  }

  SnackBar _chooseSizeError() {
    return _getSnackBar('Выберите размер!', "Хорошо", () {});
  }

  SnackBar _haveActiveOrderSnackBar() {
    return _getSnackBar('У вас уже есть активный заказ!', "Хорошо", () {});
  }

  SnackBar _cantChangeData() {
    return _getSnackBar(
        'Вы уже выбрали дату! Очистите корзину и продолжайте покупки',
        "Хорошо",
        () {});
  }

  SnackBar _maxCountSnackBar() {
    return _getSnackBar(
        'Вы не можете добавить больше 4 товаров :(', "Грустно...", () {});
  }

  SnackBar _errorSnackBar() {
    return _getSnackBar(
        'Войдите или зарегистрируйте перед тем, как добавить товар в корзину',
        "Войти", () {
      App.changeIndex(2);
      Navigator.push(context, MaterialPageRoute(builder: (context) => App()));
    });
  }

  SnackBar _addProductSnackBar(String title, double size) {
    return _getSnackBar('Вы добавили $title $size размера', "Круто!", () {});
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 7)),
    );

    if (pickedDate != null) {
      setState(() {
        Provider.of<AppData>(context, listen: false).setDate(pickedDate);
      });
    }
  }

  Widget _buildSizes(bool haveDate) {
    if (!haveDate) {
      return Container(
        child: FutureBuilder(
          future: getIt<ProductDescriptionRepository>().getSizeByDate(
              Provider.of<AppData>(context).getDate()!, productDescription.id),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox(
                height: 200,
                child: Center(child: CircularProgressIndicator()),
              );
            } else if (snapshot.hasError) {
              return Container();
            } else {
              return Container(
                child: GridView.builder(
                    itemCount: snapshot.data?.map.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 80,
                            childAspectRatio: 1,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8),
                    itemBuilder: (context, index) {
                      double? key = snapshot.data?.map.keys.elementAt(index);
                      return InkWell(
                        onTap: () {
                          setState(() {
                            size = snapshot.data?.map.keys.elementAt(index);
                          });
                        },
                        child: Card(
                          elevation: 1,
                          color: snapshot.data?.map[key] as bool
                              ? (snapshot.data?.map.keys.elementAt(index) ==
                                      size
                                  ? const Color(0xFF3EB489)
                                  : const Color(0xFFFFFFFF))
                              : const Color(0xFFA89DB9),
                          child: Center(
                            child: Text(
                              '${key}',
                              style: const TextStyle(
                                  fontFamily: 'PoiretOne',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ),
                        ),
                      );
                    }),
              );
            }
          },
        ),
      );
    }
    return const Text("Выберите дату для получения размеров на этот день",
        style: TextStyle(fontFamily: 'PoiretOne', fontSize: 20));
  }
}
