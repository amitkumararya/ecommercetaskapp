import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../product_bloc/product_state.dart';
import 'category_event.dart';
import 'category_state.dart';
import 'fetch_category_even.dart';
import 'fetch_category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitial()) {
    on<FetchCategories>((event, emit) async {
      emit(CategoryLoading());

      try {
        final response = await http.get(
            Uri.parse('https://fakestoreapi.com/products/categories'));

        if (response.statusCode == 200) {
          final List<dynamic> data = json.decode(response.body);
          final List<String> categories = List<String>.from(data);
          emit(CategoryLoaded(categories));
        } else {
          emit(CategoryError('Failed to fetch categories'));
        }
      } catch (e) {
        emit(CategoryError('Failed to fetch categories'));
      }
    });
    on<FetchProductsByCategory>((event, emit) async {
      emit(CategoryLoading());

      try {
        final response = await http.get(Uri.parse('https://fakestoreapi.com/products/category/${event.category}'));

        if (response.statusCode == 200) {
          final List<dynamic> data = json.decode(response.body);
          emit(ProductLoadeds(data));
        } else {
          emit(CategoryError('Failed to fetch products'));
        }
      } catch (e) {
        emit(CategoryError('Failed to fetch products'));
      }
    });
  }
}