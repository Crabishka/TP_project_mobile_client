class AppData {
  DateTime? _selectedDate;
  String url = "http://10.0.2.2:8080";

  String getUrl(){
    return url;
  }

  DateTime? getDate() {
    return _selectedDate;
  }


  void setDate(DateTime data) {
    _selectedDate = data;
  }





}
