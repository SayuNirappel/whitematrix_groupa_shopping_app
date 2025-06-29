import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whitematrix_groupa_shopping_app/controllers/bottom_nav_bar_controller.dart';
import 'package:whitematrix_groupa_shopping_app/controllers/cartcontroller.dart';
import 'package:whitematrix_groupa_shopping_app/controllers/get_all_products_controller.dart';
import 'package:whitematrix_groupa_shopping_app/controllers/home_product_controller.dart';
import 'package:whitematrix_groupa_shopping_app/controllers/ordercontrollers.dart';
import 'package:whitematrix_groupa_shopping_app/controllers/product_details_controller.dart';
import 'package:whitematrix_groupa_shopping_app/dummydb.dart';
import 'package:whitematrix_groupa_shopping_app/views/splash/splash_screen.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => BottomNavBarController()),
    ChangeNotifierProvider(
        create: (_) => HomeProductController()..fetchInitialData()),
    ChangeNotifierProvider(create: (_) => ProductProvider()),
    ChangeNotifierProvider(create: (context) => CartProvider()),
    ChangeNotifierProvider(create: (context) => offersdb()),
    ChangeNotifierProvider(create: (context) => OrderProvider()),
    ChangeNotifierProvider(create: (context) => GetAllProductsController()),
    ChangeNotifierProvider(create: (context) => Dummydb()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        // theme: ThemeData(
        //   tooltipTheme: TooltipThemeData(
        //     decoration: BoxDecoration(
        //       color: Colors.black87,
        //       borderRadius: BorderRadius.circular(4),
        //     ),
        //     textStyle: const TextStyle(color: Colors.white),
        //     waitDuration: Duration(milliseconds: 500),
        //     showDuration: Duration(seconds: 4),
        //   ),
        // ),
        home: SplashScreen());
  }
}
