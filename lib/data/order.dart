import 'package:sportique/data/product.dart';

class Order {
  final int id;
  final List<Product> products;
  final DateTime date;
  final double sum;
  final OrderStatus status;

  Order(
      {required this.id,
      required this.products,
      required this.date,
      required this.sum,
      required this.status});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
        id: json['id'],
        products: (json['products'] as List<dynamic>)
            .map((productJson) => Product.fromJson(productJson))
            .toList(),
        date: DateTime.parse(json['orderTime']),
        sum: json['totalCost'].toDouble(),
        status: OrderStatus.values.firstWhere(
            (element) => element.toString().split('.').last == json['orderStatus']));
  }
}

enum OrderStatus {
  ACTIVE,
  FITTING,
  WAITING_FOR_RECEIVING,
  FINISHED,
  CANCELED_BY_USER,
  CANCELED_BY_EMPLOYEE,
  CARTING
}
