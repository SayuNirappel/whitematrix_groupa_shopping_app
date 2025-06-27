import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whitematrix_groupa_shopping_app/controllers/bottom_nav_bar_controller.dart';
import 'package:whitematrix_groupa_shopping_app/controllers/product_details_controller.dart';
import 'package:whitematrix_groupa_shopping_app/views/product_details/product_detail_screen.dart';


void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => ProductProvider())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: ProductDetailsPage2(productId:'6856dc54ef1fd537011cffa0'));
  }
}
