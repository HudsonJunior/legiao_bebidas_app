import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:legiao_bebidas_app/cubit/products.dart';
import 'package:legiao_bebidas_app/models/payment.dart';
import 'package:legiao_bebidas_app/screens/cart/widgets/payment/payment_form.dart';

class ProductCart extends Equatable {
  final ProductData product;
  final int quantity;

  ProductCart({
    required this.product,
    required this.quantity,
  });

  @override
  List<Object?> get props => [product];

  String get text => '$quantity - ${product.text}';
}

class CartState {
  final int totalQuantity;
  final List<ProductCart> products;
  final PaymentFormEnum payment;

  CartState({
    required this.totalQuantity,
    required this.products,
    required this.payment,
  });

  List<String> get productsString =>
      products.map((product) => product.text).toList();

  String get productsText => productsString.join('\n');

  CartState copyWith({
    int? totalQuantity,
    List<ProductCart>? products,
    PaymentFormEnum? payment,
  }) {
    return CartState(
      totalQuantity: totalQuantity ?? this.totalQuantity,
      products: products ?? this.products,
      payment: payment ?? this.payment,
    );
  }

  double get totalPrice => products.fold(
      0.0,
      (previousValue, product) =>
          previousValue + (product.product.price * product.quantity));

  factory CartState.empty() => CartState(
        totalQuantity: 0,
        products: [],
        payment: PaymentFormEnum.money,
      );
}

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartState.empty());

  void updateTotalQuantity({required bool isIncrementing}) {
    var newQuantity;

    if (isIncrementing) {
      newQuantity = state.totalQuantity + 1;
    } else {
      newQuantity = state.totalQuantity - 1;
    }

    emit(state.copyWith(totalQuantity: newQuantity));
  }

  void addProduct(ProductData product, int quantity) {
    final productCart = ProductCart(product: product, quantity: quantity);

    if (state.products.contains(productCart)) {
      final index = state.products.indexOf(productCart);
      state.products[index] = productCart;
      emit(state.copyWith(products: state.products));
    } else {
      state.products.add(
        ProductCart(product: product, quantity: quantity),
      );
      emit(state.copyWith(products: state.products));
    }
  }

  void updatePayment(PaymentFormEnum payment) {
    emit(state.copyWith(payment: payment));
  }

  void decrementProduct(ProductData product, int quantity) {
    final productCart = ProductCart(product: product, quantity: quantity);
    final alreadyInProducts = state.products.contains(productCart);

    if (alreadyInProducts) {
      final index = state.products.indexOf(productCart);

      if (quantity == 0)
        state.products.removeAt(index);
      else
        state.products[index] = productCart;

      emit(state.copyWith(products: state.products));
    }
  }
}
