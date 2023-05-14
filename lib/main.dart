import 'package:flutter/material.dart';
import 'package:sportique/app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportique/pages/main_profile_page.dart';
import 'package:sportique/pages/main_welcome_page.dart';
import 'package:sportique/pages/onboarding_screen.dart';
import 'package:sportique/pages/profile_page.dart';
import 'package:sportique/pages/splash_screen.dart';

void main() {
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
