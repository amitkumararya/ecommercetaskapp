import 'category_event.dart';

class FetchProductsByCategory extends CategoryEvent {
  final String category;

  FetchProductsByCategory(this.category);

  @override
  List<Object?> get props => [category];
}