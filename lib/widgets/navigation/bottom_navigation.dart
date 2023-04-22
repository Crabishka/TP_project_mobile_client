import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sportique/widgets/navigation/tab_item.dart';

import '../../app.dart';

class BottomNavigation extends StatelessWidget {
  final ValueChanged<int> onSelectTab;
  final List<TabItem> tabs;

  const BottomNavigation(
      {super.key, required this.onSelectTab, required this.tabs});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: tabs
          .map(
            (e) => _buildItem(
              index: e.getIndex(),
              icon: e.icon,
              tabName: e.tabName,
            ),
          )
          .toList(),
      onTap: (index) => onSelectTab(
        index,
      ),
    );
  }

  BottomNavigationBarItem _buildItem(
      {required int index, required IconData icon, required String tabName}) {
    return BottomNavigationBarItem(
      icon: Icon(
        icon,
        color: _tabColor(index: index),
      ),
      label: Text(
        tabName,
        style: TextStyle(
          color: _tabColor(index: index),
          fontSize: 12,
        ),
      ).data,
    );
  }

  Color _tabColor({required int index}) {
    return AppState.currentTab == index ? Colors.cyan : Colors.grey;
  }
}
