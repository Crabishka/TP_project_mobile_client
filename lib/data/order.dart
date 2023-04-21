import 'package:sportique/data/product.dart';

import 'order_status.dart';

class Order {
  final int id;
  final List<Product> products;
  final DateTime date;
  final double sum;
  final OrderStatus status;

  Order(this.id, this.products, this.date, this.sum, this.status);
}
