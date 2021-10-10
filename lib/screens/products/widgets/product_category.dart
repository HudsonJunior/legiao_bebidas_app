import 'package:flutter/material.dart';
import 'package:legiao_bebidas_app/definitions/colors.dart';
import 'package:legiao_bebidas_app/definitions/extension.dart';

class ProductCategory extends StatefulWidget {
  const ProductCategory({
    Key? key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  _ProductCategoryState createState() => _ProductCategoryState();
}

class _ProductCategoryState extends State<ProductCategory> {
  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: widget.onTap,
        child: UnconstrainedBox(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(
                color: Palette.primary,
              ),
              color: widget.isSelected ? Palette.primary : Palette.lightBlack,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 18.0,
              vertical: 8.0,
            ),
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              widget.title,
              style: context.textTheme.headline5!.copyWith(
                color: widget.isSelected ? Colors.white : Palette.primary,
              ),
            ),
          ),
        ),
      );
}
