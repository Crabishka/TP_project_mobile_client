import 'package:flutter/material.dart';
import 'package:sportique/pages/catalog.dart';
import 'package:sportique/pages/profile.dart';

import 'data/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  User user = User("Amrit", "+79518747578");

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sportique',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProfilePage(
        user: user,
      ),
    );
  }
}
