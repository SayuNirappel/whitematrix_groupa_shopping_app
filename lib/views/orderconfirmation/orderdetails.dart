import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:whitematrix_groupa_shopping_app/controllers/ordercontrollers.dart';

class Orderdetails extends StatefulWidget {
  final String orderId;

  const Orderdetails({
    Key? key,
    required this.orderId,
  }) : super(key: key);

  @override
  State<Orderdetails> createState() => _OrderdetailsState();
}

class _OrderdetailsState extends State<Orderdetails> {
  @override
  Widget build(BuildContext context) {
    var orderProvider = context.watch<OrderProvider>();

    if (orderProvider.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (orderProvider.errorMessage != null) {
      return Scaffold(
        body: Center(child: Text(orderProvider.errorMessage!)),
      );
    }

    if (orderProvider.orders.isEmpty) {
      return const Scaffold(
        body: Center(child: Text('No order details found')),
      );
    }

    final order = orderProvider.orders.firstWhere(
      (o) => o['_id'] == widget.orderId,
      orElse: () => <String, dynamic>{},
    );

    if (order.isEmpty) {
      return const Scaffold(
        body: Center(child: Text('Order not found')),
      );
    }

    final item = order['items'].isNotEmpty ? order['items'][0] : null;

    if (item == null) {
      return const Scaffold(
        body: Center(child: Text('No items found for this order')),
      );
    }

    // Parse placedAt date
    DateTime placedAt;
    try {
      placedAt = DateTime.parse(order['placedAt']);
    } catch (e) {
      placedAt = DateTime.now();
    }

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Order Details',
              style: GoogleFonts.roboto(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/images/5-512.webp",
                      width: 20,
                      height: 20,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      "Help",
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 80),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  item['image'],
                  width: 150,
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 150,
                    height: 200,
                    color: Colors.grey[300],
                    child: Image.asset("assets/images/check.jpg",
                        fit: BoxFit.cover),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                item['brand']['name'],
                style: GoogleFonts.roboto(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                item['title'],
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                "Size: ${item['size']}",
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 51, 181, 118),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/received-delivery-2063559-1741238.webp",
                          height: 30,
                          width: 30,
                        ),
                        const SizedBox(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Delivered",
                              // order['status'],
                              style: GoogleFonts.roboto(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Order placed on ${placedAt.day}/${placedAt.month}/${placedAt.year}",
                              style: GoogleFonts.roboto(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 50,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey[600],
                        radius: 3,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "Exchange/Return window open till ${placedAt.add(const Duration(days: 7)).toString().substring(0, 10)}",
                        style: GoogleFonts.roboto(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                height: 67,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          StarRating(
                            size: 25.0,
                            rating: (item['reviews']?.isNotEmpty ?? false)
                                ? item['reviews'][0]['rating']?.toDouble() ??
                                    3.0
                                : 3.0,
                            color: Colors.red,
                            borderColor: Colors.grey,
                            allowHalfRating: true,
                            starCount: 5,
                            onRatingChanged: (rating) => setState(() {}),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Rate & Review",
                                style: GoogleFonts.roboto(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                "Win Myntra Credit",
                                style: GoogleFonts.roboto(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "Tell us More",
                            style: GoogleFonts.roboto(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 100,
                width: double.infinity,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Delivery Address",
                        style: GoogleFonts.roboto(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            order['shippingAddress']['fullName'],
                            style: GoogleFonts.roboto(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            height: 10,
                            width: 2,
                            color: Colors.grey[600],
                          ),
                          const SizedBox(width: 10),
                          Text(
                            order['shippingAddress']['mobile'],
                            style: GoogleFonts.roboto(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "${order['shippingAddress']['address']}, ${order['shippingAddress']['city']}, ${order['shippingAddress']['state']} ${order['shippingAddress']['pincode']}",
                        style: GoogleFonts.roboto(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 110,
                width: double.infinity,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Item Price",
                            style: GoogleFonts.roboto(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "₹${item['priceAtPurchase']}",
                                style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(width: 5),
                              InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) => Container(
                                      height: 370,
                                      width: double.infinity,
                                      color: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Payment Information",
                                                  style: GoogleFonts.roboto(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Image.network(
                                                    item['image'],
                                                    height: 70,
                                                    errorBuilder: (context,
                                                            error,
                                                            stackTrace) =>
                                                        Container(
                                                      width: 70,
                                                      height: 70,
                                                      color: Colors.grey[300],
                                                      child: Image.asset(
                                                          "assets/images/check.jpg"),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 20),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "MRP",
                                                  style: GoogleFonts.roboto(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.grey[600],
                                                  ),
                                                ),
                                                Text(
                                                  "₹${order['subtotalAmount'] + order['discountAmount']}",
                                                  style: GoogleFonts.roboto(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              height: 2,
                                              width: double.infinity,
                                              color: Colors.grey[300],
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Discount",
                                                  style: GoogleFonts.roboto(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.grey[600],
                                                  ),
                                                ),
                                                Text(
                                                  "-₹${order['discountAmount']}",
                                                  style: GoogleFonts.roboto(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            Container(
                                              height: 2,
                                              width: double.infinity,
                                              color: Colors.grey[300],
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Discounted Price",
                                                  style: GoogleFonts.roboto(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.grey[600],
                                                  ),
                                                ),
                                                Text(
                                                  "₹${order['subtotalAmount']}",
                                                  style: GoogleFonts.roboto(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            // Container(
                                            //   height: 2,
                                            //   width: double.infinity,
                                            //   color: Colors.grey[300],
                                            // ),
                                            // const SizedBox(height: 10),
                                            // Row(
                                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            //   children: [
                                            //     Text(
                                            //       "Coupon discount",
                                            //       style: GoogleFonts.roboto(
                                            //         fontSize: 16,
                                            //         fontWeight: FontWeight.bold,
                                            //         color: Colors.grey[600],
                                            //       ),
                                            //     ),
                                            //     Text(
                                            //       order['couponCode'] != null ? "-₹0" : "-₹0",
                                            //       style: GoogleFonts.roboto(
                                            //         fontSize: 16,
                                            //         fontWeight: FontWeight.bold,
                                            //         color: Colors.black,
                                            //       ),
                                            //     ),
                                            //   ],
                                            // ),
                                            // const SizedBox(height: 10),
                                            Container(
                                              height: 2,
                                              width: double.infinity,
                                              color: Colors.grey[300],
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Total Paid",
                                                  style: GoogleFonts.roboto(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.grey[600],
                                                  ),
                                                ),
                                                Text(
                                                  "₹${item['priceAtPurchase']}",
                                                  style: GoogleFonts.roboto(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            Container(
                                              height: 40,
                                              color: Colors.grey[200],
                                              width: double.infinity,
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                    "assets/images/2-512.webp",
                                                    height: 30,
                                                    width: 30,
                                                    fit: BoxFit.cover,
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Text(
                                                    order['paymentMethod'] ==
                                                            "COD"
                                                        ? "cash on delivery"
                                                        : "Online Payment",
                                                    style: GoogleFonts.roboto(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.grey[600],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ], // End of Column children
                                        ),
                                      ),
                                    ), // End of Container
                                  ); // End of showModalBottomSheet
                                }, // End of onTap
                                child: const Icon(
                                  Icons.arrow_drop_down,
                                  size: 15,
                                  color: Colors.red,
                                ),
                              ), // End of InkWell
                            ], // End of Row children
                          ), // End of Row
                        ], // End of Row children
                      ), // End of Row
                      const SizedBox(height: 10),
                      Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/images/2-512.webp",
                                height: 30,
                                width: 30,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                order['paymentMethod'] == "COD"
                                    ? "Cash on delivery"
                                    : "Online Payment",
                                style: GoogleFonts.roboto(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ), // End of Container
                    ], // End of Column children
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 100,
                width: double.infinity,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        "Sold by: Truenet Commerce",
                        style: GoogleFonts.roboto(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: 40,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey[500]!),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              "Get Invoice",
                              style: GoogleFonts.roboto(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 110,
                width: double.infinity,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Updates sent to",
                        style: GoogleFonts.roboto(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.phone, color: Colors.grey[600], size: 14),
                          const SizedBox(width: 10),
                          Text(
                            order['shippingAddress']['mobile'],
                            style: GoogleFonts.roboto(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.email_outlined,
                              color: Colors.grey[600], size: 14),
                          const SizedBox(width: 10),
                          Text(
                            "${order['shippingAddress']['fullName'].replaceAll(' ', '').toLowerCase()}@gmail.com",
                            style: GoogleFonts.roboto(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ], // End of main Column children
          ),
        ),
      ),
    ); // End of Scaffold
  } // End of build method
} // End of _OrderdetailsState
// End of Orderdetails class
