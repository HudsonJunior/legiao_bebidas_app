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

  ProductData({
    required this.id,
    required this.title,
    required this.price,
    required this.imagePath,
    required this.category,
    required this.description,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
        title: json['title'],
        price: json['price'],
        imagePath: json['imagePath'],
        category: (json['category'] as String).category,
        description: json['description'],
        id: json['id'],
      );

  String get text => '$title - R\$ ${price.toStringAsFixed(2)}';
  @override
  List<Object?> get props => [id, title, price, category];
}

class ProductState {
  List<ProductData> products;
  List<ProductData> currentProducts;
  ProductData? selectedProduct;
  bool isLoading;

  ProductState({
    required this.products,
    required this.currentProducts,
    this.isLoading = false,
    this.selectedProduct,
  });

  bool get hasAnyProductSelected => selectedProduct != null;

  ProductState copyWith({
    List<ProductData>? products,
    List<ProductData>? currentProducts,
    bool isLoading = false,
    ProductData? selectedProduct,
  }) =>
      ProductState(
        products: products ?? this.products,
        isLoading: isLoading,
        selectedProduct: selectedProduct ?? this.selectedProduct,
        currentProducts: currentProducts ?? this.currentProducts,
      );

  factory ProductState.empty() =>
      ProductState(products: [], currentProducts: []);
}

class ProductsCubit extends Cubit<ProductState> {
  ProductsCubit() : super(ProductState.empty());

  void load() async {
    emit(state.copyWith(isLoading: true));
    try {
      final String data = await rootBundle.loadString('assets/dados.json');
      final dataConverted = await json.decode(data);
      final List<ProductData> products = dataConverted != null
          ? dataConverted
              .map<ProductData>((produto) => ProductData.fromJson(produto))
              .toList()
          : [];
      emit(state.copyWith(products: products, currentProducts: products));
    } catch (error) {
      emit(state.copyWith(products: [], currentProducts: []));
    }
  }

  void selectProduct(ProductData product) async {
    emit(state.copyWith(selectedProduct: product));
  }

  void refreshList(CategoryEnum category) async {
    emit(state.copyWith(isLoading: true));

    if (category == CategoryEnum.todos) {
      emit(state.copyWith(currentProducts: state.products));
    } else {
      final filteredProducts = List<ProductData>.from(state.products)
          .where((product) => product.category == category)
          .toList();

      emit(state.copyWith(currentProducts: filteredProducts));
    }
  }
}
