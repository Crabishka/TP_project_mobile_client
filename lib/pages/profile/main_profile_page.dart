import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sportique/client_api/token_hepler.dart';
import 'package:sportique/client_api/user_repository.dart';
import 'package:sportique/model/user_model.dart';
import 'package:sportique/pages/profile/auth_form_page.dart';
import 'package:sportique/pages/profile/reg_form_page.dart';
import 'package:sportique/pages/profile/profile_page.dart';

import '../../data/user.dart';

class MainProfilePage extends StatefulWidget {
  MainProfilePage({super.key});

  @override
  State<MainProfilePage> createState() => _MainProfilePageState();
}

class _MainProfilePageState extends State<MainProfilePage> {
  User? user;
  GetIt getIt = GetIt.instance;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: Provider.of<UserModel>(context).getUser(),
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.data == null) {
          return AuthFormPage();
        } else {
          return ProfilePage();
        }
      },
    );
  }
}
