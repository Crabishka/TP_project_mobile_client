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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productDescription.title,
                        style: const TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'PoiretOne'),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      AspectRatio(
                          aspectRatio: 1.5,
                          child: CachedNetworkImage(
                            imageUrl: productDescription.image,
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          )),
                      const SizedBox(
                        height: 8,
                      ),
                      Text("${productDescription.price} руб/час",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'PoiretOne',
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          )),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        productDescription.description,
                        style: const TextStyle(
                            fontSize: 28, fontFamily: 'PoiretOne'),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Center(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD9D9D9),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                    onPressed: () {
                      Provider.of<UserModel>(context, listen: false)
                          .getActiveOrder()
                          .then((value) {
                        if (value.status != OrderStatus.CARTING) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(_haveActiveOrderSnackBar());
                        } else if (value.products.length > 0) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(_cantChangeData());
                        }
                      }).catchError((_) {
                        _selectDate(context);
                      });
                    },
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Text(
                              getIt<AppData>().getDate() == null
                                  ? "Выберите удобную дату"
                                  : "Выбранная дата: "
                                      " ${DateFormat('dd-MMM').format(getIt<AppData>().getDate()!)}",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontFamily: 'PoiretOne',
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              )),
                        ),
                        const Expanded(
                          flex: 1,
                          child: Icon(
                            Icons.calendar_month,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ))),
            Center(
                child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15))),
              onPressed: getIt<AppData>().getDate() == null
                  ? null
                  : () {
                      showModalBottomSheet(
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(25))),
                          context: context,
                          builder: (BuildContext context) {
                            return Container(child: _showSelectedSizes());
                          });
                    },
              child: Text(
                  size == null
                      ? "Выберите размер"
                      : "Ваш выбранный размер - ${size}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'PoiretOne',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  )),
            )),
            Center(
                child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15))),
              onPressed: getIt<AppData>().getDate() == null || size == null
                  ? null
                  : () {
                      setState(() {
                        Provider.of<UserModel>(context, listen: false)
                            .addProduct(productDescription.id, size!,
                                getIt.get<AppData>().getDate()!)
                            .then((_) {
                          getIt
                              .get<AnalyticsService>()
                              .addProduct(productDescription.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                              _addProductSnackBar(
                                  productDescription.title, size!));
                        }).catchError((e) {
                          if (e == 'access denied') {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(_errorSnackBar());
                          } else if (e == 'have active') {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(_haveActiveOrderSnackBar());
                          } else if (e == 'max count') {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(_maxCountSnackBar());
                          } else {
                            print(e);
                          }
                        });
                      });
                    },
              child: const Text("Добавить",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'PoiretOne',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  )),
            )),
            const SizedBox(
              height: 20,
            )
          ],
        ));
  }

  SnackBar _haveActiveOrderSnackBar() {
    return SnackBar(
      duration: const Duration(seconds: 3),
      content: Text('У вас уже есть активный заказ!'),
      action: SnackBarAction(
        label: 'Хорошо',
        onPressed: () {},
      ),
    );
  }

  SnackBar _cantChangeData() {
    return SnackBar(
      duration: const Duration(seconds: 3),
      content:
          Text('Вы уже выбрали дату! Очистите корзину и продолжайте покупки'),
      action: SnackBarAction(
        label: 'Хорошо',
        onPressed: () {},
      ),
    );
  }

  SnackBar _maxCountSnackBar() {
    return SnackBar(
      duration: const Duration(seconds: 3),
      content: Text('Вы не можете добавить больше 4 товаров :('),
      action: SnackBarAction(
        label: 'Грустно...',
        onPressed: () {},
      ),
    );
  }

  SnackBar _errorSnackBar() {
    return SnackBar(
      duration: const Duration(seconds: 3),
      content: const Text(
          'Войдите или зарегистрируйте перед тем, как добавить товар в корзину'),
      action: SnackBarAction(
        label: 'Войти',
        onPressed: () {
          App.changeIndex(2);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => App()));
        },
      ),
    );
  }

  SnackBar _addProductSnackBar(String title, double size) {
    return SnackBar(
      duration: const Duration(seconds: 3),
      content: Text('Вы добавили $title $size размера'),
      action: SnackBarAction(
        label: 'Круто!',
        onPressed: () {},
      ),
    );
  }

  StatefulWidget _showSelectedSizes() {
    return FutureBuilder(
      future: getIt<ProductDescriptionRepository>()
          .getSizeByDate(getIt<AppData>().getDate()!, productDescription.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Container();
        } else {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: GridView.builder(
              itemCount: snapshot.data?.map.length,
              itemBuilder: (context, index) {
                double? key = snapshot.data?.map.keys.elementAt(index);
                return InkWell(
                  onTap: () {
                    setState(() {
                      size = snapshot.data?.map.keys.elementAt(index);
                      Navigator.of(context).pop();
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: snapshot.data?.map[key] as bool
                            ? (snapshot.data?.map.keys.elementAt(index) == size
                                ? const Color(0xFF6831C0)
                                : const Color(0xFF5FE367))
                            : const Color(0xFFA89DB9),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: Center(
                      child: Text(
                        '$key',
                        style: const TextStyle(
                            fontFamily: 'PoiretOne',
                            fontWeight: FontWeight.bold,
                            fontSize: 24),
                      ),
                    ),
                  ),
                );
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
            ),
          );
        }
      },
    );
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
        getIt<AppData>().setDate(pickedDate);
      });
    }
  }
}
