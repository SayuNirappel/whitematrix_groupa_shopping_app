import 'package:flutter/material.dart';
import 'package:whitematrix_groupa_shopping_app/views/shoppingbag/paymentpage.dart';
import 'package:whitematrix_groupa_shopping_app/views/shoppingbag/shoppingbag.dart';

class AddressPage extends StatefulWidget {
  final String userId;
  final String bearerToken;
  final List<Map<String, dynamic>> selectedItems;
  final double cartTotal;
  final int itemCount;
  final List<String> selectedItemImages; // Added
  final double totalMRP;
  final double discountMRP;
  final Map<String, dynamic> selectedAddress;

  const AddressPage({
    super.key,
    required this.userId,
    required this.bearerToken,
    required this.selectedItems,
    required this.cartTotal,
    required this.itemCount,
    required this.selectedItemImages, // Added
    required this.totalMRP,
    required this.discountMRP,
    required this.selectedAddress,
  });

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "ADDRESS",
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: const Color.fromARGB(255, 246, 244, 244),
      body: Column(
        children: [
          const ShoppingProgressIndicator(currentStep: 1),
          Container(
            height: 15,
            color: const Color.fromARGB(255, 246, 244, 244),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                widget.selectedAddress['fullName'] ?? 'User',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.5,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(width: 5),
                              const Text(
                                "(Default)",
                                style: TextStyle(
                                  fontSize: 13.5,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 7, vertical: 3),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.green),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  widget.selectedAddress['addressType'] ??
                                      'HOME',
                                  style: const TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '${widget.selectedAddress['address'] ?? ''}\n${widget.selectedAddress['locality'] ?? ''}, ${widget.selectedAddress['city'] ?? ''}\n${widget.selectedAddress['state'] ?? ''} ${widget.selectedAddress['pincode'] ?? ''}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 10),
                          RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.black),
                              children: [
                                const TextSpan(
                                  text: "Mobile: ",
                                  style: TextStyle(color: Colors.black54),
                                ),
                                TextSpan(
                                  text: widget.selectedAddress['mobile'] ??
                                      'Not provided',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            height: 42,
            color: const Color.fromARGB(255, 246, 244, 244),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "DELIVERY ESTIMATES",
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: widget.selectedItemImages.length,
              separatorBuilder: (context, index) => Container(
                height: 1,
                width: double.infinity,
                color: Colors.grey.shade300,
              ),
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: widget.selectedItemImages[index]
                                .startsWith('http')
                            ? Image.network(
                                widget.selectedItemImages[index],
                                width: 60,
                                height: 80,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(
                                  Icons.error,
                                  size: 60,
                                  color: Colors.grey,
                                ),
                              )
                            : Image.asset(
                                widget.selectedItemImages[index],
                                width: 60,
                                height: 80,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(
                                  Icons.error,
                                  size: 60,
                                  color: Colors.grey,
                                ),
                              ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            text: "Estimated delivery by ",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                            children: [
                              TextSpan(
                                text: "1 day",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF5F5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Paymentpage(
                        userId: widget.userId,
                        bearerToken: widget.bearerToken,
                        selectedItems: widget.selectedItems,
                        cartTotal: widget.cartTotal,
                        shippingAddress: widget.selectedAddress,
                        itemCount: widget.itemCount,
                        selectedItemImages: widget.selectedItemImages,
                        totalMRP: widget.totalMRP,
                        discountMRP: widget.discountMRP,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF3D57),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 13),
          ],
        ),
      ),
    );
  }
}






//  Container(
//         padding: EdgeInsets.all(10),
//         height: 42,
//         color: const Color.fromARGB(255, 246, 244, 244),
//         child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
       
//           children: [
//             Center(child: Text("DELIVERY ESTIMATES",style: TextStyle(
//               color: Colors.black54,
//               fontWeight: FontWeight.bold,
//               fontSize: 12
//             ),)),
//           ],
//         ),
//       ),
//       Expanded(
//         child: ListView.separated(
//           // padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//           itemCount: widget.selectedItemImages.length,
//           separatorBuilder: (context, index) => Container(
//   height: 1, // Thickness of the line
//   width: double.infinity, // Full width
//   color: Colors.grey.shade300, // Line color
// ),
//           itemBuilder: (context, index) {
        
        
//             return Container(
//               padding: EdgeInsets.all(8),
//         color: Colors.white,
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             /// Image
//               ClipRRect(
//             borderRadius: BorderRadius.circular(8),
//             child: Image.asset(
//               widget.selectedItemImages[index], // Use index to select one image
//               width: 60,
//               height: 80,
//               fit: BoxFit.cover,
//             ),
//           ),
//             SizedBox(width: 12),
        
//             /// Text
//             Expanded(
//               child: Text.rich(
//                 TextSpan(
//                   text: "Estimated delivery by ",
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: Colors.black87,
//                   ),
//                   children: [
//                     TextSpan(
//                       text: "22 Jun 2025",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black87,
//                       ),
//                     )
//                   ],
//                 ),
//                 maxLines: 2,
//               ),
//             )
//           ],
//         ),
//             );
//           },
//         ),
//       )
