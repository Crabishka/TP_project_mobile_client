import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sportique/pages/auth_form_page.dart';
import 'package:sportique/pages/catalog_page.dart';
import 'package:sportique/pages/order_page_main.dart';
import 'package:sportique/pages/profile_page.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AppState();
  }

  static changeIndex(int index) {
    AppState.selectedIndex = index;
  }
}

class AppState extends State<App> {
  static int selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  static final List<Widget> _pages = <Widget>[
    CatalogPage(),
    OrderPage(),
    AuthFormPage()
  ];

  @override
  Widget build(BuildContext context) {
    // WillPopScope handle android back btn
    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: _pages,
      ),
      // Bottom navigation
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Catalog"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: "Cart"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
