import 'package:flutter/material.dart';
import 'package:whitematrix_groupa_shopping_app/services/api/api_constants.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(ApiConstants.token ?? "Not Available"),
      ),
    );
  }
}
