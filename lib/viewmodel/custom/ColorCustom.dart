import 'dart:ui';

import 'package:get_it/get_it.dart';
import 'package:sportique/viewmodel/internal/app_data.dart';

class ColorCustom {

  GetIt getIt = GetIt.instance;

  late Color titleColor;

  factory ColorCustom() {
    return _instance;
  }

  static final ColorCustom _instance = ColorCustom._internal();

  ColorCustom._internal() {
    titleColor = getIt.get<AppData>().getTitleColor();
  }
}
