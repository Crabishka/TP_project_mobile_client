import 'package:sportique/client_api/order_repository.dart';

import '../data/user.dart';

class UserRepository {
  UserRepository._();

  static final instance = UserRepository._();

  User user1 = User(1, "Amrit", "+79518747578", [
    OrderRepository.instance.findById(1),
    OrderRepository.instance.findById(2)
  ]);
  User user2 =
      User(2, "Amala", "+79518747578", [OrderRepository.instance.findById(4)]);
  User user3 =
      User(3, "Amen", "+79518747578", [OrderRepository.instance.findById(3)]);
  late var users = [user1, user2, user3];

  User getUser() {
    return users[0];
  }
}
