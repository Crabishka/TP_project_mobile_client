import 'package:flutter/material.dart';
import 'package:sportique/client_api/dio_client.dart';
import 'package:http/http.dart' as http;
import '../data/user.dart';

class UserRepository {
  UserRepository._();

  static final instance = UserRepository._();

  var mainUrl = "http://10.0.2.2:8080/users";

  Future<User> getUser(BuildContext context) async {
    try {
      final response = await DioClient().dio.get(mainUrl);
      if (response.statusCode == 200) {
        return User.fromJson(response.data);
      } else if (response.statusCode == 403) {
        final snackBar = SnackBar(
          content:
              const Text('Доступ запрещен. Предлагаем зарегистрироваться.'),
          action: SnackBarAction(
            label: 'Зарегистрироваться',
            onPressed: () {},
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        throw ('Access denied');
      } else {
        throw Exception('Unexpected status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch user');
    }
  }
}
