import 'category_state.dart';

class ProductLoadeds extends CategoryState {
  final List<dynamic> products;

  ProductLoadeds(this.products);

  @override
  List<Object?> get props => [products];
}