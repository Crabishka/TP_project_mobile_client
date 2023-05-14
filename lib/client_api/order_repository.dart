import 'package:sportique/client_api/product_description_repository.dart';

import '../data/order.dart';
import '../data/product.dart';

class OrderRepository {
  OrderRepository._();

  static final instance = OrderRepository._();


  List<Order> getOrderByUser(int id) {
    return []; // FIX ME
  }
}
