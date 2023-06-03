import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class DateShow extends StatelessWidget {
  DateTime dateTime;
  double? height;

  DateShow({super.key, required this.dateTime, this.height});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Ваш заказ на ${getRuDate(dateTime)}",
      textAlign: TextAlign.center,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: height ?? 24),
    );
  }

  String getRuDate(DateTime time) {
    return "${DateFormat('dd').format(time)}-${getRuMonthByNumber(time.month)} ";
  }

  String getRuMonthByNumber(int number) {
    switch (number) {
      case 1:
        return "Янв";
      case 2:
        return "Февр";
      case 3:
        return "Март";
      case 4:
        return "Апрл";
      case 5:
        return "Май";
      case 6:
        return "Июнь";
      case 7:
        return "Июль";
      case 8:
        return "Авг";
      case 9:
        return "Сент";
      case 10:
        return "Окт";
      case 11:
        return "Нояб";
      default:
        return "Дек";
    }
  }
}
