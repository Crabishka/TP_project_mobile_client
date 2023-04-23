import 'package:sportique/client_api/product_description_repository.dart';

import '../data/order.dart';
import '../data/order_status.dart';
import '../data/product.dart';

class OrderRepository {
  OrderRepository._();

  static final instance = OrderRepository._();

  Order findById(int index) {
    return orders[index - 1];
  }

  var list = [
    Product(
        1, ProductDescriptionRepository.instance.getProductDescription(1), 34),
    Product(
        2, ProductDescriptionRepository.instance.getProductDescription(2), 35),
    Product(
        3, ProductDescriptionRepository.instance.getProductDescription(3), 36),
    Product(
        4, ProductDescriptionRepository.instance.getProductDescription(4), 37),
  ];

  var list1 = [
    Product(
        5, ProductDescriptionRepository.instance.getProductDescription(1), 34),
    Product(
        6, ProductDescriptionRepository.instance.getProductDescription(4), 31),
    Product(
        7, ProductDescriptionRepository.instance.getProductDescription(6), 46)
  ];

  var list2 = [
    Product(
        5, ProductDescriptionRepository.instance.getProductDescription(1), 34),
    Product(
        6, ProductDescriptionRepository.instance.getProductDescription(4), 31),
  ];

  var list3 = [
    Product(
        7, ProductDescriptionRepository.instance.getProductDescription(7), 45),
  ];

  late Order order =
      Order(1, list, DateTime.now(), 100, OrderStatus.WAITING_FOR_RECEIVING);
  late Order order1 =
      Order(2, list1, DateTime.now(), 1000, OrderStatus.FINISHED);
  late Order order2 =
      Order(3, list2, DateTime.now(), 9999, OrderStatus.CANCELED_BY_USER);
  late Order order3 =
      Order(4, list3, DateTime.now(), 7896, OrderStatus.FINISHED);

  late var orders = [order, order1, order2, order3];
}
