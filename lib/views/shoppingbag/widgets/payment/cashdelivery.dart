import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whitematrix_groupa_shopping_app/controllers/cartcontroller.dart';
import 'package:whitematrix_groupa_shopping_app/services/api/api_constants.dart';
import 'package:whitematrix_groupa_shopping_app/views/orderconfirmation/orderconfirmationscreen.dart';

class PaymentOptionCard extends StatefulWidget {
  final String userId;
  final String bearerToken;

  final Map<String, dynamic> shippingAddress;
  final double totalMRP;
  final double discountMRP;
  final double totalAmount;
  final int itemCount;
 
  final List<Map<String, dynamic>> selectedProducts;

  final bool isSelected;
  final Function(bool) onSelectionChanged;

  const PaymentOptionCard({
    super.key,
    required this.userId,
    required this.bearerToken,
    required this.shippingAddress,
    required this.isSelected,
    required this.onSelectionChanged,
    required this.totalMRP,
    required this.discountMRP,
    required this.totalAmount,
    required this.itemCount,

    required this.selectedProducts,
  });

  @override
  State<PaymentOptionCard> createState() => _PaymentOptionCardState();
}

class _PaymentOptionCardState extends State<PaymentOptionCard> {
  bool isLoading = false;

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
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: () async {
                          // Validate inputs
                          if (widget.userId.isEmpty ||
                              widget.bearerToken.isEmpty ||
                              widget.selectedProducts.isEmpty ||
                              widget.shippingAddress.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Missing required order details'),
                                backgroundColor: Colors.red,
                                duration: Duration(seconds: 2),
                              ),
                            );
                            return;
                          }

                          // Log input parameters
                          log('📋 Placing order with:');
                          log('User ID: ${widget.userId}');
                          log('Token: ${ApiConstants.token}');
                          log('Items: ${widget.selectedProducts}');
                          log('Shipping Address: ${widget.shippingAddress}');
                          log('Total Amount: ${widget.totalAmount}');

                          setState(() => isLoading = true);
                          final cartProvider =
                              Provider.of<CartProvider>(context, listen: false);
                          final success = await cartProvider.placeOrder(
                            userId: widget.userId,
                            items: widget.selectedProducts,
                            shippingAddress: widget.shippingAddress,
                            cartTotal: widget.totalAmount,
                            paymentMethod: 'COD',
                            token: ApiConstants.token.toString(),
                          );

                          setState(() => isLoading = false);

                          // Navigate to OrderConfirmationScreen only if successful
                          if (success) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OrderConfirmationScreen(
                                    // totalMRP: widget.totalMRP,
                                    // discountMRP: widget.discountMRP,
                                    // totalAmount: widget.totalAmount,
                                    // itemCount: widget.itemCount,
                                    // selectedItemImages: widget.selectedItemImages,
                                    // selectedProducts: widget.selectedProducts,
                                    ),
                              ),
                            );
                          } else {
                            // Show error message if order placement fails
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(cartProvider.couponMessage ??
                                    'Failed to place order'),
                                backgroundColor: Colors.red,
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          }
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
