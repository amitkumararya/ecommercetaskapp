// cart_event.dart
import 'package:equatable/equatable.dart';

import '../../model/product/CartModel.dart';


// Events
abstract class CartEvent {}

class LoadCart extends CartEvent {}

class FetchProduct extends CartEvent {
  final int productId;
  FetchProduct(this.productId);
}

class AddToCart extends CartEvent {
  final CartProduct product;
  AddToCart(this.product);
}
