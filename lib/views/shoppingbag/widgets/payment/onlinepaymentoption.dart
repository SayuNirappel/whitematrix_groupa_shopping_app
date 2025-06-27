import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whitematrix_groupa_shopping_app/controllers/cartcontroller.dart';
import 'package:whitematrix_groupa_shopping_app/views/orderconfirmation/orderconfirmationscreen.dart';



class OnlinePaymentOption extends StatefulWidget {
      final String userId;
  final String bearerToken;

  final Map<String, dynamic> shippingAddress;
    final double totalMRP;
  final double discountMRP;
  final double totalAmount;
  final int itemCount;
  final List<String> selectedItemImages;
  final List<Map<String, dynamic>> selectedProducts;

  const OnlinePaymentOption({
    super.key,
    required this.shippingAddress,
     required this.userId,
    required this.bearerToken,
    required this.totalMRP,
    required this.discountMRP,
    required this.totalAmount,
    required this.itemCount,
    required this.selectedItemImages,
    required this.selectedProducts,
  });
  @override
  _OnlinePaymentOptionState createState() => _OnlinePaymentOptionState();
}

class _OnlinePaymentOptionState extends State<OnlinePaymentOption> {

   bool isLoading = false;

  String? expandedSection; // Keeps track of expanded tile
  String? selectedUpiOption;
  String? selectedNetBankOption;

  final Map<String, double> paymentAmounts = {
    'Google Pay': 1334.0,
    'Paytm': 1334.0,
    'Enter UPI ID': 1334.0,
    'HDFC Bank': 1334.0,
    'Axis Bank': 1334.0,
    'ICICI Bank': 1334.0,
    'Kotak Bank': 1334.0,
    'SBI': 1334.0,
  };

  Widget buildSubOptionTile({
    required String value,
    required String label,
    required String image,
    required String groupValue,
    required Function(String?) onChanged,
  }) {
    final isSelected = groupValue == value;
    return Column(
      children: [
        ListTile(
          leading: Radio<String>(
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
          ),
          title: Row(
            children: [
              Image.asset(image, width: 30, height: 30),
              SizedBox(width: 10),
              Text(label, style: TextStyle(fontSize: 13.5)),
            ],
          ),
          onTap: () => onChanged(isSelected ? null : value),
        ),
        if (isSelected)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SizedBox(
              width: double.infinity,
              child:
              isLoading
                    ? const Center(child: CircularProgressIndicator())
                    :  ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFF3D57),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
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
                          print('📋 Placing order with:');
                          print('User ID: ${widget.userId}');
                          print('Token: ${widget.bearerToken}');
                          print('Items: ${widget.selectedProducts}');
                          print('Shipping Address: ${widget.shippingAddress}');
                          print('Total Amount: ${widget.totalAmount}');

                          setState(() => isLoading = true);
                          final cartProvider = Provider.of<CartProvider>(context, listen: false);
                          final success = await cartProvider.placeOrder(
                            userId: widget.userId,
                            items: widget.selectedProducts,
                            shippingAddress: widget.shippingAddress,
                            cartTotal: widget.totalAmount,
                            paymentMethod: "UPI",
                            token: widget.bearerToken,
                          );

                          setState(() => isLoading = false);

                          // Navigate to OrderConfirmationScreen only if successful
                          if (success) {
                            Navigator.pushReplacement
                            (
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
                                content: Text(cartProvider.couponMessage ?? 'Failed to place order'),
                                backgroundColor: Colors.red,
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          }
                        },
                child: Text(
                  'Pay with $value',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          )
      ],
    );
  }

  Widget buildPaymentTile({
    required String sectionKey,
    required Widget leading,
    String? title,
    Widget? titleWidget,
    String? offers,
    required List<Widget> children,
  }) {
    final isExpanded = expandedSection == sectionKey;

    return ExpansionTile(
      key: Key(sectionKey), // force rebuild
      initiallyExpanded: isExpanded,
      leading: leading,
      onExpansionChanged: (expanded) {
        setState(() {
          expandedSection = expanded ? sectionKey : null;
        });
      },
      title: titleWidget ??
          Row(
            children: [
              Text(
                title ?? '',
                style: TextStyle(
                  fontSize: 13.5,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (offers != null) ...[
                SizedBox(width: 6),
                Text(
                  offers,
                  style: TextStyle(fontSize: 12.5, color: Colors.green),
                ),
              ]
            ],
          ),
      children: isExpanded ? children : [],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          buildPaymentTile(
            sectionKey: 'UPI',
            leading: Image.asset(
              'assets/images/unified-payment-interface-upi-logo-png_seeklogo-333088.webp',
              width: 24,
              height: 24,
            ),
            title: 'UPI (Pay via any App)',
            offers: '2 Offers',
            children: [
              buildSubOptionTile(
                value: 'Google Pay',
                label: 'Google Pay',
                image: 'assets/images/Google_Pay_logo_PNG_(4).png',
                groupValue: selectedUpiOption ?? '',
                onChanged: (val) {
                  setState(() => selectedUpiOption = val);
                },
              ),
              buildSubOptionTile(
                value: 'Paytm',
                label: 'Paytm 2 Offers',
                image: 'assets/images/Paytm_(3).png',
                groupValue: selectedUpiOption ?? '',
                onChanged: (val) {
                  setState(() => selectedUpiOption = val);
                },
              ),
              buildSubOptionTile(
                value: 'Enter UPI ID',
                label: 'Enter UPI ID',
                image: 'assets/images/unified-payment-interface-upi-logo-png_seeklogo-333088.webp',
                groupValue: selectedUpiOption ?? '',
                onChanged: (val) {
                  setState(() => selectedUpiOption = val);
                },
              ),
            ],
          ),
          buildPaymentTile(
            sectionKey: 'NetBanking',
            leading: Icon(Icons.account_balance),
            title: 'Net Banking',
            children: [
              buildSubOptionTile(
                value: 'HDFC Bank',
                label: 'HDFC Bank',
                image: 'assets/images/HDFC_Bank_(1).png',
                groupValue: selectedNetBankOption ?? '',
                onChanged: (val) => setState(() => selectedNetBankOption = val),
              ),
              buildSubOptionTile(
                value: 'Axis Bank',
                label: 'Axis Bank',
                image: 'assets/images/VeriSign_logo_PNG_(2).png',
                groupValue: selectedNetBankOption ?? '',
                onChanged: (val) => setState(() => selectedNetBankOption = val),
              ),
              buildSubOptionTile(
                value: 'ICICI Bank',
                label: 'ICICI Bank',
                image: 'assets/images/Bank_of_Baroda_(10).png',
                groupValue: selectedNetBankOption ?? '',
                onChanged: (val) => setState(() => selectedNetBankOption = val),
              ),
              buildSubOptionTile(
                value: 'Kotak Bank',
                label: 'Kotak Bank',
                image: 'assets/images/Zurich_logo_PNG_(1).png',
                groupValue: selectedNetBankOption ?? '',
                onChanged: (val) => setState(() => selectedNetBankOption = val),
              ),
              buildSubOptionTile(
                value: 'SBI',
                label: 'SBI',
                image: 'assets/images/SBI_logo_PNG_(4).png',
                groupValue: selectedNetBankOption ?? '',
                onChanged: (val) => setState(() => selectedNetBankOption = val),
              ),
            ],
          ),
          buildPaymentTile(
            sectionKey: 'Card',
            leading: Icon(Icons.credit_card),
            title: 'Credit/Debit Card',
            offers: '5 Offers',
            children: [],
          ),
          buildPaymentTile(
            sectionKey: 'PayIn3',
            leading: Icon(Icons.payments),
            titleWidget: Row(
              children: [
                Text('Pay in 3',
                    style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.bold)),
                SizedBox(width: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Color(0xFFFF3D57),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text('NEW', style: TextStyle(fontSize: 10, color: Colors.white)),
                ),
              ],
            ),
            children: [],
          ),
          buildPaymentTile(
            sectionKey: 'PayLater',
            leading: Icon(Icons.schedule),
            title: 'Pay Later',
            children: [],
          ),
          buildPaymentTile(
            sectionKey: 'Wallet',
            leading: Icon(Icons.account_balance_wallet),
            title: 'Wallets',
            offers: '1 Offer',
            children: [],
          ),
          buildPaymentTile(
            sectionKey: 'EMI',
            leading: Icon(Icons.money),
            title: 'EMI',
            children: [],
          ),
        ],
      ),
    );
  }
}
