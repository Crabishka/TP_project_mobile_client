import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sportique/client_api/token_hepler.dart';
import 'package:sportique/client_api/user_repository.dart';
import 'package:sportique/pages/auth_form_page.dart';
import 'package:sportique/pages/reg_form_page.dart';
import 'package:sportique/pages/profile_page.dart';

import '../data/user.dart';

class MainProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainProfilePageState();
  }
}

class _MainProfilePageState extends State<MainProfilePage> {
  late User user;

  Future<void> checkToken() async  {
    String? token = await TokenHelper().getUserToken();
    setState(() {
      if (token != null) {
        n = 0;
        UserRepository.instance.getUser(context).then((value) => user = value);
      } else {
        n = 2;
      }
    });
  }

  int n = 3;

  @override
  Widget build(BuildContext context) {
    checkToken();
    if (n == 0) return ProfilePage(user: user);
    if (n == 1) return RegFormPage();
    return AuthFormPage();
  }
}
