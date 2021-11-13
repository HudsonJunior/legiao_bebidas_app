import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legiao_bebidas_app/models/category.dart';

class ProductData extends Equatable {
  final int id;
  final String title;
  final double price;
  final String imagePath;
  final CategoryEnum category;
  final String description;
  final int quantity;

  ProductData({
    required this.id,
    required this.title,
    required this.price,
    required this.imagePath,
    required this.category,
    required this.description,
    this.quantity = 0,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
        title: json['title'],
        price: json['price'],
        imagePath: json['imagePath'],
        category: (json['category'] as String).category,
        description: json['description'],
        id: json['id'],
      );

  String get text => '$title - R\$ ${(price * quantity).toStringAsFixed(2)}';

  @override
  List<Object?> get props => [id, title, price, category];

  ProductData copyWith({
    int? id,
    String? title,
    double? price,
    String? imagePath,
    CategoryEnum? category,
    String? description,
    int? quantity,
  }) {
    return ProductData(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      imagePath: imagePath ?? this.imagePath,
      category: category ?? this.category,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
    );
  }
}

class ProductState {
  Map<int, ProductData> products;
  ProductData? selectedProduct;
  bool isLoading;
  CategoryEnum currentCategory;

  Iterable<ProductData> get cartProducts => products.values;

  int get totalQuantity => products.values
      .fold(0, (previousValue, product) => previousValue + product.quantity);

  ProductState({
    required this.products,
    this.isLoading = false,
    this.selectedProduct,
    this.currentCategory = CategoryEnum.todos,
  });

  bool get hasAnyProductSelected => selectedProduct != null;

  ProductState copyWith({
    Map<int, ProductData>? products,
    bool isLoading = false,
    ProductData? selectedProduct,
    CategoryEnum? currentCategory,
  }) =>
      ProductState(
        products: products ?? this.products,
        isLoading: isLoading,
        selectedProduct: selectedProduct ?? this.selectedProduct,
        currentCategory: currentCategory ?? this.currentCategory,
      );

  factory ProductState.empty() => ProductState(products: {});
}

class ProductsCubit extends Cubit<ProductState> {
  ProductsCubit() : super(ProductState.empty());

  void load() async {
    emit(state.copyWith(isLoading: true));
    try {
      final String data = await rootBundle.loadString('assets/dados.json');
      final dataConverted = await json.decode(data) as List<dynamic>?;

      final products = <int, ProductData>{};

      dataConverted?.forEach((product) {
        products[product['id']] = ProductData.fromJson(product);
      });

      emit(state.copyWith(products: products));
    } catch (error) {
      emit(state.copyWith(products: {}));
    }
  }

  void selectProduct(ProductData product) async {
    emit(state.copyWith(selectedProduct: product));
  }

  void addProduct(int id) {
    final newProducts = Map<int, ProductData>.from(
      state.products
        ..update(
          id,
          (oldProduct) =>
              oldProduct.copyWith(quantity: oldProduct.quantity + 1),
        ),
    );

    emit(state.copyWith(products: newProducts));
  }

  void decrementProduct(int id) {
    if (state.products[id]?.quantity != 0) {
      final newProducts = Map<int, ProductData>.from(
        state.products
          ..update(
            id,
            (oldProduct) =>
                oldProduct.copyWith(quantity: oldProduct.quantity - 1),
          ),
      );

      emit(state.copyWith(products: newProducts));
    }
  }

  void selectCategory(CategoryEnum category) {
    emit(state.copyWith(currentCategory: category));
  }
}
