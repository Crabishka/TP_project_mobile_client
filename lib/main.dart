import 'package:flutter/material.dart';
import 'package:sportique/client_api/product_description_repository.dart';
import 'package:sportique/data/product_description.dart';
import 'package:sportique/pages/catalog.dart';
import 'package:sportique/pages/product_page.dart';
import 'package:sportique/pages/profile.dart';

import 'data/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sportique',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProductPage(id: 1),
      routes: {
        '/catalog': (BuildContext context) => CatalogPage(),
        '/profile': (BuildContext context) => ProfilePage(),
      },
      onGenerateRoute: (setting) {
        if (setting.name == '/product') {
          final id = setting.arguments as int;
          return MaterialPageRoute(builder: (_) => ProductPage(id: id));
        }
        return null;
      },
    );
  }
}
