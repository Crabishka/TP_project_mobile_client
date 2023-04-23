import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sportique/pages/catalog_page.dart';
import 'package:sportique/pages/product_page.dart';
import 'package:sportique/pages/profile_page.dart';
import 'package:sportique/widgets/navigation/bottom_navigation.dart';
import 'package:sportique/widgets/navigation/tab_item.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AppState();
  }
}

class AppState extends State<App> {
  static int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static final List<Widget> _pages = <Widget>[
    CatalogPage(),
    ProductPage(id: 5),
    const ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    // WillPopScope handle android back btn
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      // Bottom navigation
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
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
