import 'order.dart';

class User {
  final int id;
  final String name;
  final String phoneNumber;
  final List<Order> orders;

  User(
      {required this.id,
      required this.name,
      required this.phoneNumber,
      required this.orders});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      orders: (json['orders'] as List<dynamic>).map((orderJson) => Order.fromJson(orderJson)).toList(),
    );
  }

  Order getUserActiveOrder() {
    return orders[0];
  }
}
