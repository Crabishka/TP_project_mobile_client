import 'package:sportique/data/product.dart';

class Order {
  final int id;
  final List<Product> products;
  final DateTime date;
  final double sum;

  Order(this.id, this.products, this.date, this.sum);
}
