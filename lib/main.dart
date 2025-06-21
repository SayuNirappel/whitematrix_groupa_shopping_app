import 'package:flutter/material.dart';
import 'package:whitematrix_groupa_shopping_app/views/category/category_screen.dart' show CategoryScreen;
import 'package:whitematrix_groupa_shopping_app/views/category/product_listing_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:CategoryScreen()
    );
  }
}
