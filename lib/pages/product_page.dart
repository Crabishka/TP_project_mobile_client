import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sportique/data/productDescription.dart';
import 'package:sportique/widgets/bottom_navigation_bar.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key, required this.productDescription});

  final ProductDescription productDescription;

  @override
  State<StatefulWidget> createState() {
    return _ProductPageState(productDescription);
  }
}

class _ProductPageState extends State<ProductPage> {
  final ProductDescription productDescription;

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
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
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

        ],
      ),
      bottomNavigationBar: const MyNavigationBar(),
    );
  }
}
