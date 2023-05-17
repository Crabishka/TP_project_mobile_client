import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportique/model/user_model.dart';

import '../data/product.dart';

class OrderProductCard extends StatefulWidget {
  Product product;

  OrderProductCard({super.key, required this.product});

  @override
  State<OrderProductCard> createState() => _OrderProductCardState();
}

class _OrderProductCardState extends State<OrderProductCard> {
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
                  widget.product.description.image,
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
                widget.product.description.title,
                style: const TextStyle(
                  fontFamily: 'PoiretOne',
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),
              ),
              Text(
                'Размер: ${widget.product.size}',
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontFamily: 'PoiretOne',
                  fontSize: 24,
                ),
              ),
              Text(
                'Стоимость: ${widget.product.description.price} руб/ч',
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontFamily: 'PoiretOne',
                  fontSize: 18,
                ),
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {


                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                    child: const Text(
                      'Изменить размер',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'PoiretOne',
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        Provider.of<UserModel>(context, listen: false)
                            .removeProduct(widget.product.description.id,
                                widget.product.size);
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                    child: const Text(
                      'Убрать',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'PoiretOne',
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
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
