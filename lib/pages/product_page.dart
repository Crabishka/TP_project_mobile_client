import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sportique/client_api/product_description_repository.dart';
import 'package:sportique/data/product_description.dart';
import 'package:sportique/widgets/bottom_navigation_bar.dart';

class ProductPage extends StatelessWidget {
  late int id;

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

    );
  }
}
