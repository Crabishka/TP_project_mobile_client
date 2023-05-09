import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainWelcomePage extends StatefulWidget {
  const MainWelcomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MainWelcomePageState();
  }
}

class _MainWelcomePageState extends State<MainWelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink,
    );
  }
}
