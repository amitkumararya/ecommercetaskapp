
import 'package:ecommercetaskapp/model/product/CartModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/add_to_cart_bloc/cart_bloc.dart';
import '../../bloc/add_to_cart_bloc/cart_events.dart';
import '../../bloc/product_bloc/product_bloc.dart';
import '../../bloc/product_bloc/product_event.dart';
import '../../bloc/product_bloc/product_state.dart';
import 'package:ecommercetaskapp/repository/products/productRepository.dart';
import '../../config/routes/routes_name.dart';
import '../../model/product/Product.dart';
import '../cart/cart_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ProductRepository productRepository;

  @override
  void initState() {
    super.initState();
    productRepository = ProductRepository();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ecommerce Products'),
        elevation: 0,
        backgroundColor: Colors.teal,
        actions:  [
    IconButton(
    icon: Icon(Icons.shopping_cart),
    onPressed: () {
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => CartScreen()));
  },
    )],
      ),
      body: BlocProvider(
        create: (context) =>
        ProductBloc(productRepository: productRepository)
          ..add(FetchProducts()),
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductInitial) {
              return _buildInitialContent();
            } else if (state is ProductLoading) {
              return _buildLoadingIndicator();
            } else if (state is ProductLoaded) {
              return _buildProductList(state.products);
            } else if (state is ProductError) {
              return _buildErrorContent(state.message);
            }
            return _buildEmptyContent();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, RoutesName.productPage);
        },
        backgroundColor: Colors.white,
        child: const Icon(Icons.category_outlined, color: Colors.cyan),
      ),
    );
  }

  Widget _buildInitialContent() {
    return Center(
      child: Text(
        'Press the button to fetch products',
        style: TextStyle(fontSize: 18, color: Colors.grey[600]),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _buildProductList(List<Product> products) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<ProductBloc>().add(FetchProducts());
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          int crossAxisCount;
          double screenWidth = constraints.maxWidth;
          if (screenWidth < 600) {
            crossAxisCount = 2;
          } else if (screenWidth < 900) {
            crossAxisCount = 3;
          } else {
            crossAxisCount = 4;
          }

          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(8.0),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      final product = products[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            RoutesName.productDetailsScreen,
                            arguments: product,
                          );
                        },
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                                  child: Image.network(
                                    product.image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  product.title,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  '\$${product.price}',
                                  style: TextStyle(color: Colors.teal),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    BlocProvider.of<CartBloc>(context).add(AddToCart(product as CartProduct));
                                  },
                                  child: Text('Add to Cart'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    childCount: products.length,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildErrorContent(String message) {
    return Center(
      child: Text(
        'Error: $message',
        style: const TextStyle(color: Colors.red, fontSize: 18),
      ),
    );
  }

  Widget _buildEmptyContent() {
    return const Center(child: Text('No products available.'));
  }
}