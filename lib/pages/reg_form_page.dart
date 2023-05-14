import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../app.dart';
import '../client_api/dio_client.dart';
import '../client_api/jwtDTO.dart';
import '../client_api/token_hepler.dart';

class RegFormPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegFormPageState();
  }
}

class _RegFormPageState extends State<RegFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _phoneNumber = '';
  String _name = "";
  String _password = '';
  String _confirmPassword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB6CFD8),
      body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(32, 60, 32, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 0, 8),
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
                Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 0, 8),
                      child: TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                        decoration: const InputDecoration(
                            errorStyle: TextStyle(),
                            labelStyle: TextStyle(
                                fontFamily: 'PoiretOne',
                                color: Color(0xFF342789),
                                fontSize: 24),
                            labelText: 'Имя',
                            border: InputBorder.none),
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Пожалуйста, введите ваше имя';
                          }

                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            _name = value;
                          });
                        },
                      ),
                    )),
                const SizedBox(
                  height: 20,
                ),
                Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 0, 8),
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
                Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 0, 8),
                      child: TextFormField(
                        decoration: const InputDecoration(
                            errorStyle: TextStyle(),
                            labelStyle: TextStyle(
                                fontFamily: 'PoiretOne',
                                color: Color(0xFF342789),
                                fontSize: 24),
                            labelText: 'Повторите пароль',
                            border: InputBorder.none),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Пожалуйста, повторите пароль';
                          }
                          if (value != _password) {
                            print(value);
                            print(_password);
                            return 'Пароли не совпадают';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            _confirmPassword = value;
                          });
                        },
                      ),
                    )),
                SizedBox(height: 16.0),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        try {
                          _submitForm();
                          App.changeIndex(2);
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => App()));
                        } catch (e) {
                          print(e.toString());
                        }
                      }
                    },
                    child: const Text(
                      'Зарегистрироваться',
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'PoiretOne',
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }

  Future<void> _submitForm() async {
    final response = await DioClient().dio.post(
        'http://10.0.2.2:8080/users/registration',
        data: jsonEncode({
          "phoneNumber": _phoneNumber,
          "password": _password,
          "name": _name
        }));

    if (response.statusCode == 200) {
      print(response.data);
      JwtDTO jwtDTO = JwtDTO.fromJson(response.data);
      TokenHelper().setUserToken(userToken: jwtDTO.accessToken);
      print(jwtDTO.accessToken);
    } else {}
  }
}
