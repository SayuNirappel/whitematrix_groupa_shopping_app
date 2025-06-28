import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whitematrix_groupa_shopping_app/controllers/bottom_nav_bar_controller.dart';
import 'package:whitematrix_groupa_shopping_app/controllers/home_product_controller.dart';
import 'package:whitematrix_groupa_shopping_app/controllers/product_details_controller.dart';
import 'package:whitematrix_groupa_shopping_app/views/splash/splash_screen.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => BottomNavBarController()),
    ChangeNotifierProvider(
        create: (_) => HomeProductController()..fetchInitialData()),
    ChangeNotifierProvider(create: (_) => ProductProvider())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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
  }
}
