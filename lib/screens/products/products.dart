import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legiao_bebidas_app/cubit/address_information_cubit.dart';
import 'package:legiao_bebidas_app/cubit/products.dart';
import 'package:legiao_bebidas_app/definitions/colors.dart';
import 'package:legiao_bebidas_app/definitions/extension.dart';
import 'package:legiao_bebidas_app/screens/products/widgets/appbar_category.dart';
import 'package:legiao_bebidas_app/screens/products/widgets/product_item.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late ProductsCubit productsCubit;
  late AddressInformationCubit addressInformationCubit;

  @override
  void initState() {
    super.initState();
    productsCubit = BlocProvider.of<ProductsCubit>(context)..load();
    addressInformationCubit = BlocProvider.of<AddressInformationCubit>(context);

    initDb();
  }

  void initDb() async {
    await addressInformationCubit.initDb();
    addressInformationCubit.getStorageInformation();
  }

  @override
  Widget build(BuildContext context) => SafeArea(
        child: BlocBuilder<ProductsCubit, ProductState>(
          bloc: productsCubit,
          builder: (context, state) {
            if (state.isLoading) {
              return Container(
                color: Palette.lightBlack,
                child: Center(
                  child: CircularProgressIndicator(color: Palette.primary),
                ),
              );
            }

            return Container(
              color: Palette.lightBlack,
              child: CustomScrollView(
                slivers: [
                  const AppBarCategory(),
                  if (state.currentProducts.isEmpty)
                    SliverToBoxAdapter(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Não há nenhum produto 🙁',
                          style: context.textTheme.headline6,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  SliverPadding(
                    padding: const EdgeInsets.all(8.0),
                    sliver: SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 280,
                        mainAxisSpacing: 16.0,
                        crossAxisSpacing: 16.0,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final product =
                              state.currentProducts.elementAt(index);

                          return ProductItem(product: product);
                        },
                        childCount: state.currentProducts.length,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
}
