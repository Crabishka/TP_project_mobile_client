import 'dart:convert';

import '../data/product_description.dart';
import 'package:http/http.dart' as http;

class ProductDescriptionRepository {
  ProductDescriptionRepository._();

  static final instance = ProductDescriptionRepository._();

  // ProductDescription getProductDescription(int id) {
  //   return catalog[id];
  // }

  Future<List<ProductDescription>> getAllProductDescription() {
    return getAllProductDescriptionByRequest();
  }

  var mainUrl = "http://188.225.35.245:8080/products_property";

  Future<List<ProductDescription>> getAllProductDescriptionByRequest() async {
    var url = Uri.parse(mainUrl);
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);

      List<ProductDescription> productList = [];

      for (var item in jsonData) {
        var product = ProductDescription.fromJson(item);
        productList.add(product);
      }

      return productList;
    } else {
      print('Ошибка HTTP: ${response.statusCode}');
      return [];
    }
  }
}
