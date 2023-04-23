import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sportique/widgets/navigation/tab_item.dart';

import '../../app.dart';

@deprecated
class BottomNavigation extends StatelessWidget {
  final ValueChanged<int> onSelectTab;
  final List<TabItem> tabs;

  const BottomNavigation(
      {super.key, required this.onSelectTab, required this.tabs});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.red,
      selectedLabelStyle: const TextStyle(color: Colors.red),
      items: tabs
          .map(
            (e) => _buildItem(
              index: e.getIndex(),
              icon: e.icon,
              tabName: e.tabName,
            ),
          )
          .toList(),
      onTap: (index) {
        onSelectTab(index);
      },
    );
  }

  BottomNavigationBarItem _buildItem(
      {required int index, required IconData icon, required String tabName}) {
    return BottomNavigationBarItem(
      icon: Icon(
        icon,
      ),
      label: tabName,
    );
  }

  Color _tabColor({required int index}) {
    return Colors.black;
  }
}
