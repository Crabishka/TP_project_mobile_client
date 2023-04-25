import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data/product.dart';

class ProductLittleCard extends StatelessWidget {
  Product product;

  ProductLittleCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: const Color(0xFFEFFBFD),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          Container(
              width: 150,
              height: 120,
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  product.description.image,
                  fit: BoxFit.cover,
                ),
              )),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.description.title,
                style: const TextStyle(
                  fontFamily: 'PoiretOne',
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),
              ),
              Text(
                'Размер: ${product.size}',
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontFamily: 'PoiretOne',
                  fontSize: 24,
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
