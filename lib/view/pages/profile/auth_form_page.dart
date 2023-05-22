import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sportique/view/pages/profile/reg_form_page.dart';

import '../../../app.dart';
import '../../../firebase/analytics_service.dart';
import '../../../viewmodel/user_model.dart';

class AuthFormPage extends StatefulWidget {
  const AuthFormPage({super.key});

  @override
  State<AuthFormPage> createState() => _AuthFormPageState();
}

class _AuthFormPageState extends State<AuthFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _phoneNumber = '';
  String _password = '';
  GetIt getIt = GetIt.instance;

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
                                  Provider.of<UserModel>(context, listen: false)
                                      .authUser(_phoneNumber, _password)
                                      .then((value) {
                                    getIt.get<AnalyticsService>()                                        .auth();
                                    App.changeIndex(2);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => App()));
                                  }).catchError((_) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(_errorAuthBar());
                                  });
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

  SnackBar _errorAuthBar() {
    return SnackBar(
      duration: const Duration(seconds: 3),
      content: const Text(
          'Такой пользователь не найден или пароль не верен. Проверьте еще раз.'),
      action: SnackBarAction(
        label: 'Хорошо :(',
        onPressed: () {

        },
      ),
    );
  }
}
