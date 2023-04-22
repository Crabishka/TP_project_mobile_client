import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data/product_description.dart';

class ProductCard extends StatelessWidget {
  final ProductDescription product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: const Color(0xFFEFFBFD),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          Expanded(
              child: Container(
                  padding: const EdgeInsets.all(20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(product.image),
                  ))),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  style: const TextStyle(
                    fontFamily: 'PoiretOne',
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                  ),
                ),
                Text(
                  product.description,
                  style: const TextStyle(
                    fontFamily: 'PoiretOne',
                    fontSize: 16,
                  ),
                ),
                Text(
                  '${product.price} руб./час',
                  style: const TextStyle(
                    fontFamily: 'PoiretOne',
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // TODO add to cart
                  },
                  child: const Text('К товару'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
