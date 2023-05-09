import 'package:flutter/material.dart';
import 'package:sportique/app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportique/pages/main_welcome_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sportique',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FutureBuilder(
          future: SharedPreferences.getInstance(),
          builder: (BuildContext context,
              AsyncSnapshot<SharedPreferences> snapshot) {
            if (snapshot.hasData) {
              final prefs = snapshot.data;

              final isFirstTime = prefs!.getBool('first_time') ?? true;

              if (isFirstTime) {
                prefs.setBool('first_time', false);
                return const MainWelcomePage();
              } else {
                return App();
              }
            } else {
              return CircularProgressIndicator();
            }
          },
        ));
  }
}
