class AppData {
  DateTime? _selectedDate;
  String url = "http://188.225.35.245:8080";
  late bool isChange;

  void setIsChange(bool expr) {
    isChange = expr;
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
}
