import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legiao_bebidas_app/cubit/current_quantity.dart';
import 'package:legiao_bebidas_app/cubit/products.dart';
import 'package:legiao_bebidas_app/definitions/colors.dart';
import 'package:legiao_bebidas_app/definitions/extension.dart';
import 'package:legiao_bebidas_app/screens/details/details.dart';
import 'package:legiao_bebidas_app/screens/products/widgets/quantity_selector.dart';
import 'package:legiao_bebidas_app/widgets/product_image.dart';

class ProductItem extends StatefulWidget {
  final ProductData product;

  const ProductItem({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  late ProductsCubit productsCubit;
  late CurrentQuantityCubit currentQuantityCubit;

  @override
  void initState() {
    super.initState();
    productsCubit = BlocProvider.of<ProductsCubit>(context)..load();
    currentQuantityCubit = BlocProvider.of<CurrentQuantityCubit>(context);
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () {
          productsCubit.selectProduct(widget.product);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const DetailsScreen(),
            ),
          );
        },
        child: Card(
          color: Palette.lightBlack,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          elevation: 5.0,
          shadowColor: Colors.black87,
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 1.3,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(8.0),
                    topRight: const Radius.circular(8.0),
                  ),
                  child: Hero(
                    tag: 'product image ${widget.product.id}',
                    child: ProductImage(widget.product.imagePath),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 8.0,
                        ),
                        child: Hero(
                          tag: 'product title ${widget.product.id}',
                          child: Text(
                            widget.product.title,
                            maxLines: 2,
                            style: context.textTheme.headline2,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                    Hero(
                      tag: 'product price ${widget.product.id}',
                      child: Text(
                        'R\$ ${widget.product.price.toStringAsFixed(2)}',
                        style: context.textTheme.bodyText2,
                      ),
                    ),
                    QuantitySelector(product: widget.product),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
