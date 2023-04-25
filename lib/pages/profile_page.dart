import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sportique/client_api/order_repository.dart';
import 'package:sportique/client_api/user_repository.dart';
import 'package:sportique/data/order_status.dart';

import 'package:sportique/widgets/order_card.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB6CFD8),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => Navigator.pop(context, false),
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
                  child: Text(
                      "Здравствуйте, ${UserRepository.instance.getUser().name}",
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
                    "Ваш номер ${UserRepository.instance.getUser().phoneNumber}",
                    style: const TextStyle(
                      color: Color(0xFF3C2C9E),
                      fontFamily: 'PoiretOne',
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ))),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                childCount: OrderRepository.instance.getOrderByUser(1).length,
                (context, index) {
              return Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                  child: OrderCard(
                      order:
                          OrderRepository.instance.getOrderByUser(1)[index]));
            }),
          )
        ],
      ),
    );
  }
}
