import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sportique/client_api/product_description_repository.dart';
import 'package:sportique/data/product_description.dart';
import 'package:sportique/widgets/navigation/bottom_navigation_bar.dart';

class ProductPage extends StatelessWidget {
  late int id;
  int size = 36;

  ProductPage({super.key, required this.id});

  late ProductDescription productDescription =
      ProductDescriptionRepository.instance.getProductDescription(id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => Navigator.pop(context, false),
        ),
        backgroundColor: const Color(0xFF2280BA),
        toolbarHeight: 50,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AspectRatio(
                      aspectRatio: 1.5,
                      child: Image.network(productDescription.image,
                          fit: BoxFit.cover)),
                  Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        productDescription.description,
                        style: const TextStyle(fontSize: 24),
                      )),
                  Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        productDescription.description,
                        style: const TextStyle(fontSize: 24),
                      )),
                  Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        productDescription.description,
                        style: const TextStyle(fontSize: 24),
                      ))
                ],
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text("${productDescription.price} руб/час",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'PoiretOne',
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        )),
                  ),
                  Center(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFD9D9D9),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return Container();
                                });
                          },
                          child: Row(
                            children: const [
                              Expanded(
                                child: Text("Выберите удобную дату",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'PoiretOne',
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    )),
                              ),
                              Icon(
                                Icons.calendar_month,
                                color: Colors.black,
                              )
                            ],
                          ))),
                  Center(
                      child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD9D9D9),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Container();
                          });
                    },
                    child: Text("Ваш выбранный размер - ${size}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'PoiretOne',
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )),
                  )),
                  Center(
                      child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                    onPressed: () {},
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
              ))
        ],
      ),
    );
  }
}
