import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sportique/client_api/jwtDTO.dart';
import 'package:sportique/client_api/token_hepler.dart';
import 'dart:convert';

import 'package:sportique/pages/profile/reg_form_page.dart';

import '../../app.dart';


class AuthFormPage extends StatefulWidget {
  const AuthFormPage({super.key});

  @override
  State<AuthFormPage> createState() => _AuthFormPageState();
}

class _AuthFormPageState extends State<AuthFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _phoneNumber = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB6CFD8),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset("./assets/images/img_6.png"),
            Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(32, 40, 32, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 0, 8),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                  labelStyle: TextStyle(
                                      fontFamily: 'PoiretOne',
                                      color: Color(0xFF342789),
                                      fontSize: 24),
                                  labelText: 'Teлефон',
                                  border: InputBorder.none),
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Пожалуйста, введите ваш телефон';
                                }
                                String pattern = r'^\+?\d{10,11}$';
                                RegExp regex = RegExp(pattern);
                                if (!regex.hasMatch(value)) {
                                  return 'Введите корректный телефонный номер';
                                }

                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  _phoneNumber = value;
                                });
                              },
                            ),
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 0, 8),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                  errorStyle: TextStyle(),
                                  labelStyle: TextStyle(
                                      fontFamily: 'PoiretOne',
                                      color: Color(0xFF342789),
                                      fontSize: 24),
                                  labelText: 'Пароль',
                                  border: InputBorder.none),
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Пожалуйста, введите ваш пароль';
                                }

                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  _password = value;
                                });
                              },
                            ),
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Column(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15))),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _submitForm();
                                }
                              },
                              child: const Text(
                                'Войти',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontFamily: 'PoiretOne',
                                ),
                              ),
                            ),
                            Text("Нет аккаута?"),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15))),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RegFormPage()));
                              },
                              child: const Text(
                                'Зарегистрироваться',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontFamily: 'PoiretOne',
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  var mainUrl = 'http://10.0.2.2:8080/users/login';

  Future<void> _submitForm() async {
    String? token = await TokenHelper().getUserToken();
    final response = await http.post(Uri.parse(mainUrl),
        headers: token != null && token.isNotEmpty
            ? {'Content-Type': 'application/json', 'Authorization': token}
            : {'Content-Type': 'application/json'},
        body: jsonEncode({
          "username": _phoneNumber,
          "password": _password,
        }));
    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedJson = jsonDecode(response.body);
      JwtDTO jwtDTO = JwtDTO.fromJson(decodedJson);
      TokenHelper().setUserToken(userToken: jwtDTO.accessToken);
      App.changeIndex(2);
      Navigator.push(context, MaterialPageRoute(builder: (context) => App()));
      print(jwtDTO.accessToken);
    } else {
      // Обработка ошибки
    }
  }
}
