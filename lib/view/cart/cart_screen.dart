import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/add_to_cart_bloc/cart_bloc.dart';
import '../../bloc/add_to_cart_bloc/cart_events.dart';
import '../../bloc/add_to_cart_bloc/cart_states.dart';
import '../../repository/products/CartRepository.dart';
class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cart')),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is CartLoaded) {
            return ListView.builder(
              itemCount: state.cart.products.length,
              itemBuilder: (context, index) {
                final product = state.cart.products[index];
                return ListTile(
                  title: Text('Product ID: ${product.productId}, Quantity: ${product.quantity}'),
                );
              },
            );
          } else if (state is CartError) {
            return Center(child: Text(state.message));
          }
          return Center(child: Text('No Cart Data'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<CartBloc>().add(LoadCart());
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
/*
class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartBloc(CartRepository())..add(LoadCart()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Text('Cart'),
        ),
        body: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is CartLoaded) {
              return ListView.builder(
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Product ID: ${state.products[index]["productId"]}'),
                    subtitle: Text('Quantity: ${state.products[index]["quantity"]}'),
                    onTap: () {
                      BlocProvider.of<CartBloc>(context).add(FetchProduct(state.products[index]["productId"]));
                    },
                  );
                },
              );
            } else if (state is ProductLoadeds) {
              return Column(
                children: [
                  Text('Product Name: ${state.product["title"]}'),
                  Text('Price: ${state.product["price"]}'),

                ],
              );
            } else if (state is CartError) {
              return Center(child: Text(state.message));
            } else {
              return Center(child: Text('Something went wrong'));
            }
          },
        ),
      ),
    );
  }
}
*/
