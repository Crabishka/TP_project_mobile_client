import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportique/viewmodel/user_model.dart';

class AppData extends ChangeNotifier {
  DateTime? _selectedDate;

  String url = "https://1469629-cm31020.tw1.ru";

  // String url = "http://10.0.2.2:8080";
  late bool isChange;
  Color titleColor = Colors.black;

  void setIsChange(bool expr) {
    isChange = expr;
  }

  void notify() {
    notifyListeners();
  }

  String getUrl() {
    return url;
  }

  DateTime? getDate() {
    return _selectedDate;
  }

  void setDate(DateTime data) {
    _selectedDate = data;

  }

  Color getTitleColor() {
    return titleColor;
  }

  void setTitleColor(String titleColor) {
    if (titleColor == "black") {
      this.titleColor = Colors.black;
    } else if (titleColor == "mint") {
      this.titleColor = const Color(0xFF3EB489);
    } else if (titleColor == "red") {
      this.titleColor = const Color(0xFFb43e69);
    } else {
      this.titleColor = Colors.black;
    }
  }
}
