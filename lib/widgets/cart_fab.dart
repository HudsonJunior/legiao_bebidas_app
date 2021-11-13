import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legiao_bebidas_app/cubit/cart.dart';
import 'package:legiao_bebidas_app/cubit/products.dart';
import 'package:legiao_bebidas_app/definitions/colors.dart';
import 'package:legiao_bebidas_app/definitions/extension.dart';
import 'package:legiao_bebidas_app/screens/cart/cart.dart';

class CartFab extends StatefulWidget {
  const CartFab({Key? key}) : super(key: key);

  @override
  _CartFabState createState() => _CartFabState();
}

class _CartFabState extends State<CartFab> {
  @override
  Widget build(BuildContext context) => SizedBox(
        height: 80,
        width: 80,
        child: FloatingActionButton(
          child: Badge(
            toAnimate: false,
            child: Icon(
              Icons.shopping_cart_outlined,
              size: 35,
            ),
            badgeContent: BlocBuilder<ProductsCubit, ProductState>(
              builder: (context, state) => Text(
                state.totalQuantity.toString(),
                style: context.textTheme.headline3,
              ),
            ),
            badgeColor: Colors.white,
            elevation: 6,
          ),
          onPressed: () {
            BlocProvider.of<CartCubit>(context).setCartProducts(
              BlocProvider.of<ProductsCubit>(context).state.cartProducts,
            );
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const CartScreen(),
              ),
            );
          },
          foregroundColor: Colors.white,
          backgroundColor: Palette.primary,
          tooltip: 'Carrinho',
        ),
      );
}
