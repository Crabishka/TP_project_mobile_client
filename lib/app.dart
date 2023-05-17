import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sportique/view/pages/catalog/catalog_page.dart';
import 'package:sportique/view/pages/order/order_page_main.dart';
import 'package:sportique/view/pages/profile/main_profile_page.dart';

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
  bool shouldPop = false;

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  static final List<Widget> _pages = <Widget>[
    CatalogPage(),
    OrderPage(),
    MainProfilePage()
  ];


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (selectedIndex == 0) {
          return true;
        } else {

          setState(() {
            selectedIndex = 0;
          });
          return false;
        }
      },
      child: Scaffold(
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
      ),
    );
  }
}
