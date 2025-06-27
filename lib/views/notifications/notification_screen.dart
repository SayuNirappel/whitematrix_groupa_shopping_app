import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whitematrix_groupa_shopping_app/controllers/get_all_products_controller.dart';
import 'package:whitematrix_groupa_shopping_app/models/home_dummy_db.dart';
import 'package:whitematrix_groupa_shopping_app/views/product_details/product_detail_screen.dart';
import 'package:whitematrix_groupa_shopping_app/views/testing_parameterPassing/parameter_test.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
      ),
      body: ListView.builder(
        itemCount: DummyDb.notificationList.length,
        itemBuilder: (context, index) {
          final item = DummyDb.notificationList[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFFE91E63), width: 1.2),
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              padding: EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image on top
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      item["image"]!,
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 10),
                  // Texts below image
                  Text(
                    item["time"]!,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 16),
                  ),
                  SizedBox(height: 4),
                  Text(
                    item["brand"] ?? "",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    item["offer"] ?? "",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 12),

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
