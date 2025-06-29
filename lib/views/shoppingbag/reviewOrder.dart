import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:whitematrix_groupa_shopping_app/controllers/cartcontroller.dart';
import 'package:whitematrix_groupa_shopping_app/core/network/api_helper.dart';
import 'package:whitematrix_groupa_shopping_app/model/product_res_model.dart';
import 'package:whitematrix_groupa_shopping_app/views/orderconfirmation/orderconfirmationscreen.dart';
import 'package:whitematrix_groupa_shopping_app/views/shoppingbag/couponscreen.dart';
import 'package:whitematrix_groupa_shopping_app/views/shoppingbag/paymentpage.dart';

class Revieworder extends StatefulWidget {
  final String userIdddd;
  final ProductsResModel product;
  final String selectedSize;
  final String selectedSku;
  final int quantity;
  final double offerPrice;
  final String formattedDate;
  final String bearerToken;
  final String totalprice;
  final String image;

  const Revieworder({
    super.key,
    required this.userIdddd,
    required this.product,
    required this.selectedSize,
    required this.selectedSku,
    required this.quantity,
    required this.offerPrice,
    required this.formattedDate,
    required this.bearerToken,
    required this.totalprice,
    required this.image,
  });

  @override
  State<Revieworder> createState() => _RevieworderState();
}

class _RevieworderState extends State<Revieworder> {
  String selectedPayment = "Cash on delivery(Cash/UPI)";
  bool isLoading = false;
  List<Map<String, dynamic>> productssss = [];

void _showPaymentOptionsBottomSheet() {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Row(
              children: [
                Text("Payment method",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18)),
              ],
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.money),
              title: const Text("Cash on delivery(Cash/UPI)"),
              subtitle: const Text("₹10 will be charged extra for this option"),
              trailing: Radio<String>(
                value: "Cash on delivery(Cash/UPI)",
                groupValue: selectedPayment,
                onChanged: (value) {
                  setState(() {
                    selectedPayment = value!;
                  });
                  Navigator.pop(context);
                },
                activeColor: Colors.pink,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.account_balance_wallet),
              title: const Text("Other payment options"),
              subtitle: const Text("Wallets/Pay later/EMI/Net banking"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // Calculate discount here or pass it as a parameter
                double totalPrice = double.tryParse(widget.totalprice) ?? 0.0;
                double offerPrice = widget.offerPrice;
                double discount = totalPrice - offerPrice;

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Paymentpage(
                      userId: widget.userIdddd,
                      bearerToken: widget.bearerToken,
                      selectedItems: productssss,
                      cartTotal: _calculateTotalAmount()-10,
                      shippingAddress: selectedAddress!,
                      itemCount: 1,
                 
                      totalMRP: totalPrice,
                      discountMRP: discount),
                    ),
                  
                );
              },
            ),
          ],
        ),
      );
    },
  );
}
  @override
  void initState() {
    super.initState();
    // Initialize product list
    productssss = [
      {
        "productId": widget.product.id,
        "quantity": widget.quantity,
        "variantSKU": widget.selectedSku,
        "totalAmount": _calculateTotalAmount().toInt(),
      }
    ];

    selectedAddress = {
      'fullName': 'customer',
      'pincode': '680662',
      'locality': 'vellangallur',
      'city': 'irinjalakuda',
      'state': 'Kerala',
      'mobile': '1234567895',
      'address': 'houseee',
      'landmark': 'near.....',
      'alternatePhone': '7356556028',
      'addressType': 'Home',
    };
    selectedFullNamePincode = '${selectedAddress!['fullName']}, ${selectedAddress!['pincode']}';
    selectedLocalityCityState = '${selectedAddress!['locality']}, ${selectedAddress!['city']}, ${selectedAddress!['state']}';
  }

  double _calculateTotalAmount() {
    double baseTotal = widget.offerPrice * widget.quantity;
    double additionalFee = (selectedPayment.contains("Cash") ? 10.0 : 0.0);
    return baseTotal + additionalFee - couponDiscount + 20.0; // Added platform fee of 20
  }

  Map<String, dynamic>? selectedAddress;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController localityController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController landmarkController = TextEditingController();
  final TextEditingController alternatePhoneController = TextEditingController();

  String selectedFullNamePincode = 'customer B';
  String selectedLocalityCityState = 'Kerala 680662';
  double couponDiscount = 0.0;
  bool isDonationChecked = false;
  int selectedAmount = 10;
  final List<int> donationOptions = [10, 20, 50, 100];
  final List<String> _logos = [
    'assets/images/HDFC_Bank_(1).png',
    'assets/images/SBI_logo_PNG_(4).png',
    'assets/images/Paytm_(3).png',
    'assets/images/Myntra_logo_PNG_(1).png',
  ];

  @override
  Widget build(BuildContext context) {
    double totalPrice = double.tryParse(widget.totalprice) ?? 0.0;
    double offerPrice = widget.offerPrice;
    double discount = totalPrice - offerPrice;

    // Ensure image URL is valid (add base URL if relative)
    // String imageUrl = widget.image;
    // if (!widget.image.startsWith('http') && ApiHelper.baseUrl.isNotEmpty) {
    //   imageUrl = '${ApiHelper.baseUrl}${widget.image}';
    // }

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Review Order",
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14.5,
                    fontWeight: FontWeight.w600)),
            Text("You're saving ₹${discount.toInt()}",
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 14,
                    fontWeight: FontWeight.w500)),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: const Color.fromARGB(255, 246, 244, 244),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                color: const Color.fromARGB(255, 246, 244, 244),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.location_on_outlined,
                        size: 16, color: Colors.black54),
                    const SizedBox(width: 4),
                    const Text(
                      "Delivery Details",
                      style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade200),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.location_on_outlined,
                                  size: 16, color: Colors.black87),
                              const SizedBox(width: 4),
                              Flexible(
                                child: Row(
                                  children: [
                                    Text(
                                      selectedAddress != null
                                          ? selectedFullNamePincode
                                          : 'Select an address',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      selectedAddress != null
                                          ? selectedLocalityCityState
                                          : '',
                                      style: const TextStyle(
                                          fontSize: 13, color: Colors.black54),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () => _showChangeAddressSheet(
                              context,
                              widget.bearerToken,
                              widget.userIdddd,
                              (selectedAddress) {
                                setState(() {
                                  this.selectedAddress =
                                      Map<String, dynamic>.from(selectedAddress);
                                  selectedFullNamePincode =
                                      '${selectedAddress['fullName']}, ${selectedAddress['pincode']}';
                                  selectedLocalityCityState =
                                      '${selectedAddress['locality']}, ${selectedAddress['city']}, ${selectedAddress['state']}';
                                });
                              },
                            ),
                            child: const Text(
                              'Change Address >',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFFF3D57)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 233, 232, 232),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      height: 50,
                      width: 35,
                      child: Image.network(
                        widget.image,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          print('Image load error: $error');
                          return Image.asset(
                            'assets/images/img1.jpg',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey.shade200,
                                child: const Center(
                                  child: Text(
                                    'Image\nNot Found',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Delivery by ${widget.formattedDate}",
                          style: const TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Size: ${widget.selectedSize}",
                          style: const TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                color: const Color.fromARGB(255, 246, 244, 244),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.percent,
                        size: 16, color: Colors.black54),
                    const SizedBox(width: 4),
                    const Text(
                      "Coupons & Rewards",
                      style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Couponscreen(
                              userId: widget.userIdddd,
                              cartTotal: _calculateTotalAmount() + couponDiscount,
                            )),
                  ).then((result) {
                    if (result != null &&
                        result is Map &&
                        result.containsKey('discount')) {
                      setState(() {
                        couponDiscount = result['discount'] ?? 0.0;
                      });
                    }
                    ScaffoldMessenger.of(context).clearSnackBars();
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(10),
                  height: 46,
                  child: Row(
                    children: [
                      const Icon(Icons.tag, size: 15),
                      const SizedBox(width: 5),
                      const Text(
                        "Apply Coupon",
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                          fontSize: 13.1,
                        ),
                      ),
                      const Spacer(),
                      const Icon(Icons.keyboard_arrow_right,
                          color: Colors.black, size: 20)
                    ],
                  ),
                ),
              ),
              if (couponDiscount > 0)
                Container(
                  padding: const EdgeInsets.all(14),
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                    border: Border.all(color: Colors.greenAccent),
                  ),
                  child: Row(
                    children: [
                      Text(
                        "Saved ₹${couponDiscount.toInt()}",
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            couponDiscount = 0.0;
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Coupon removed"),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          });
                        },
                        child: const Text(
                          "remove",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                color: const Color.fromARGB(255, 246, 244, 244),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.single_bed,
                        size: 16, color: Colors.black54),
                    const SizedBox(width: 4),
                    const Text(
                      "Bank Offers",
                      style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ..._logos.map((logo) => Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.grey.shade300),
                                ),
                                child: CircleAvatar(
                                  radius: 8,
                                  backgroundColor: Colors.white,
                                  backgroundImage: AssetImage(logo),
                                ),
                              ),
                            )),
                        const Spacer(),
                        const Text(
                          "+19 Offers",
                          style: TextStyle(
                            color: Color(0xFFFF3D57),
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        const Icon(Icons.keyboard_arrow_right,
                            color: Color(0xFFFF3D57), size: 18),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 239, 234, 247),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Row(
                  children: [
                    const Text(
                      "7.5% Assured Cashback",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 12.5,
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      "Recommended offer",
                      style: TextStyle(
                        color: Color.fromARGB(255, 175, 148, 229),
                        fontWeight: FontWeight.w600,
                        fontSize: 12.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                color: const Color.fromARGB(255, 246, 244, 244),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.details,
                        size: 16, color: Colors.black54),
                    const SizedBox(width: 4),
                    const Text(
                      "Price details",
                      style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Total price",
                          style: TextStyle(fontSize: 12.7),
                        ),
                        Text(
                          "₹${totalPrice.toInt()}",
                          style: const TextStyle(fontSize: 12.7),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Discount on MRP",
                            style: TextStyle(fontSize: 12.7)),
                        Text(
                          "₹${discount.toInt()}",
                          style: TextStyle(fontSize: 12.7, color: Colors.green),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Coupon Discount",
                            style: TextStyle(fontSize: 12.7)),
                        Text(
                          couponDiscount > 0
                              ? "- ₹${couponDiscount.toInt()}"
                              : "Apply Coupon",
                          style:
                              const TextStyle(fontSize: 12.7, color: Colors.pink),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Text("Platform Fee",
                                style: TextStyle(fontSize: 12.7)),
                            const SizedBox(width: 4),
                            const Text("Know More",
                                style:
                                    TextStyle(fontSize: 12.7, color: Colors.pink)),
                          ],
                        ),
                        const Text(
                          "₹20",
                          style: TextStyle(fontSize: 12.7),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Text("Cash/Pay on Delivery Fee",
                                style: TextStyle(fontSize: 12.7)),
                            const SizedBox(width: 5),
                            const Text(
                              "Know More",
                              style: TextStyle(
                                fontSize: 12.2,
                                color: Colors.pink,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const Text("₹10", style: TextStyle(fontSize: 12.7)),
                      ],
                    ),
                    const Divider(
                        height: 24, thickness: 1, color: Colors.black12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Total Amount",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Text(
                          "₹${_calculateTotalAmount().toInt()}",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFE6F4EA), Color(0xFFF3FAF5)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.green,
                      radius: 8,
                      child: Icon(Icons.percent,
                          color: Colors.white, size: 11),
                    ),
                    const SizedBox(width: 8),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                            fontSize: 14, color: Color(0xFF202124)),
                        children: [
                          const TextSpan(text: "You're saving "),
                          TextSpan(
                            text: '₹${discount.toInt()}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.8,
                              color: Color(0xFF0F9D58),
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
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 4.0),
                    child: Icon(Icons.money, size: 28),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          selectedPayment,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 13),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "₹10 is applied extra for this option.",
                          style:
                              TextStyle(color: Colors.grey[600], fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: _showPaymentOptionsBottomSheet,
                    child: const Padding(
                      padding: EdgeInsets.only(top: 4.0),
                      child: Text(
                        "Change",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.pink,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  minimumSize: const Size(double.infinity, 48),
                ),
                onPressed: isLoading
                    ? null
                    : () async {
                        if (widget.userIdddd.isEmpty ||
                            widget.bearerToken.isEmpty ||
                            productssss.isEmpty ||
                            selectedAddress == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Missing required order details'),
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 2),
                            ),
                          );
                          return;
                        }

                        print('📋 Placing order with:');
                        print('User ID: ${widget.userIdddd}');
                        print('Token: ${widget.bearerToken}');
                        print('Items: $productssss');
                        print('Shipping Address: $selectedAddress');
                        print('Total Amount: ${_calculateTotalAmount().toInt()}');

                        setState(() => isLoading = true);
                        final cartProvider =
                            Provider.of<CartProvider>(context, listen: false);
                        final success = await cartProvider.placeOrder(
                          userId: widget.userIdddd,
                          items: productssss,
                          shippingAddress: selectedAddress!,
                          cartTotal: _calculateTotalAmount(),
                          paymentMethod: selectedPayment.contains('Cash')
                              ? 'COD'
                              : 'Other',
                          token: widget.bearerToken,
                        );

                        setState(() => isLoading = false);

                        if (success) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrderConfirmationScreen(
                          
                              ),
                            ),
                          );
                        } else {
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
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(
                        "Confirm & Place order ₹${_calculateTotalAmount().toInt()}",
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showChangeAddressSheet(BuildContext context, String token, String userId,
      Function(Map<String, dynamic>)? onAddressSelected) {
    final List<Map<String, dynamic>> savedAddresses = [];
    final List<bool> isSelected = [];
    int? selectedIndex;
    bool isLoading = true;

    void _fetchAddresses(StateSetter setModalState) async {
      final cartProvider = Provider.of<CartProvider>(context, listen: false);
      savedAddresses.addAll(await cartProvider.fetchUserAddresses(
        userId: userId,
        token: token,
      ));
      isSelected.clear();
      isSelected.addAll(List<bool>.filled(savedAddresses.length, false));
      setModalState(() {
        isLoading = false;
      });
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            if (isLoading) {
              _fetchAddresses(setModalState);
            }
            return DraggableScrollableSheet(
              initialChildSize: 0.9,
              minChildSize: 0.5,
              maxChildSize: 0.95,
              expand: false,
              builder: (_, controller) => Padding(
                padding: const EdgeInsets.all(16.0),
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ListView(
                        controller: controller,
                        children: [
                          const Text(
                            'Saved Addresses',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          if (savedAddresses.isNotEmpty)
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: savedAddresses.length,
                              itemBuilder: (context, index) {
                                final address = savedAddresses[index];
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 8),
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: isSelected[index]
                                          ? Colors.red
                                          : Colors.grey.shade200,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Icon(Icons.location_on_outlined,
                                          size: 16, color: Colors.black87),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  '${address['fullName']}, ${address['pincode']}',
                                                  style: const TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black87,
                                                  ),
                                                ),
                                                const Spacer(),
                                                Text(
                                                  address['addressType'],
                                                  style: const TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              '${address['locality']}, ${address['city']}, ${address['state']}',
                                              style: const TextStyle(
                                                fontSize: 13,
                                                color: Colors.black54,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              'Mob: ${address['mobile']}',
                                              style: const TextStyle(
                                                fontSize: 13,
                                                color: Colors.black54,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Checkbox(
                                            value: isSelected[index],
                                            onChanged: (value) {
                                              setModalState(() {
                                                for (int i = 0;
                                                    i < isSelected.length;
                                                    i++) {
                                                  isSelected[i] = i == index && value!;
                                                }
                                                selectedIndex = value! ? index : null;
                                              });
                                            },
                                          ),
                                          if (isSelected[index])
                                            ElevatedButton(
                                              onPressed: () {
                                                setState(() {
                                                  selectedAddress =
                                                      Map<String, dynamic>.from(address);
                                                  selectedFullNamePincode =
                                                      '${address['fullName']}, ${address['pincode']}';
                                                  selectedLocalityCityState =
                                                      '${address['locality']}, ${address['city']}, ${address['state']}';
                                                });
                                                if (onAddressSelected != null) {
                                                  onAddressSelected(address);
                                                }
                                                Navigator.pop(context);
                                              },
                                              child: const Text('Deliver Here'),
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          if (savedAddresses.isEmpty)
                            const Text(
                              'No saved addresses found.',
                              style: TextStyle(color: Colors.grey),
                            ),
                          const SizedBox(height: 16),
                          const Center(
                            child: Text(
                              'OR',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Address',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: nameController,
                            decoration: const InputDecoration(
                              labelText: 'Name',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: mobileController,
                            decoration: const InputDecoration(
                              labelText: 'Mobile',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: pincodeController,
                            decoration: const InputDecoration(
                              labelText: 'Pincode',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: localityController,
                            decoration: const InputDecoration(
                              labelText: 'Locality',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: addressController,
                            decoration: const InputDecoration(
                              labelText: 'Address',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: cityController,
                            decoration: const InputDecoration(
                              labelText: 'City',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: stateController,
                            decoration: const InputDecoration(
                              labelText: 'State',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: landmarkController,
                            decoration: const InputDecoration(
                              labelText: 'Landmark',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: alternatePhoneController,
                            decoration: const InputDecoration(
                              labelText: 'Alternate Phone Number',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          ),
                          const SizedBox(height: 12),
                          DropdownButtonFormField<String>(
                            value: 'Home',
                            decoration: const InputDecoration(
                              labelText: 'Address Type',
                              border: OutlineInputBorder(),
                            ),
                            items: ['Home', 'Work'].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {},
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () async {
                              final addressData = {
                                "fullName": nameController.text,
                                "mobile": mobileController.text,
                                "pincode": pincodeController.text,
                                "locality": localityController.text,
                                "address": addressController.text,
                                "city": cityController.text,
                                "state": stateController.text,
                                "landmark": landmarkController.text,
                                "alternatePhone": alternatePhoneController.text,
                                "addressType": "Home",
                              };

                              await Provider.of<CartProvider>(context,
                                      listen: false)
                                  .Addressupdate(
                                token: token,
                                userId: userId,
                                addressData: addressData,
                              );

                              setState(() {
                                selectedAddress = addressData;
                                selectedFullNamePincode =
                                    '${addressData['fullName']}, ${addressData['pincode']}';
                                selectedLocalityCityState =
                                    '${addressData['locality']}, ${addressData['city']}, ${addressData['state']}';
                              });
                              if (onAddressSelected != null) {
                                onAddressSelected(addressData);
                              }
                              Navigator.pop(context);
                            },
                            child: const Text('Save Address'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        }
      
    }
  