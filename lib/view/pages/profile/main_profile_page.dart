import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sportique/view/pages/profile/profile_page.dart';

import '../../../model/data/user.dart';
import '../../../viewmodel/user_model.dart';
import 'auth_form_page.dart';

class MainProfilePage extends StatefulWidget {
  const MainProfilePage({super.key});

  @override
  State<MainProfilePage> createState() => _MainProfilePageState();
}

class _MainProfilePageState extends State<MainProfilePage> {
  GetIt getIt = GetIt.instance;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: Provider.of<UserModel>(context, listen: false).getUser(),
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (!snapshot.hasData || snapshot.data == null) {
          return const AuthFormPage();
        } else {
          return ProfilePage();
        }
      },
    );
  }
}
