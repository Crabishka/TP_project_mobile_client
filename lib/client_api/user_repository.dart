import '../data/user.dart';

class UserRepository {
  UserRepository._();

  static final instance = UserRepository._();

  User user1 = User(1, "Amrit", "+79518747578");
  User user2 = User(2, "Amala", "+79518747578");
  User user3 = User(3, "Amen", "+79518747578");
  late var users = [user1, user2, user3];

  User getUser() {
    return users[2];
  }


}
