import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sportique/pages/product_page.dart';

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
        child: Container(
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              Expanded(
                  child: Container(
                      padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: CachedNetworkImage(
                            imageUrl: product.image,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          )))),
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
                      overflow: TextOverflow.ellipsis,
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
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                ProductPage(productDescription:  product))); // FIXME
                      },
                      child: const Text('К товару'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
