import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legiao_bebidas_app/cubit/products.dart';
import 'package:legiao_bebidas_app/screens/products/widgets/quantity_icon.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:legiao_bebidas_app/cubit/cart.dart';
import 'package:legiao_bebidas_app/definitions/colors.dart';

class QuantitySelector extends StatefulWidget {
  final ProductData product;

  const QuantitySelector({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  QuantitySelectorState createState() => QuantitySelectorState();
}

class QuantitySelectorState extends State<QuantitySelector> {
  int minValue = 0;
  int maxValue = 50;

  late final CartCubit cartCubit;

  @override
  void initState() {
    super.initState();
    cartCubit = BlocProvider.of<CartCubit>(context);
  }

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: QuantityIcon(
              icon: Icons.remove,
              onTap: () {
                if (widget.product.quantity > minValue) {
                  BlocProvider.of<ProductsCubit>(context)
                      .decrementProduct(widget.product.id);
                }
              },
            ),
          ),
          const SizedBox(width: 8.0),
          NumberPicker(
              minValue: 0,
              maxValue: 50,
              itemCount: 1,
              axis: Axis.horizontal,
              value: widget.product.quantity,
              selectedTextStyle: TextStyle(
                color: Palette.primary,
                fontSize: 26.0,
              ),
              textStyle: TextStyle(
                color: Palette.primary,
              ),
              itemWidth: 30,
              onChanged: (newValue) {
                // setState(() {
                //   selectedValue = newValue;
                // });
              }),
          const SizedBox(width: 8.0),
          Flexible(
            child: QuantityIcon(
              icon: Icons.add,
              onTap: () {
                if (widget.product.quantity < maxValue) {
                  BlocProvider.of<ProductsCubit>(context)
                      .addProduct(widget.product.id);
                }
              },
            ),
          ),
        ],
      );
}
