import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:sportique/viewmodel/token_hepler.dart';
import '../../viewmodel/internal/app_data.dart';
import '../data/order.dart';
import '../data/product.dart';
import '../data/user.dart';
import 'dto/jwtDTO.dart';

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
    urlForChangeProduct = "$mainUrl/users/change";
    urlForMakeOrder = "$mainUrl/users/active";
    urlForCancelOrder = "$mainUrl/users/cancel";
  }

  String mainUrl = "";
  String urlForGetUser = "";
  String urlForGetActiveOrder = "";
  String urlForAddProduct = "";
  String urlForDeleteProduct = "";
  String urlForRegUser = "";
  String urlForAuthUser = "";
  String urlForChangeProduct = "";
  String urlForMakeOrder = "";
  String urlForCancelOrder = "";

  Future<User> getUser() async {
    try {
      String? token = await TokenHelper().getUserToken();
      if (token == null ||
          token.isEmpty ||
          getIt.get<TokenHelper>().isTokenExpired(token)) {
        throw ('access denied');
      }
      final response = await http.get(Uri.parse(urlForGetUser), headers: {
        'Content-Type': 'application/json',
        'Authorization': token
      });
      if (response.statusCode == 200) {
        final Map<String, dynamic> decodedJson =
            jsonDecode(utf8.decode(response.bodyBytes));
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
    final response = await http.post(Uri.parse(urlForRegUser),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(
            {"phoneNumber": phoneNumber, "password": password, "name": name}));

    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedJson = jsonDecode(response.body);
      JwtDTO jwtDTO = JwtDTO.fromJson(decodedJson);
      TokenHelper().setUserToken(userToken: jwtDTO.accessToken);
    } else {
      throw ('user exist');
    }
  }

  Future<Order> getActiveOrder() async {
    String? token = await TokenHelper().getUserToken();
    if (token == null ||
        token.isEmpty ||
        getIt.get<TokenHelper>().isTokenExpired(token)) {
      throw ('access denied');
    }
    final response = await http.get(Uri.parse(urlForGetActiveOrder),
        headers: {'Content-Type': 'application/json', 'Authorization': token!});
    if (response.statusCode == 200) {
      try {
        final Map<String, dynamic> decodedJson =
            jsonDecode(utf8.decode(response.bodyBytes));
        Order order = Order.fromJson(decodedJson);
        return order;
      } catch (e) {
        throw ('Cant get active order');
      }
    } else if (response.statusCode == 403) {
      throw ('Access denied');
    } else {
      throw Exception('Unexpected status code: ${response.statusCode}');
    }
  }

  Future<void> addProduct(int productId, double size, DateTime date) async {
    try {
      Order order = await getActiveOrder();
      if (order.products.length == 4)  throw ('max count');
      if (order.status != OrderStatus.CARTING) throw ('have active');
    } catch (e) {
      if (e != 'Cant get active order') {
        rethrow;
      }
    }

    String? token = await TokenHelper().getUserToken();
    if (token == null ||
        token.isEmpty ||
        getIt.get<TokenHelper>().isTokenExpired(token)) {
      throw ('access denied');
    }

    var baseUrl = Uri.parse('$urlForAddProduct/$productId');
    var formatter = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
    var zonedDateTime = formatter.format(date);
    var queryParams = {"size": size.toString(), "date": zonedDateTime};
    var url = baseUrl.replace(queryParameters: queryParams);
    var response = await http.post(url,
        headers: {'Content-Type': 'application/json', 'Authorization': token});
    if (response.statusCode == 200) {
    } else {
      print('Ошибка HTTP: ${response.statusCode}');
      throw ('access denied');
    }
  }

  Future<void> deleteProduct(int productId, double size) async {
    String? token = await TokenHelper().getUserToken();
    if (token == null ||
        token.isEmpty ||
        getIt.get<TokenHelper>().isTokenExpired(token)) {
      throw ('access denied');
    }
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
    final response = await http.post(Uri.parse(urlForAuthUser),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "username": phoneNumber,
          "password": password,
        }));
    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedJson = jsonDecode(response.body);
      JwtDTO jwtDTO = JwtDTO.fromJson(decodedJson);
      TokenHelper().setUserToken(userToken: jwtDTO.accessToken);
    } else {
      throw ('wrong auth');
    }
  }

  Future<Product> changeProductSize(
      int productId, double size, double newSize) async {
    String? token = await TokenHelper().getUserToken();
    if (token == null ||
        token.isEmpty ||
        getIt.get<TokenHelper>().isTokenExpired(token)) {
      throw ('access denied');
    }
    var baseUrl = Uri.parse('$urlForChangeProduct/$productId');
    var queryParams = {"size": size.toString(), "new_size": newSize.toString()};
    var url = baseUrl.replace(queryParameters: queryParams);
    var response = await http.put(url,
        headers: {'Content-Type': 'application/json', 'Authorization': token});
    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedJson = jsonDecode(response.body);
      return Product.fromJson(decodedJson);
    } else {
      print('Ошибка HTTP: ${response.statusCode}');
      throw ('${response.statusCode}');
    }
  }

  Future<void> makeOrder(DateTime date) async {
    String? token = await TokenHelper().getUserToken();
    if (token == null ||
        token.isEmpty ||
        getIt.get<TokenHelper>().isTokenExpired(token)) {
      throw ('access denied');
    }
    var baseUrl = Uri.parse(urlForMakeOrder);
    var formatter = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
    var zonedDateTime = formatter.format(date);
    var queryParams = {"date": zonedDateTime};
    var url = baseUrl.replace(queryParameters: queryParams);
    var response = await http.post(url,
        headers: {'Content-Type': 'application/json', 'Authorization': token});
    if (response.statusCode == 200) {
    } else {
      print('Ошибка HTTP: ${response.statusCode}');
    }
  }

  Future<void> cancelActiveOrder() async {
    String? token = await TokenHelper().getUserToken();
    if (token == null ||
        token.isEmpty ||
        getIt.get<TokenHelper>().isTokenExpired(token)) {
      throw ('access denied');
    }
    var url = Uri.parse(urlForCancelOrder);
    var response = await http.put(url,
        headers: {'Content-Type': 'application/json', 'Authorization': token});
    if (response.statusCode == 200) {
    } else {
      print('Ошибка HTTP: ${response.statusCode}');
      throw ('${response.statusCode}');
    }
  }
}
