import 'package:bloc/bloc.dart';
import 'package:ecommercetaskapp/bloc/product_bloc/product_event.dart';
import 'package:ecommercetaskapp/bloc/product_bloc/product_state.dart';
import '../../repository/products/productRepository.dart';


class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;

  ProductBloc({required this.productRepository}) : super(ProductInitial()) {
    on<FetchProducts>(_onFetchProducts);
  }

  Future<void> _onFetchProducts(FetchProducts event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      final products = await productRepository.fetchProducts();
      emit(ProductLoaded(products: products));
    } catch (e) {
      emit(ProductError(message: e.toString()));
    }
  }
}
