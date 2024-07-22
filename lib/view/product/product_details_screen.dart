import 'package:flutter/material.dart';

import '../../model/product/Product.dart';
import '../../model/product/ProductDetail.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

   const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(product.image),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$${product.price}',
                    style: const TextStyle(fontSize: 20, color: Colors.teal),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Category: ${product.category.toString().split('.').last}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                /*  Text(
                    'Rating: ${product.rating.rate} (${product.rating.count} reviews)',
                    style: const TextStyle(fontSize: 18),
                  ),*/
                  const SizedBox(height: 8),
                  Text(
                    product.description,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
