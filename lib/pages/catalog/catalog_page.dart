import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sportique/client_api/product_description_repository.dart';
import 'package:sportique/widgets/navigation/bottom_navigation_bar.dart';
import '../../data/product_description.dart';
import '../../widgets/product_card.dart';

class CatalogPage extends StatelessWidget {
  CatalogPage({super.key});

  final Future<List<ProductDescription>> list =
      ProductDescriptionRepository.instance.getAllProductDescription();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB6CFD8),
      body: FutureBuilder<List<ProductDescription>>(
        future:
            ProductDescriptionRepository.instance.getAllProductDescription(),
        builder: (BuildContext context,
            AsyncSnapshot<List<ProductDescription>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Обрабатываем ошибку, если она произошла
            return Text('Ошибка загрузки данных');
          } else {
            // Отображаем данные, когда они загружены
            return CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 40,
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                      childCount: snapshot.data!.length, (context, index) {
                    return Padding(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                        child: ProductCard(product: snapshot.data![index]));
                  }),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
