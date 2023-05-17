import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:sportique/client_api/user_repository.dart';

import '../data/order.dart';
import '../data/user.dart';

class UserModel extends ChangeNotifier {
  GetIt getIt = GetIt.instance;

  late User _user;

  Future<void> addProduct(int productId, double size) async {
    await getIt.get<UserRepository>().addProduct(productId, size);
    notifyListeners();
  }

  void removeProduct(int productId, double size) {
    getIt.get<UserRepository>().deleteProduct(productId, size);
    notifyListeners();
  }

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  Future<Order> getActiveOrder() async {
    Future<Order> order = getIt.get<UserRepository>().getActiveOrder();
    return order;
  }

  Future<User> getUser() async {
    _user = await getIt.get<UserRepository>().getUser();
    return _user;
  }

  Future<void> authUser(String phoneNumber, String password)async {
    await getIt.get<UserRepository>().authUser(phoneNumber, password);
  }

  Future<void> regUser(String phoneNumber, String password, String name)async {
    await getIt.get<UserRepository>().regUser(phoneNumber, password, name);
  }

}
