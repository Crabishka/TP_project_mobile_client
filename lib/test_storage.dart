class Storage {
  static final Storage _singleton = Storage._internal();

  factory Storage() {
    return _singleton;
  }

  Storage._internal();




}
