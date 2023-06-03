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

  bool showPassword = false;
  bool showRepeatPassword = false;
  String _phoneNumber = '';
  String _name = "";
  String _password = '';
  String _confirmPassword = '';
  GetIt getIt = GetIt.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: Image.asset(
                      "./assets/images/ball.png",
                      color: const Color(0xFF3EB489),
                      height: 80,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Center(
                    child: Text(
                      "Всего несколько секунд до покупок",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,

                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.phone_iphone_sharp),
                          labelStyle: TextStyle(

                              color: Color(0xFF3EB489),
                              fontSize: 20),
                          labelText: 'Телефон',
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          )),
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
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: TextFormField(
                      textCapitalization: TextCapitalization.sentences,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          labelStyle: TextStyle(

                              color: Color(0xFF3EB489),
                              fontSize: 20),
                          labelText: 'Имя',
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          )),
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
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: TextFormField(
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.password),
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  showPassword = !showPassword;
                                });
                              },
                              icon: Icon(Icons.remove_red_eye_outlined)),
                          labelStyle: const TextStyle(

                              color: const Color(0xFF3EB489),
                              fontSize: 20),
                          labelText: 'Пароль',
                          border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          )),
                      obscureText: !showPassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Пожалуйста, введите ваш пароль';
                        }

                        if (value.length < 4) {
                          return 'Пароль должен быть длинее 4 символов';
                        }

                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _password = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: TextFormField(
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.password),
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  showRepeatPassword = !showRepeatPassword;
                                });
                              },
                              icon: Icon(Icons.remove_red_eye_outlined)),
                          labelStyle: const TextStyle(

                              color: const Color(0xFF3EB489),
                              fontSize: 20),
                          labelText: 'Повторите Пароль',
                          border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          )),
                      obscureText: !showRepeatPassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Пожалуйста, повторите пароль';
                        }
                        if (value != _password) {
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
                  ),
                  const SizedBox(height: 16.0),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: const Color(0xFF3EB489),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5))),
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
      content:
          const Text('Такой пользователь уже существует. Попробуйте войти!'),
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
