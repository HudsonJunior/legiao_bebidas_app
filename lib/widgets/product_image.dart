import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  const ProductImage(
    this.image,
  );

  final String image;

  @override
  Widget build(BuildContext context) => Image.asset(
        'assets/images/$image',
        fit: BoxFit.fill,
        filterQuality: FilterQuality.high,
      );
}
