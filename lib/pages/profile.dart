import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sportique/widgets/order_card.dart';

import '../data/order.dart';
import '../data/product.dart';
import '../data/productDescription.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        toolbarHeight: 40,
      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          return OrderCard(order: orders[index]);
        },
      ),
    );
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
var list = [
  Product(1, product1, 34),
  Product(2, product2, 35),
  Product(3, product3, 36),
  Product(4, product4, 37),
];

var list1 = [
  Product(5, product1, 34),
  Product(6, product4, 31),
  Product(7, product6, 46)
];

var list2 = [
  Product(5, product1, 34),
  Product(6, product4, 31),
];

var list3 = [
  Product(7, product7, 45),
];

Order order = Order(1, list, DateTime.now(), 100);
Order order1 = Order(2, list1, DateTime.now(), 1000);
Order order2 = Order(3, list2, DateTime.now(), 9999);
Order order3 = Order(4, list3, DateTime.now(), 7896);

var orders = [order, order1, order2, order3];
