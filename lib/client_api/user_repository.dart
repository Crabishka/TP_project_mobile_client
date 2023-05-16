import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:sportique/client_api/token_hepler.dart';
import 'package:sportique/internal/app_data.dart';
import '../data/order.dart';
import '../data/user.dart';

class UserRepository {
  GetIt getIt = GetIt.instance;

  UserRepository() {
    mainUrl = getIt<AppData>().getUrl();
    urlForGetUser = "$mainUrl/users";
    urlForGetActiveOrder = "$mainUrl/users/active";
    urlForAddProduct = "$mainUrl/users/add";
  }

  String mainUrl = "";
  String urlForGetUser = "";
  String urlForGetActiveOrder = "";
  String urlForAddProduct = "";

  Future<User> getUser() async {
    try {
      String? token = await TokenHelper().getUserToken();
      final response = await http.get(Uri.parse(urlForGetUser),
          headers: token != null && token.isNotEmpty
              ? {'Content-Type': 'application/json', 'Authorization': token}
              : {'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        final Map<String, dynamic> decodedJson = jsonDecode(response.body);
        User user = User.fromJson(decodedJson);
        return user;
      } else if (response.statusCode == 403) {
        throw ('Access denied');
      } else {
        throw Exception('Unexpected status code: ${response.statusCode}');
      }
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  logout() {
    TokenHelper().setUserToken(userToken: '');
  }

  Future<Order> getActiveOrder() async {
    String? token = await TokenHelper().getUserToken();

    final response = await http.get(Uri.parse(urlForGetUser),
        headers: {'Content-Type': 'application/json', 'Authorization': token!});
    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedJson = jsonDecode(response.body);
      Order order = Order.fromJson(decodedJson);
      return order;
    } else if (response.statusCode == 403) {
      throw ('Access denied');
    } else {
      throw Exception('Unexpected status code: ${response.statusCode}');
    }
  }

  Future<void> addProduct(int productId, double size) async {
    String? token = await TokenHelper().getUserToken();
    var baseUrl = Uri.parse('$urlForAddProduct/$productId');
    var queryParams = {"size": size.toString()};
    var url = baseUrl.replace(queryParameters: queryParams);
    var response = await http.post(url,
        headers: {'Content-Type': 'application/json', 'Authorization': token!});
    if (response.statusCode == 200) {
    } else {
      print('Ошибка HTTP: ${response.statusCode}');
      throw ('${response.statusCode}');
    }
  }
}
