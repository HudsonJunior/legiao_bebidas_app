import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:legiao_bebidas_app/definitions/colors.dart';
import 'package:legiao_bebidas_app/definitions/extension.dart';

class CartItem extends StatelessWidget {
  final String imagePath;
  final String product;
  final double price;
  final int quantity;

  const CartItem({
    Key? key,
    required this.imagePath,
    required this.product,
    required this.price,
    required this.quantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Flexible(
            child: Badge(
              badgeColor: Palette.primary,
              badgeContent: Text(
                '$quantity',
                style: context.textTheme.bodyText2!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: SizedBox(
                height: 50,
                width: 50,
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/$imagePath',
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 24.0),
          Expanded(
            child: Text(
              '$product\nR\$ ${price.toStringAsFixed(2)}',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.bodyText2,
            ),
          )
        ],
      );
}
