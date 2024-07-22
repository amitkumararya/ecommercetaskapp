import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../model/product/CartModel.dart';
import '../../model/product/Product.dart';


class CartRepository {
  final String url = "https://fakestoreapi.com/carts/2";
  final String purl = "https://fakestoreapi.com/products/";

  Future<Cart> loadCartFromApi() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(
          response.body); // Corrected here
      return Cart.fromJson(json);
    } else {
      throw Exception('Failed to load cart');
    }
  }
}
/*
  Future<Product> getProductFromApi(int productId) async {
    final response = await http.get(Uri.parse('$purl$productId'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body); // Corrected here
      return Product.fromJson(json);
    } else {
      throw Exception('Failed to fetch product');
    }
  }
}
*/
