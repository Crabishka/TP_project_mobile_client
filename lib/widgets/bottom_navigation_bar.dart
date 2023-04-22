import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sportique/pages/catalog.dart';
import 'package:sportique/pages/profile.dart';

class MyNavigationBar extends StatelessWidget {
  const MyNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        onTap: (int index) {
          if (index == 1){
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => CatalogPage()));
          } else if (index == 2){
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => ProfilePage()));
          } else if (index == 3){
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => ProfilePage()));
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

  onTapTapped(int index) {}
}
