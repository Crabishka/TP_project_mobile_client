import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sportique/pages/catalog.dart';
import 'package:sportique/pages/product_page.dart';
import 'package:sportique/pages/profile.dart';
import 'package:sportique/widgets/navigation/bottom_navigation.dart';
import 'package:sportique/widgets/navigation/tab_item.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AppState();
  }
}

class AppState extends State<App> {
  static int currentTab = 0;

  final List<TabItem> tabs = [
    TabItem(
      tabName: "Catalog",
      icon: Icons.list,
      page: CatalogPage(),
    ),
    TabItem(
      tabName: "Cart",
      icon: Icons.shopping_cart,
      page: ProductPage(id: 5),
    ),
    TabItem(
      tabName: "Profile",
      icon: Icons.person,
      page: const ProfilePage(),
    ),
  ];

  AppState() {
    tabs.asMap().forEach((index, details) {
      details.setIndex(index);
    });
  }

  void _selectTab(int index) {
    if (index == currentTab) {
      // pop to first route
      // if the user taps on the active tab
      tabs[index].key.currentState?.popUntil((route) => route.isFirst);
    } else {
      // update the state
      // in order to repaint
      setState(() => currentTab = index);

    }
  }

  @override
  Widget build(BuildContext context) {
    // WillPopScope handle android back btn
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await tabs[currentTab].key.currentState!.maybePop();
        if (isFirstRouteInCurrentTab) {
          // if not on the 'main' tab
          if (currentTab != 0) {
            // select 'main' tab
            _selectTab(0);
            // back button handled by app
            return false;
          }
        }
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        // indexed stack shows only one child
        body: IndexedStack(
          index: currentTab,
          children: tabs.map((e) => e.page).toList(),
        ),
        // Bottom navigation
        bottomNavigationBar: BottomNavigation(
          onSelectTab: _selectTab,
          tabs: tabs,
        ),

      ),
    );
  }
}
