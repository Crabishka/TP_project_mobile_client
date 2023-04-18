import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../data/productDescription.dart';
import '../widgets/productCard.dart';

class CatalogPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CatalogPageState();
  }
}

class _CatalogPageState extends State<CatalogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: catalog.length,
      itemBuilder: (context, index) {
        return ProductCard(product: catalog[index]);
      },
    ));
  }
}

ProductDescription product1 = ProductDescription(1, "Card 1", "Very very good",
    200, "https://via.placeholder.com/600/24f355");
ProductDescription product2 = ProductDescription(2, "Card 2", "Very very bad",
    300, "https://via.placeholder.com/600/abcdf5");
ProductDescription product3 = ProductDescription(3, "Card 3", "Very very great",
    400, "https://via.placeholder.com/600/1234f5");
ProductDescription product4 = ProductDescription(4, "Card 4",
    "Very very awesome", 500, "https://via.placeholder.com/600/2ff3f5");
ProductDescription product5 = ProductDescription(5, "Card 5",
    "Very very handsome", 600, "https://via.placeholder.com/600/eadff5");
ProductDescription product6 = ProductDescription(6, "Card 6", "Very very awful",
    700, "https://via.placeholder.com/600/623ffa");
ProductDescription product7 = ProductDescription(7, "Card 7",
    "Very very terrible", 800, "https://via.placeholder.com/600/aaafdf");
var catalog = [
  product1,
  product2,
  product3,
  product4,
  product5,
  product6,
  product7
];
