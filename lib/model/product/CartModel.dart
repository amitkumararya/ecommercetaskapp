class CartProduct {
  final int productId;
  final int quantity;

  CartProduct({
    required this.productId,
    required this.quantity,
  });

  factory CartProduct.fromJson(Map<String, dynamic> json) {
    return CartProduct(
      productId: json['productId'],
      quantity: json['quantity'],
    );
  }
}

class Cart {
  final int id;
  final int userId;
  final DateTime date;
  final List<CartProduct> products;

  Cart({
    required this.id,
    required this.userId,
    required this.date,
    required this.products,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    var productsList = json['products'] as List;
    List<CartProduct> products = productsList.map((i) => CartProduct.fromJson(i)).toList();

    return Cart(
      id: json['id'],
      userId: json['userId'],
      date: DateTime.parse(json['date']),
      products: products,
    );
  }
}
