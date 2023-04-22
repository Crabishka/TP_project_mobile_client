import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sportique/pages/catalog.dart';
import 'package:sportique/pages/profile.dart';

class MyNavigationBar extends StatefulWidget {
  const MyNavigationBar({super.key});

  onTapTapped(int index) {}

  @override
  State<StatefulWidget> createState() {
    return _MyNavigationBar();
  }
}

class _MyNavigationBar extends State<MyNavigationBar> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: currentPageIndex,
        selectedItemColor: Colors.amber,
        onTap: (int index) {
          currentPageIndex = index;
          if (index == 1) {
            Navigator.pushNamed(context, '/catalog');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/profile');
          } else if (index == 3) {
            Navigator.pushNamed(context, '/profile');
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Catalog',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ]);
  }
}
