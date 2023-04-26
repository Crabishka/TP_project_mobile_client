import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data/product.dart';

class OrderProductCard extends StatelessWidget {
  Product product;

  OrderProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: const Color(0xFFEFFBFD),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          Container(
              width: 130,
              height: 130,
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
              const SizedBox(
                height: 10,
              ),
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
              Text(
                'Стоимость: ${product.description.price} руб/ч',
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontFamily: 'PoiretOne',
                  fontSize: 18,
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                child: const Text(
                  'Изменить размер',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'PoiretOne',
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ))
        ],
      ),
    );
  }
}
