import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/data/product_description.dart';
import '../pages/catalog/product_page.dart';

class ProductCard extends StatelessWidget {
  final ProductDescription product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 2,
        color: const Color(0xFFEFFBFD),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    ProductPage(productDescription: product)));
          },
          child: Column(
            children: [
              ClipRRect(
                  child: AspectRatio(
                aspectRatio: 1,
                child: CachedNetworkImage(
                  imageUrl: product.image,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              )),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      style: const TextStyle(
                        fontFamily: 'PoiretOne',
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      product.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: 'PoiretOne',
                        fontWeight: FontWeight.normal,
                        color: Color(0xBB000000),
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      '${product.price.truncate().toString()} руб/ч',
                      style: const TextStyle(
                        fontFamily: 'PoiretOne',
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

// Navigator.of(context).push(MaterialPageRoute(
// builder: (context) =>
// ProductPage(productDescription: product)));
