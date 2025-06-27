import 'package:flutter/material.dart';
import 'package:whitematrix_groupa_shopping_app/views/orderconfirmation/orderconfirmationscreen.dart';

class PaymentOptionCard extends StatefulWidget {
  final double totalMRP;
  final double discountMRP;
  final double totalAmount;
  final int itemCount;
  final List<String> selectedItemImages;
  final List<Map<String, dynamic>> selectedProducts;

  final bool isSelected;
  final Function(bool) onSelectionChanged;

  const PaymentOptionCard({
    super.key,
    required this.isSelected,
    required this.onSelectionChanged,
    required this.totalMRP,
    required this.discountMRP,
    required this.totalAmount,
    required this.itemCount,
    required this.selectedItemImages,
    required this.selectedProducts,
  });

  @override
  State<PaymentOptionCard> createState() => _PaymentOptionCardState();
}

class _PaymentOptionCardState extends State<PaymentOptionCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.onSelectionChanged(!widget.isSelected);
        });
      },
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Header Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Circle
                SizedBox(
                  width: 7,
                ),
                Container(
                  width: 13.8,
                  height: 13.8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: widget.isSelected
                          ? const Color(0xFFFF3D57)
                          : Colors.black,
                      width: 1,
                    ),
                  ),
                  child: widget.isSelected
                      ? Center(
                          child: Container(
                            width: 7.8,
                            height: 7.8,
                            decoration: const BoxDecoration(
                              color: const Color(0xFFFF3D57),
                              shape: BoxShape.circle,
                            ),
                          ),
                        )
                      : null,
                ),
                const SizedBox(width: 10),

                // Title
                Expanded(
                  child: Text(
                    "Cash on Delivery (Cash/UPI)",
                    style: const TextStyle(
                      fontSize: 13.3,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),

                // ₹ Icon in circle
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: const Center(
                    child: Icon(Icons.currency_rupee_outlined, size: 16),
                  ),
                ),
              ],
            ),

            /// Dropdown Description
            if (widget.isSelected) ...[
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 23),
                child: SizedBox(
                  child: const Text(
                    "For this option, there is a fee of ₹ 10. You can Pay online to avoid this.",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Place Order Button
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    // handle order
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderConfirmationScreen(
                          totalMRP: widget.totalMRP,
                          discountMRP: widget.discountMRP,
                          totalAmount: widget
                              .totalAmount, // Use calculated total with COD fee
                          itemCount: widget.itemCount,
                          selectedItemImages: widget.selectedItemImages,
                          selectedProducts: widget.selectedProducts,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF3D57),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Place Order",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              )
            ]
          ],
        ),
      ),
    );
  }
}
