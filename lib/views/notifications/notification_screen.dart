import 'package:flutter/material.dart';
import 'package:whitematrix_groupa_shopping_app/controllers/home_product_controller.dart';
import 'package:whitematrix_groupa_shopping_app/utils/constants/color_constants.dart';
import 'package:whitematrix_groupa_shopping_app/utils/constants/font_constants.dart';
import 'package:whitematrix_groupa_shopping_app/utils/constants/image_constants.dart';
import 'package:whitematrix_groupa_shopping_app/views/product_details/product_detail_screen.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications =
        context.watch<HomeProductController>().notificationList;

    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "Notifications",
        style: TextStyle(
            fontSize: FontConstants.title, fontWeight: FontWeight.w700),
      )),
      body: notifications.isEmpty
          ? const Center(child: Text("No notifications available."))
          : ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final item = notifications[index];

                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: ColorConstants.mynthraPink, width: 0.8),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white.withOpacity(
                          0.95), // use light grey or white if needed
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: AspectRatio(
                            aspectRatio: 16 /
                                9, //  replaced fixed height with aspect ratio
                            child: Image.network(
                              item["image"] ?? "",
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.network(
                                  ImageConstants.fallbackImage,
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          item["time"] ?? "",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 14),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "${item["brand"] ?? ""} • ${item["offer"] ?? ""}", // ⬅️ combined brand + offer with •
                          style: TextStyle(
                            fontSize: FontConstants.ititle,
                            color: Colors.grey.shade800,
                          ),
                          maxLines: 1, // ⬅️ ellipsis added
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 12),
                        Center(
                          child: InkWell(
                            onTap: () {
                              final id = notifications[index]["id"];
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetailsPage2(
                                    productId: id ?? "685cf800728c88a1bc918219",
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: ColorConstants.mynthraPink),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 8),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Icon(Icons.lock,
                                      size: 16,
                                      color: ColorConstants.mynthraPink),
                                  SizedBox(width: 6),
                                  Text(
                                    "SHOP NOW",
                                    style: TextStyle(
                                      fontSize: FontConstants.ititle,
                                      color: ColorConstants.mynthraPink,
                                      fontWeight: FontWeight.bold,
                                    ),
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
