import 'package:flutter/material.dart';
import 'package:whitematrix_groupa_shopping_app/views/auth/login_screen.dart';

import 'dart:async'; // for Timer
import 'package:whitematrix_groupa_shopping_app/views/widgets/bottom_nav_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Navigate after 2 seconds
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: Center(
        child: Text(
          "M",
          style: TextStyle(
            fontSize: 100,
            fontWeight: FontWeight.bold,
            color: Color(0xFFE91E63),
          ),
        ),
      ),
    );
  }
}
