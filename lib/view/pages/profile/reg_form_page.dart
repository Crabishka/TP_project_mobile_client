import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:provider/provider.dart';

import '../../../app.dart';
import '../../../firebase/analytics_service.dart';
import '../../../viewmodel/user_model.dart';

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
  GetIt getIt = GetIt.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB6CFD8),
      body: SingleChildScrollView(
        child: Form(
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
                          Provider.of<UserModel>(context, listen: false)
                              .regUser(_phoneNumber, _password, _name)
                              .then((value) {
                            getIt.get<AnalyticsService>().reg();
                            App.changeIndex(2);
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => App()));
                          }).catchError((e) {
                            if (e == 'user exist') {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(_userExistSnackBar());
                            }
                          });
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
      ),
    );
  }

  SnackBar _userExistSnackBar() {
    return SnackBar(
      duration: const Duration(seconds: 3),
      content: const Text(
          'Такой пользователь уже существует. Попробуйте войти!'),
      action: SnackBarAction(
        label: 'Войти!',
        onPressed: () {

          App.changeIndex(2);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => App()));
        },
      ),
    );
  }
}
