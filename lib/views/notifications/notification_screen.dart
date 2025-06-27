import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:provider/provider.dart';
import 'package:whitematrix_groupa_shopping_app/controllers/get_all_products_controller.dart';
import 'package:whitematrix_groupa_shopping_app/models/home_dummy_db.dart';
import 'package:whitematrix_groupa_shopping_app/views/product_details/product_detail_screen.dart';
import 'package:whitematrix_groupa_shopping_app/views/testing_parameterPassing/parameter_test.dart';
=======
import 'package:whitematrix_groupa_shopping_app/controllers/product_provider.dart';
import 'package:whitematrix_groupa_shopping_app/views/product_details/product_detail_screen.dart';
import 'package:provider/provider.dart';
>>>>>>> auth_with_token

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = context.watch<ProductProvider>().notificationList;

<<<<<<< HEAD
                  // SHOP NOW Button
                  Center(
                    child: InkWell(
                      onTap: () {
                     final productid =   context.read<GetAllProductsController>().filteredProducts[index].id;
                        Navigator.pop(context); // pop screen 2
                        Future.delayed(Duration(milliseconds: 50), () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => 
                                ProductDetailsPage2(
                                  productId:productid
                                )
                                ),
                          );
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFFE91E63)),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.lock, color: Color(0xFFE91E63)),
                            SizedBox(width: 8),
                            Text(
                              "SHOP NOW",
                              style: TextStyle(
                                  color: Color(0xFFE91E63),
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
=======
    return Scaffold(
      appBar: AppBar(title: const Text("Notifications")),
      body: notifications.isEmpty
          ? const Center(child: Text("No notifications available."))
          : ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final item = notifications[index];

                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFE91E63), width: 1.2),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
>>>>>>> auth_with_token
                    ),
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            item["image"] ?? "",
                            height: 180,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.image),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          item["time"] ?? "",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 16),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item["brand"] ?? "",
                          style: const TextStyle(fontSize: 14),
                        ),
                        Text(
                          item["offer"] ?? "",
                          style: TextStyle(
                              fontSize: 14, color: Colors.grey.shade700),
                        ),
                        const SizedBox(height: 12),
                        Center(
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                              Future.delayed(const Duration(milliseconds: 50),
                                  () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ProductDetailsPage2(),
                                  ),
                                );
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0xFFE91E63)),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 10),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Icon(Icons.lock, color: Color(0xFFE91E63)),
                                  SizedBox(width: 8),
                                  Text(
                                    "SHOP NOW",
                                    style: TextStyle(
                                        color: Color(0xFFE91E63),
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
