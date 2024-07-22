import 'package:ecommercetaskapp/config/routes/routes_name.dart';
import 'package:flutter/material.dart';

import '../../model/product/Product.dart';
import '../../model/product/ProductDetail.dart';
import '../../view/home/home_screen.dart';

import '../../view/product/product_details_screen.dart';
import '../../view/product/product_page.dart';
import '../../view/signup/signup_screen.dart';
import '../../view/views.dart';
class Routes {
  static Route<dynamic> generateRoute(RouteSettings setting) {
   // final args = setting.arguments as Map<String, dynamic>?;
    switch (setting.name) {
      case RoutesName.splashScreen:
        return MaterialPageRoute(builder: (context) => const SplashView());
      case RoutesName.loginScreen:
        return MaterialPageRoute(builder: (context) => LoginScreen());
        case RoutesName.homeScreen:

        return MaterialPageRoute(builder: (context) => HomeScreen());
      case RoutesName.signUpScreen: // Add this case
        return MaterialPageRoute(builder: (context) => SignUpScreen());
      case RoutesName.productPage:
        return MaterialPageRoute(builder: (context) => ProductPage());
      case RoutesName.productDetailsScreen:
        if (setting.arguments is Product) {
          final product = setting.arguments as Product;
          return MaterialPageRoute(
              builder: (context) => ProductDetailsScreen(product: product));
        }
        return _errorRoute(); // Add this line to handle invalid arguments
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (context) {
      return const Scaffold(
        body: Center(
          child: Text('No Route Found'),
        ),
      );
    });
  }
}
