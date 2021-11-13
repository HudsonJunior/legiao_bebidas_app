import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legiao_bebidas_app/cubit/address_information_cubit.dart';
import 'package:legiao_bebidas_app/cubit/cart.dart';
import 'package:legiao_bebidas_app/cubit/category.dart';
import 'package:legiao_bebidas_app/cubit/current_quantity.dart';
import 'package:legiao_bebidas_app/cubit/products.dart';
import 'package:legiao_bebidas_app/cubit/whatsapp.dart';
import 'package:legiao_bebidas_app/definitions/theme.dart';
import 'package:legiao_bebidas_app/screens/initial/initial.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider<ProductsCubit>(
            create: (BuildContext context) => ProductsCubit(),
          ),
          BlocProvider<CategoryCubit>(
            create: (BuildContext context) => CategoryCubit(),
          ),
          BlocProvider<CartCubit>(
            create: (BuildContext context) => CartCubit(),
          ),
          BlocProvider<CurrentQuantityCubit>(
            create: (BuildContext context) => CurrentQuantityCubit(),
          ),
          BlocProvider<AddressInformationCubit>(
            create: (BuildContext context) => AddressInformationCubit(),
          ),
          BlocProvider<WhatsAppCubit>(
            create: (BuildContext context) => WhatsAppCubit(),
          )
        ],
        child: MaterialApp(
          title: 'Legião das Bebidas',
          theme: AppStyle.theme,
          debugShowCheckedModeBanner: false,
          home: InitialScreen(),
        ),
      );
}
