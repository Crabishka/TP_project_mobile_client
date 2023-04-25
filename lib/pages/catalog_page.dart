import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sportique/client_api/product_description_repository.dart';
import 'package:sportique/widgets/navigation/bottom_navigation_bar.dart';
import '../data/product_description.dart';
import '../widgets/product_card.dart';

class CatalogPage extends StatelessWidget {
  const CatalogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB6CFD8),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: SizedBox(
             height: 40,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                childCount: ProductDescriptionRepository.instance
                    .getAllProductDescription()
                    .length, (context, index) {
              return Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: ProductCard(
                      product: ProductDescriptionRepository.instance
                          .getProductDescription(index)));
            }),
          ),
        ],
      ),
    );
  }
}
