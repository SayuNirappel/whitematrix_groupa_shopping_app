import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whitematrix_groupa_shopping_app/controllers/bottom_nav_bar_controller.dart';
import 'package:whitematrix_groupa_shopping_app/views/splash/splash_screen.dart';
import 'package:whitematrix_groupa_shopping_app/views/category/category_screen.dart' show CategoryScreen;
import 'package:whitematrix_groupa_shopping_app/views/category/product_listing_screen.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => BottomNavBarController())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
title: 'Flutter Demo',
theme: ThemeData(
  primarySwatch: Colors.blue,
),
home: SplashScreen(),

    );
  }
}
