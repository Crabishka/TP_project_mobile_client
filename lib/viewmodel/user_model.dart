import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

import '../model/client_api/user_repository.dart';
import '../model/data/order.dart';
import '../model/data/product.dart';
import '../model/data/user.dart';
import 'internal/app_data.dart';

class UserModel extends ChangeNotifier {
  GetIt getIt = GetIt.instance;

  late User _user;

  Future<void> addProduct(int productId, double size, DateTime dateTime) async {
    try {
      Order order = await getActiveOrder();
      if (order.status == OrderStatus.CARTING) {
        await getIt.get<UserRepository>().addProduct(productId, size, dateTime);
        notifyListeners();
      }
    } catch (e){
      await getIt.get<UserRepository>().addProduct(productId, size, dateTime);
      notifyListeners();
    }

  }

  Future<void> notify() async{
    notifyListeners();
  }

  Future<void> removeProduct(int productId, double size) async {
    await getIt.get<UserRepository>().deleteProduct(productId, size);
    notifyListeners();
  }

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  Future<void> cancelOrder() async {
    await getIt.get<UserRepository>().cancelActiveOrder();
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

  Future<void> authUser(String phoneNumber, String password) async {
    await getIt.get<UserRepository>().authUser(phoneNumber, password);
    notifyListeners();
  }

  Future<void> regUser(String phoneNumber, String password, String name) async {
    await getIt.get<UserRepository>().regUser(phoneNumber, password, name);
    notifyListeners();
  }

  Future<void> makeOrder() async {
    await getIt
        .get<UserRepository>()
        .makeOrder(getIt.get<AppData>().getDate()!);
    notifyListeners();
  }

  Future<Product> changeProduct(
      int productId, double size, double newSize) async {
    Product product = await getIt
        .get<UserRepository>()
        .changeProductSize(productId, size, newSize);
    notifyListeners();
    return product;
  }
}
