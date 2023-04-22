import 'package:flutter/material.dart';
import 'package:sportique/data/productDescription.dart';
import 'package:sportique/pages/catalog.dart';
import 'package:sportique/pages/product_page.dart';
import 'package:sportique/pages/profile.dart';

import 'data/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  User user = User("Amrit", "+79518747578");
  ProductDescription productDescription1 = ProductDescription(
      1,
      "Ракетки для тенниса",
      "Очень хорошие ракетки, прям классные, прям супер, вау" +
          "Очень хорошие ракетки, прям классные, прям супер, вау" +
          "Очень хорошие ракетки, прям классные, прям супер, вау" +
          "Очень хорошие ракетки, прям классные, прям супер, вау",
      300,
      "https://via.placeholder.com/600/eadff5");

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sportique',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProductPage(productDescription: productDescription1),
      routes: {
        '/catalog': (BuildContext context) => CatalogPage(),
        '/profile': (BuildContext context) => CatalogPage(),
      },
    );
  }
}
