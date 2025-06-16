import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
  //  ChangeNotifierProvider(create: (_) => MyModel()),
      ],
      child: MaterialApp(
        
      ));
  }
}
