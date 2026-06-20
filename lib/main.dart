import 'package:ewire_machine_test/controller/bloc/home_screen_bloc.dart';
import 'package:ewire_machine_test/controller/cart/cart_counter_bloc.dart';
import 'package:ewire_machine_test/controller/theme/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'views/home/home_screen.dart';
import 'views/product_details/product_details_screen.dart';
import 'views/cart/cart_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeBloc()..add(LoadThemeEvent())),
        BlocProvider(
          create: (context) => HomeScreenBloc()..add(LoadProductsEvent()),
        ),
        BlocProvider(
          create: (context) => CartCounterBloc()..add(LoadCartEvent()),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'E-Commerce App',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: state.themeMode,
            initialRoute: '/',
            routes: {
              '/': (context) => const HomeScreen(),
              '/product-details': (context) => const ProductDetailsScreen(),
              '/cart': (context) => const CartScreen(),
            },
          );
        },
      ),
    );
  }
}
