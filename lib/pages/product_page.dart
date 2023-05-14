import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sportique/data/product_description.dart';


class ProductPage extends StatefulWidget {
  late int id;
  ProductDescription productDescription;

  ProductPage({super.key,  required this.productDescription});

  @override
  State<ProductPage> createState() => _ProductPageState(productDescription);
}

class _ProductPageState extends State<ProductPage> {
  int size = 36;
  ProductDescription productDescription;


  _ProductPageState(this.productDescription);

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
                      child: CachedNetworkImage(
                        imageUrl: productDescription.image,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      )),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(32, 12, 20, 0),
                      child: Text(
                        productDescription.description,
                        style: const TextStyle(fontSize: 24),
                      )),
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
