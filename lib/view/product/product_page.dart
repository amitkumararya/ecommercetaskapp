import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../bloc/category_bloc/category_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/category_bloc/category_state.dart';
import '../../bloc/category_bloc/category_event.dart';
import '../../bloc/category_bloc/fetch_category_even.dart';
import '../../bloc/category_bloc/fetch_category_state.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Categories'),
      backgroundColor: Colors.teal,
      ),
      body: BlocProvider(
        create: (context) => CategoryBloc()..add(FetchCategories()),
        child: BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            if (state is CategoryLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is CategoryLoaded) {
              return ListView.builder(
                //scrollDirection: Axis.horizontal,
                itemCount: state.categories.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(state.categories[index]),
                    onTap: () {
                      context.read<CategoryBloc>().add(FetchProductsByCategory(state.categories[index]));
                    },
                  );
                },
              );
            } else if (state is ProductLoadeds) {
              return ListView.builder(
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  final product = state.products[index];
                  return ListTile(
                    title: Text(product['title']),
                    subtitle: Text('\$${product['price']}'),
                    leading: Image.network(product['image']),
                  );
                },
              );
            } else if (state is CategoryError) {
              return Center(child: Text(state.message));
            }
            return Center(child: Text('No data available'));
          },
        ),
      ),
    );
  }
}

