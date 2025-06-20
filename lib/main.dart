import 'package:flutter/material.dart';
import 'package:whitematrix_groupa_shopping_app/views/category/category_screen.dart' show CategoryScreen;


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      home:CategoryScreen()
    );
  }
}
