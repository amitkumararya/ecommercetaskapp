import 'package:ecommercetaskapp/repository/auth_api/auth_api_repository.dart';
import 'package:ecommercetaskapp/repository/auth_api/auth_http_api_repository.dart';
import 'package:ecommercetaskapp/repository/products/CartRepository.dart';
import 'package:ecommercetaskapp/repository/products/productRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'bloc/add_to_cart_bloc/cart_bloc.dart';
import 'bloc/add_to_cart_bloc/cart_events.dart';
import 'bloc/product_bloc/product_bloc.dart';
import 'bloc/product_bloc/product_event.dart';
import 'config/routes/routes.dart';
import 'config/routes/routes_name.dart';
import 'config/themes/dark_theme.dart';
import 'config/themes/light_theme.dart'; // Package for dependency injection


// GetIt is a package used for service locator or to manage dependency injection
GetIt getIt = GetIt.instance;

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Ensuring that Flutter bindings are initialized
  servicesLocator(); // Initializing service locator for dependency injection
  runApp(const MyApp()); // Running the application
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}); // Constructor for MyApp widget

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
        providers: [
        BlocProvider<ProductBloc>(
        create: (context) => ProductBloc(productRepository: ProductRepository())..add(FetchProducts()),
    ),
          BlocProvider<CartBloc>(
              create: (context) => CartBloc(CartRepository())..add(LoadCart()),

          ) ],
child:
      MaterialApp(
      debugShowCheckedModeBanner: false,
      // Material app configuration
      title: 'Flutter Demo',
      themeMode: ThemeMode.dark, // Setting theme mode to dark
      theme: lightTheme, // Setting light theme
      darkTheme: darkTheme, // Setting dark theme
      localizationsDelegates: const [
       AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
       GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English locale
        Locale('es'), // Spanish locale
      ],
      initialRoute: RoutesName.splashScreen, // Initial route
      onGenerateRoute: Routes.generateRoute, // Generating routes
      ) );
  }
}

// Function for initializing service locator
void servicesLocator() {
  getIt.registerLazySingleton<AuthApiRepository>(() => AuthHttpApiRepository()); // Registering AuthHttpApiRepository as a lazy singleton for AuthApiRepository
  getIt.registerLazySingleton<ProductRepository>(() => ProductRepository());

}
