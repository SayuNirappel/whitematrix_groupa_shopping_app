import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whitematrix_groupa_shopping_app/controllers/bottom_nav_bar_controller.dart';
<<<<<<< HEAD
import 'package:whitematrix_groupa_shopping_app/controllers/cartcontroller.dart';
import 'package:whitematrix_groupa_shopping_app/controllers/get_all_products_controller.dart';
import 'package:whitematrix_groupa_shopping_app/controllers/product_details_controller.dart';
import 'package:whitematrix_groupa_shopping_app/dummydb.dart';
=======
import 'package:whitematrix_groupa_shopping_app/controllers/product_provider.dart';
>>>>>>> auth_with_token
import 'package:whitematrix_groupa_shopping_app/views/splash/splash_screen.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => BottomNavBarController()),
    ChangeNotifierProvider(create: (_) => ProductProvider()..fetchInitialData())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Dummydb(),),
        ChangeNotifierProvider(create: (context) =>CartProvider(),),
        ChangeNotifierProvider(create: (context) =>offersdb(),),
        ChangeNotifierProvider(create: (context) => GetAllProductsController()),
        ChangeNotifierProvider(create: (context) => ProductProvider())

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen()),
    );
=======
    return MaterialApp(
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
>>>>>>> auth_with_token
  }
}
