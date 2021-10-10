import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legiao_bebidas_app/cubit/current_quantity.dart';
import 'package:legiao_bebidas_app/cubit/products.dart';

import 'package:legiao_bebidas_app/definitions/colors.dart';
import 'package:legiao_bebidas_app/definitions/extension.dart';
import 'package:legiao_bebidas_app/widgets/cart_fab.dart';
import 'package:legiao_bebidas_app/widgets/product_image.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({
    Key? key,
  }) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late final ProductsCubit productsCubit;
  late CurrentQuantityCubit currentQuantityCubit;

  int selectedValue = 0;

  @override
  void initState() {
    super.initState();
    productsCubit = BlocProvider.of<ProductsCubit>(context);
    currentQuantityCubit = BlocProvider.of<CurrentQuantityCubit>(context);
  }

  void updateSelectedValue(int newValue) {
    setState(() {
      selectedValue = newValue;
    });
    currentQuantityCubit.updateCurrentQuantity(selectedValue);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Palette.lightBlack,
        body: SafeArea(
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 1.2,
                    child: Hero(
                      tag:
                          'product image ${productsCubit.state.selectedProduct!.imagePath}',
                      child: ProductImage(
                        productsCubit.state.selectedProduct!.imagePath,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () => Navigator.of(context).pop(),
                    color: Palette.primary,
                  ),
                ],
              ),
              const SizedBox(height: 18.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag:
                          'product title ${productsCubit.state.selectedProduct!.title}',
                      child: Text(
                        productsCubit.state.selectedProduct!.title,
                        textAlign: TextAlign.start,
                        maxLines: 3,
                        style: context.textTheme.headline4,
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    Hero(
                      tag:
                          'product price ${productsCubit.state.selectedProduct!.id}',
                      child: Text(
                        'R\$ ${productsCubit.state.selectedProduct!.price.toStringAsFixed(2)}',
                        textAlign: TextAlign.start,
                        style: context.textTheme.subtitle1,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    const Divider(
                      color: Colors.white,
                      thickness: 0.2,
                    ),
                    const SizedBox(height: 28.0),
                    Text(
                      productsCubit.state.selectedProduct!.description,
                      textAlign: TextAlign.start,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.subtitle1!
                          .copyWith(color: Palette.primary),
                    ),
                    const SizedBox(height: 28.0),
                    const Divider(
                      color: Colors.white,
                      thickness: 0.2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: const CartFab(),
      );
}
