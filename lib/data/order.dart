import 'package:sportique/data/product.dart';

class Order {
  final int id;
  final List<Product> products;
  final DateTime date;

  Order(this.id, this.products, this.date);
}
