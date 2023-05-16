import 'package:flutter/material.dart';
import 'package:sportique/app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';
import 'package:sportique/client_api/product_description_repository.dart';
import 'package:sportique/client_api/user_repository.dart';
import 'package:sportique/internal/app_data.dart';
import 'package:sportique/pages/onboarding_screen.dart';

void main() {
  GetIt getIt = GetIt.instance;
  getIt.registerSingleton<AppData>(AppData());
  getIt.registerSingleton<UserRepository>(UserRepository());
  getIt.registerSingleton<ProductDescriptionRepository>(ProductDescriptionRepository());
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<void> _initIsFirst() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isFirst = prefs.getBool("isFirst") ?? true;
      print(_isFirst);
      prefs.setBool("isFirst", false);
    });
  }

  @override
  void initState() {
    super.initState();

    _initIsFirst();
  }

  bool _isFirst = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sportique',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: _isFirst ? OnBoardingScreen() : App());
  }
}
