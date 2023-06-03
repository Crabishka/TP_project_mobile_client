import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../app.dart';
import '../../../model/client_api/user_repository.dart';
import '../../../model/data/user.dart';

import '../../widgets/order_card.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  GetIt getIt = GetIt.instance;
  late Future<User> data;

  @override
  void initState() {
    super.initState();
    data = getIt<UserRepository>().getUser();
  }

  Future<void> fetchData() async {
    var newUser = await getIt<UserRepository>().getUser();
    setState(() {
      data = Future.value(newUser);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 80,
        leading: TextButton(
          child: const Text(
            "Выйти",
            style: TextStyle(

                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            setState(() {
              getIt<UserRepository>().logout();
            });
            App.changeIndex(2);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => App()));
          },
        ),
        backgroundColor: const Color(0xFF3EB489),
        toolbarHeight: 40,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await fetchData();
        },
        child: FutureBuilder<User>(
          future: data,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.data == null) {
                return Container(
                  color: const Color(0xFF2280BA),
                );
              }
              var orders = snapshot.data?.orders;
              orders?.sort((b, a) => a.id.compareTo(b.id));
              return CustomScrollView(
                scrollDirection: Axis.vertical,
                slivers: [
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 20,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Image.asset(
                      "./assets/images/ball.png",
                      color: const Color(0xFF3EB489),
                      height: 80,
                    ),
                  ),
                  SliverToBoxAdapter(
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                          child: Center(
                            child: Text("Здравствуйте, ${snapshot.data!.name}",
                                style: const TextStyle(

                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                )),
                          ))),
                  SliverToBoxAdapter(
                      child: Center(
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                        child: Text(
                          snapshot.data!.phoneNumber,
                          style: const TextStyle(

                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        )),
                  )),
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                      child: Text(
                        "Ваши заказы",
                        style: TextStyle(

                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                        childCount: snapshot.data!.orders.length,
                        (context, index) {
                      return Padding(
                          padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                          child: OrderCard(order: orders![index]));
                    }),
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
