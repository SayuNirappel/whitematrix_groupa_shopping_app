import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:whitematrix_groupa_shopping_app/controllers/ordercontrollers.dart';
import 'package:whitematrix_groupa_shopping_app/services/api/api_constants.dart';
import 'package:whitematrix_groupa_shopping_app/views/orderconfirmation/deliverytracking.dart';

class OrderConfirmationScreen extends StatefulWidget {
  const OrderConfirmationScreen({Key? key}) : super(key: key);

  @override
  State<OrderConfirmationScreen> createState() =>
      _OrderConfirmationScreenState();
}

class _OrderConfirmationScreenState extends State<OrderConfirmationScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OrderProvider>().fetchUserOrders(
            userId: ApiConstants.userID.toString(),
            token: null, // Pass the actual token if available
          );
    });
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LiveTracking(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ORDER CONFIRMATION',
          style: GoogleFonts.roboto(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Consumer<OrderProvider>(
        builder: (context, orderProvider, child) {
          if (orderProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (orderProvider.errorMessage != null) {
            return Center(child: Text(orderProvider.errorMessage!));
          }

          if (orderProvider.orders.isEmpty) {
            return const Center(child: Text('No orders found'));
          }

          // Select the most recent order (assuming the last order is the latest)
          final latestOrder = orderProvider.orders.last;
          final shippingAddress = latestOrder['shippingAddress'] ?? {};

          // Format the address string
          final addressString = shippingAddress.isNotEmpty
              ? "${shippingAddress['fullName']}, ${shippingAddress['address']}, ${shippingAddress['city']}, ${shippingAddress['state']} ${shippingAddress['pincode']}"
              : "Address not available";

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  'assets/order_confirmation.json',
                  width: 200,
                  height: 200,
                  fit: BoxFit.fill,
                ),
                const SizedBox(height: 20),
                Text(
                  'Order Successful!',
                  style: GoogleFonts.roboto(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[700],
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    'Yay! Your order is received \n Your order will arrive in 30 minutes',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/location logo.png', height: 50),
                    const SizedBox(width: 10),
                    Flexible(
                      child: Text(
                        addressString,
                        style: GoogleFonts.roboto(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    const SizedBox(width: 30),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}
