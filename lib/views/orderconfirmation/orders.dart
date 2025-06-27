import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:whitematrix_groupa_shopping_app/controllers/ordercontrollers.dart';
import 'package:whitematrix_groupa_shopping_app/services/api/api_constants.dart';
import 'package:whitematrix_groupa_shopping_app/views/orderconfirmation/dummydb.dart';
import 'package:whitematrix_groupa_shopping_app/views/orderconfirmation/orderdetails.dart';
import 'package:whitematrix_groupa_shopping_app/views/shoppingbag/shoppingbag.dart';


class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  String? selectedStatus;
  String? selectedTime;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OrderProvider>().fetchUserOrders(
        userId: ApiConstants.userID.toString(),
        token: null,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var orderProvider = context.watch<OrderProvider>();

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: () {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Shoppingbag2(userIdddd: ApiConstants.userID.toString(), BearerToken:ApiConstants.token.toString() ),),
          (Route<dynamic> route) => false,);
        }, icon: Icon(Icons.arrow_back)),
        title: Text(
          'My Orders',
          style: GoogleFonts.roboto(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        
      ),
      body: orderProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : orderProvider.errorMessage != null
              ? Center(child: Text(orderProvider.errorMessage!))
              : orderProvider.orders.isEmpty
                  ? const Center(child: Text('No orders found'))
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          _buildHeader(),
                          _buildSearchAndFilter(context),
                          const SizedBox(height: 10),
                          _buildFrequentlyBoughtSection(),
                          _buildOrdersList(orderProvider),
                          const SizedBox(height: 40),
                          Text(
                            "You have reached the end of your orders",
                            style: GoogleFonts.roboto(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color.fromARGB(255, 198, 186, 246), Color(0xFFffc1d5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      height: 75,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "MYNTRA INSIDER",
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "Earn 10 supercoins for every ₹100 purchase",
                  style: GoogleFonts.roboto(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            Container(
              height: 50,
              width: 80,
              decoration: BoxDecoration(
                color: const Color(0xFFff3f6c),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  "Enroll \n Now",
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchAndFilter(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 280,
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Search in orders",
                  prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                ),
              ),
            ),
            Container(
              width: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black, width: 1),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.filter_list, color: Colors.grey[600]),
                    onPressed: () {
                      _showFilterBottomSheet(context);
                    },
                  ),
                  Text(
                    "FILTER",
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFrequentlyBoughtSection() {
    return Container(
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.blue[50],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Frequently bought together",
              style: GoogleFonts.roboto(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  3,
                  (index) => Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Container(
                      height: 95,
                      width: 250,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey, width: 1),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              color: Colors.transparent,
                              child: Image.asset(Dummydb33().sp[index]),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Park Avenue",
                                  style: GoogleFonts.roboto(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "body spray",
                                  style: GoogleFonts.roboto(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "₹299",
                                      style: GoogleFonts.roboto(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[600],
                                        textStyle: const TextStyle(
                                          decoration: TextDecoration.lineThrough,
                                          decorationThickness: 2.0,
                                          decorationStyle:
                                              TextDecorationStyle.solid,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      "₹99",
                                      style: GoogleFonts.roboto(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      "56 OFF",
                                      style: GoogleFonts.roboto(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orangeAccent,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Text(
                                    "100-150gm",
                                    style: GoogleFonts.roboto(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrdersList(OrderProvider orderProvider) {
   var orders = List<Map<String, dynamic>>.from(orderProvider.orders);
orders.sort((a, b) {
  try {
    final aDate = DateTime.parse(a['placedAt']);
    final bDate = DateTime.parse(b['placedAt']);
    return bDate.compareTo(aDate); // Descending order
  } catch (e) {
    print("Error parsing placedAt: $e");
    return 0;
  }
});



    if (selectedStatus != null && selectedStatus != "All") {
      orders = orders.where((order) => order['status'] == selectedStatus).toList();
    }

    if (selectedTime != null && selectedTime != "Anytime") {
      DateTime now = DateTime.now();
      DateTime cutoffDate;
      switch (selectedTime) {
        case "Last 30 days":
          cutoffDate = now.subtract(const Duration(days: 30));
          break;
        case "Last 6 months":
          cutoffDate = now.subtract(const Duration(days: 180));
          break;
        case "Last year":
          cutoffDate = now.subtract(const Duration(days: 365));
          break;
        default:
          cutoffDate = now;
      }
      orders = orders.where((order) {
        try {
          final placedAt = DateTime.parse(order['placedAt']);
          return placedAt.isAfter(cutoffDate);
        } catch (e) {
          print("Error parsing placedAt: $e");
          return false;
        }
      }).toList();
    }

    if (orders.isEmpty) {
      return const Center(child: Text('No orders match the selected filters'));
    }

    return Column(
      children: List.generate(
        orders.length,
        (index) {
          final order = orders[index];
          final item = order['items'] != null && (order['items'] as List).isNotEmpty
              ? order['items'][0]
              : null;

          if (item == null) return const SizedBox.shrink();

          return Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Container(
              height: 310,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/images/received-delivery-2063559-1741238.webp",
                            height: 30,
                            width: 30,
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Delivered",
                                    style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Container(
                                    height: 10,
                                    width: 2,
                                    color: Colors.grey[600],
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    order['deliveryType'] ?? 'Express',
                                    style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                order['placedAt']?.toString().substring(0, 10) ?? 'Unknown Date',
                                style: GoogleFonts.roboto(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: () {
                        Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Orderdetails(orderId: order['_id']?.toString() ?? ''),
      ),
    );

                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      item['image']?.toString() ?? '',
                                      height: 70,
                                      width: 70,
                                      errorBuilder: (context, error, stackTrace) => Container(
                                        width: 70,
                                        height: 70,
                                        color: Colors.grey[300],
                                        child: Image.asset("assets/images/check.jpg"),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item['title']?.toString() ?? 'Unknown Brand',
                                        style: GoogleFonts.roboto(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                      item['brand']["name"]?.toString() ?? 'Unknown Item',
                                        style: GoogleFonts.roboto(
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                      Text(
                                        "Size: ${item['size']?.toString() ?? 'N/A'}",
                                        style: GoogleFonts.roboto(
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        height: 100,
                        width: double.infinity,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 30,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey[600],
                            radius: 3,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "Exchange/Return window open till ${_getReturnWindow(order['placedAt'])}",
                            style: GoogleFonts.roboto(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
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
                                    ? item['reviews'][0]['rating']?.toDouble() ?? 3.0
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
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          "Bought for",
                          style: GoogleFonts.roboto(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          order['shippingAddress']?['fullName']?.toString() ?? 'Unknown',
                          style: GoogleFonts.roboto(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  String _getReturnWindow(String? placedAt) {
    try {
      final date = DateTime.parse(placedAt ?? '');
      final returnDate = date.add(const Duration(days: 7));
      return returnDate.toString().substring(0, 10);
    } catch (e) {
      return 'Unknown';
    }
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => StatefulBuilder(
        builder: (BuildContext context, StateSetter setModalState) {
          return Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Filter Orders",
                      style: GoogleFonts.roboto(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Status",
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildFilterOption(setModalState, "All", selectedStatus),
                        _buildFilterOption(setModalState, "On the way", selectedStatus),
                        _buildFilterOption(setModalState, "Delivered", selectedStatus),
                        _buildFilterOption(setModalState, "Cancelled", selectedStatus),
                        _buildFilterOption(setModalState, "Returned", selectedStatus),
                      ],
                    ),
                    const Divider(height: 30, thickness: 1),
                    Text(
                      "Time",
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildFilterOption(setModalState, "Anytime", selectedTime),
                        _buildFilterOption(setModalState, "Last 30 days", selectedTime),
                        _buildFilterOption(setModalState, "Last 6 months", selectedTime),
                        _buildFilterOption(setModalState, "Last year", selectedTime),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Divider(height: 30, thickness: 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            setModalState(() {
                              selectedStatus = null;
                              selectedTime = null;
                            });
                            setState(() {});
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey, width: 1),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "CLEAR FILTERS",
                                style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {});
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.pink,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  "APPLY",
                                  style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFilterOption(StateSetter setModalState, String option, String? selectedValue) {
    return InkWell(
      onTap: () {
        setModalState(() {
          if (option == "All" ||
              option == "On the way" ||
              option == "Delivered" ||
              option == "Cancelled" ||
              option == "Returned") {
            selectedStatus = option;
          } else {
            selectedTime = option;
          }
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Icon(
              (selectedValue == option)
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
              color: (selectedValue == option) ? Colors.blue : Colors.grey,
            ),
            const SizedBox(width: 10),
            Text(
              option,
              style: GoogleFonts.roboto(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}