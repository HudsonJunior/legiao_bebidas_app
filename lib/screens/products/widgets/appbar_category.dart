import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legiao_bebidas_app/cubit/category.dart';
import 'package:legiao_bebidas_app/cubit/products.dart';
import 'package:legiao_bebidas_app/definitions/colors.dart';
import 'package:legiao_bebidas_app/models/category.dart';
import 'package:legiao_bebidas_app/screens/products/widgets/product_category.dart';

class AppBarCategory extends StatefulWidget {
  const AppBarCategory({Key? key}) : super(key: key);

  @override
  _AppBarCategoryState createState() => _AppBarCategoryState();
}

class _AppBarCategoryState extends State<AppBarCategory> {
  late final CategoryCubit categoryCubit;
  late final ProductsCubit productsCubit;

  @override
  void initState() {
    super.initState();
    categoryCubit = BlocProvider.of<CategoryCubit>(context);
    productsCubit = BlocProvider.of<ProductsCubit>(context);
  }

  @override
  Widget build(BuildContext context) => SliverPadding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        sliver: SliverAppBar(
          backgroundColor: Palette.lightBlack,
          automaticallyImplyLeading: false,
          snap: true,
          floating: true,
          flexibleSpace: BlocConsumer<CategoryCubit, CategoryState>(
            listenWhen: (previous, current) =>
                previous.currentCategory != current.currentCategory,
            listener: (context, state) =>
                productsCubit.refreshList(state.currentCategory),
            builder: (context, state) => ListView.builder(
              itemBuilder: (context, index) {
                final category = CategoryEnum.values[index];
                return ProductCategory(
                  title: category.value,
                  onTap: () => categoryCubit.updateCurrentCategory(category),
                  isSelected: state.currentCategory == category,
                );
              },
              scrollDirection: Axis.horizontal,
              itemCount: CategoryEnum.values.length,
            ),
          ),
        ),
      );
}
