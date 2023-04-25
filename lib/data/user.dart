import 'order.dart';

class User {
  final int id;
  final String name;
  final String phoneNumber;
  final List<Order> orders;

  User(this.id, this.name, this.phoneNumber, this.orders);

  Order getUserActiveOrder() {
    return orders[0];
  }
}
