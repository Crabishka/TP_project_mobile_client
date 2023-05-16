import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sportique/client_api/order_repository.dart';
import 'package:sportique/client_api/user_repository.dart';

import 'package:sportique/widgets/order_card.dart';

import '../../app.dart';
import '../../data/user.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key, required this.user});

  User? user;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB6CFD8),
      appBar: AppBar(
        leadingWidth: 80,
        leading: TextButton(
          child: const Text(
            "Выйти",
            style: TextStyle(
                fontFamily: 'PoiretOne',
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            setState(() {
              UserRepository.instance.logout();
            });
            App.changeIndex(2);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => App()));
          },
        ),
        backgroundColor: const Color(0xFF2280BA),
        toolbarHeight: 40,
      ),
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: [
          SliverToBoxAdapter(
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 0, 0),
                  child: Text("Здравствуйте, ${widget.user!.name}",
                      style: const TextStyle(
                        color: Color(0xFF3C2C9E),
                        fontFamily: 'PoiretOne',
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      )))),
          SliverToBoxAdapter(
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 0, 0),
                  child: Text(
                    "Ваш номер ${widget.user!.phoneNumber}",
                    style: const TextStyle(
                      color: Color(0xFF3C2C9E),
                      fontFamily: 'PoiretOne',
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ))),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                childCount: widget.user!.orders.length, (context, index) {
              return Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                  child: OrderCard(order: widget.user!.orders[index]));
            }),
          )
        ],
      ),
    );
  }
}
