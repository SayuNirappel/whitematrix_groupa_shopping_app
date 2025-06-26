import 'package:flutter/material.dart';
import 'package:whitematrix_groupa_shopping_app/services/api/api_constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("My Profile"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, size: 40, color: Colors.white),
                ),
                const SizedBox(height: 10),
                Text(
                  "User ID: ${ApiConstants.userID ?? "Not Available"}",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 5),
                Tooltip(
                  message: ApiConstants.token ?? "No token available",
                  child: Text(
                    "Token: ${ApiConstants.token != null ? 'Available' : 'Not Available'}",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          buildTile(context, Icons.shopping_bag, "Orders"),
          buildTile(context, Icons.favorite_border, "Wishlist"),
          buildTile(context, Icons.logout, "Logout"),
        ],
      ),
    );
  }

  Widget buildTile(BuildContext context, IconData icon, String title) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(icon, color: Colors.black),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
