import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:sportique/client_api/token_hepler.dart';
import 'package:sportique/internal/app_data.dart';
import '../app.dart';
import '../data/order.dart';
import '../data/user.dart';
import 'jwtDTO.dart';

class UserRepository {
  GetIt getIt = GetIt.instance;

  UserRepository() {
    mainUrl = getIt<AppData>().getUrl();
    urlForGetUser = "$mainUrl/users";
    urlForGetActiveOrder = "$mainUrl/users/active";
    urlForAddProduct = "$mainUrl/users/add";
    urlForDeleteProduct = "$mainUrl/users/delete";
    urlForRegUser = "$mainUrl/users/registration";
    urlForAuthUser = "$mainUrl/users/login";
  }

  String mainUrl = "";
  String urlForGetUser = "";
  String urlForGetActiveOrder = "";
  String urlForAddProduct = "";
  String urlForDeleteProduct = "";
  String urlForRegUser = "";
  String urlForAuthUser = "";

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

  Future<void> regUser(String phoneNumber, String password, String name) async {
    String? token = await TokenHelper().getUserToken();
    final response = await http.post(Uri.parse(urlForRegUser),
        headers: token != null && token.isNotEmpty
            ? {'Content-Type': 'application/json', 'Authorization': token}
            : {'Content-Type': 'application/json'},
        body: jsonEncode(
            {"phoneNumber": phoneNumber, "password": password, "name": name}));

    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedJson = jsonDecode(response.body);
      JwtDTO jwtDTO = JwtDTO.fromJson(decodedJson);
      TokenHelper().setUserToken(userToken: jwtDTO.accessToken);

      print(jwtDTO.accessToken);
    } else {

    }
  }

  Future<Order> getActiveOrder() async {
    String? token = await TokenHelper().getUserToken();

    final response = await http.get(Uri.parse(urlForGetActiveOrder),
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
    if (token == null || token.isEmpty) {
      throw ('access denied');
    }
    var baseUrl = Uri.parse('$urlForAddProduct/$productId');
    var queryParams = {"size": size.toString()};
    var url = baseUrl.replace(queryParameters: queryParams);
    var response = await http.post(url,
        headers: {'Content-Type': 'application/json', 'Authorization': token});
    if (response.statusCode == 200) {
    } else {
      print('Ошибка HTTP: ${response.statusCode}');
      throw ('${response.statusCode}');
    }
  }

  Future<void> deleteProduct(int productId, double size) async {
    String? token = await TokenHelper().getUserToken();
    var baseUrl = Uri.parse('$urlForDeleteProduct/$productId');
    var queryParams = {"size": size.toString()};
    var url = baseUrl.replace(queryParameters: queryParams);
    var response = await http.put(url,
        headers: {'Content-Type': 'application/json', 'Authorization': token!});
    if (response.statusCode == 200) {
    } else {
      print('Ошибка HTTP: ${response.statusCode}');
      throw ('${response.statusCode}');
    }
  }

  Future<void> authUser(String phoneNumber, String password) async {
    String? token = await TokenHelper().getUserToken();
    final response = await http.post(Uri.parse(urlForAuthUser),
        headers: token != null && token.isNotEmpty
            ? {'Content-Type': 'application/json', 'Authorization': token}
            : {'Content-Type': 'application/json'},
        body: jsonEncode({
          "username": phoneNumber,
          "password": password,
        }));
    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedJson = jsonDecode(response.body);
      JwtDTO jwtDTO = JwtDTO.fromJson(decodedJson);
      TokenHelper().setUserToken(userToken: jwtDTO.accessToken);
    } else {}
  }
}
