import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legiao_bebidas_app/cubit/products.dart';
import 'package:legiao_bebidas_app/models/payment.dart';

class CartState {
  final Iterable<ProductData> products;
  final PaymentFormEnum payment;

  CartState({
    required this.products,
    required this.payment,
  });

  List<String?> get productsString => products
      .map(
        (product) => product.quantity > 0
            ? '${product.quantity} unidade(s) - ${product.text}\n'
            : null,
      )
      .where((string) => string != null)
      .toList();

  String get productsText => productsString.join('\n');

  CartState copyWith({
    int? totalQuantity,
    Iterable<ProductData>? products,
    PaymentFormEnum? payment,
  }) {
    return CartState(
      products: products ?? this.products,
      payment: payment ?? this.payment,
    );
  }

  double get totalPrice => products.fold(
      0.0,
      (previousValue, product) =>
          previousValue + (product.price * product.quantity));

  factory CartState.empty() => CartState(
        products: [],
        payment: PaymentFormEnum.money,
      );
}

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartState.empty());

  void updatePayment(PaymentFormEnum payment) {
    emit(state.copyWith(payment: payment));
  }

  void setCartProducts(Iterable<ProductData> products) {
    final newProducts = products.where((product) => product.quantity > 0);

    emit(state.copyWith(products: newProducts));
  }
}
