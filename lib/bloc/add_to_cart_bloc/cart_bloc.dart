import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import '../../model/product/CartModel.dart';
import '../../repository/products/CartRepository.dart';
import 'cart_events.dart';
import 'cart_states.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository cartRepository;

  CartBloc(this.cartRepository) : super(CartInitial()) {
    on<LoadCart>(_onLoadCart);
   // on<FetchProduct>(_onFetchProduct);
    on<AddToCart>(_onAddToCart);
  }

  Future<void> _onLoadCart(LoadCart event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      var cart = await cartRepository.loadCartFromApi();
      emit(CartLoaded(cart));
    } catch (e) {
      emit(CartError("Failed to load cart"));
    }
  }

/*  Future<void> _onFetchProduct(FetchProduct event, Emitter<CartState> emit) async {
    emit(ProductLoadings());
    try {
      var product = await cartRepository.getProductFromApi(event.productId);
      emit(ProductLoadeds(product));
    } catch (e) {
      emit(CartError("Failed to fetch product"));
    }
  }*/

  Future<void> _onAddToCart(AddToCart event, Emitter<CartState> emit) async {
    try {
      final currentState = state;
      if (currentState is CartLoaded) {
        List<CartProduct> updatedProducts = List.from(currentState.cart.products);
        updatedProducts.add(event.product);


        emit(CartUpdated(updatedProducts));
      } else {
        emit(CartError("Cart is not loaded."));
      }
    } catch (e) {
      emit(CartError("Failed to add product to cart"));
    }
  }
}