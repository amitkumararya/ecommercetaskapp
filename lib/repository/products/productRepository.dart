import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../model/product/CartModel.dart';
import '../../model/product/Product.dart';

class ProductRepository {
  final String baseUrl = 'https://fakestoreapi.com';

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/products'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((productJson) => Product.fromJson(productJson)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
