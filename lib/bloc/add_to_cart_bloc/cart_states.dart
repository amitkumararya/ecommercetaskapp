// cart_state.dart
import 'package:equatable/equatable.dart';

import '../../model/product/CartModel.dart';
import '../../model/product/Product.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final Cart cart;
  CartLoaded(this.cart);
}

class ProductLoadings extends CartState {}

class ProductLoadeds extends CartState {
  final Product product;
  ProductLoadeds(this.product);
}

class CartUpdated extends CartState {
  final List<CartProduct> updatedProducts;
  CartUpdated(this.updatedProducts);
}

class CartError extends CartState {
  final String message;
  CartError(this.message);
}
