import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sportique/client_api/token_hepler.dart';
import '../data/order.dart';
import '../data/user.dart';

class UserRepository {
  UserRepository._();

  static final instance = UserRepository._();

  static String mainUrl = "http://10.0.2.2:8080";
  String urlForGetUser = "$mainUrl/users";
  String urlForGetActiveOrder = "$mainUrl/users/active";

  Future<User> getUser() async {
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
  }

  logout() {
    TokenHelper().setUserToken(userToken: '');
  }

  Future<Order> getActiveOrder() async {
    String? token = await TokenHelper().getUserToken();
    final response = await http.get(Uri.parse(urlForGetUser),
        headers: token != null && token.isNotEmpty
            ? {'Content-Type': 'application/json', 'Authorization': token}
            : {'Content-Type': 'application/json'});
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
}
