import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whitematrix_groupa_shopping_app/dummydb.dart';
import 'package:whitematrix_groupa_shopping_app/views/shoppingbag/shoppingbag.dart';
import 'package:whitematrix_groupa_shopping_app/views/shoppingbag/widgets/payment/cashdelivery.dart';
import 'package:whitematrix_groupa_shopping_app/views/shoppingbag/widgets/payment/onlinepaymentoption.dart';

class Paymentpage extends StatefulWidget {
   final String userId;
  final String bearerToken;
  final List<Map<String, dynamic>> selectedItems;
  final double cartTotal;
  final Map<String, dynamic> shippingAddress;
  final int itemCount;

  final double totalMRP;
  final double discountMRP;// New parameter

  const Paymentpage({
     super.key,
    required this.userId,
    required this.bearerToken,
    required this.selectedItems,
    required this.cartTotal,
    required this.shippingAddress,
    required this.itemCount,
  
    required this.totalMRP,
    required this.discountMRP,
  });

  @override
  State<Paymentpage> createState() => _PaymentpageState();
}

class _PaymentpageState extends State<Paymentpage> {
   final PageController _pageController = PageController(viewportFraction: 0.9);
   int _currentIndex=0;
    final List<String> _logos = [
    'assets/images/HDFC_Bank_(1).png',
    'assets/images/HDFC_Bank_(1).png',
    'assets/images/Paytm_(3).png',
    'assets/images/Myntra_logo_PNG_(1).png',
  ];
    bool isCashOnDeliverySelected = false; 
    @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  double get calculatedTotalAmount {
    return isCashOnDeliverySelected ? widget.cartTotal + 10 : widget.cartTotal;
  }

  //   double get calculatedTotalAmount {
  //   return isCashOnDeliverySelected ? widget.totalAmount + 10 : widget.totalAmount;
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PAYMENT",
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.bold
        ),),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
           const ShoppingProgressIndicator(currentStep: 2),
           Container(
          height: 21,
          color: const Color.fromARGB(255, 246, 244, 244),
        ),
         // Offers Section
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Logos and Offers Text
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
                        radius: 9,
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage(logo),
                      ),
                    ),
                  )),
                  const Spacer(),
                  const Text(
                    "+12 Offers",
                    style: TextStyle(
                      color: Color(0xFFFF3D57),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  Icon(Icons.keyboard_arrow_right,
                      color: Color(0xFFFF3D57), size: 18),
                ],
              ),
              const SizedBox(height: 10),
        
              // Scrollable Cards
                // Scrollable Cards
          Consumer<offersdb>(
    builder: (context, offerprovider, child) {
         final offerlists = offerprovider.bankoffer;
       
      return SizedBox(
              height: 61,
              child: 
                 PageView.builder(
                  controller: _pageController,
                  itemCount: offerlists.length,
                  onPageChanged: (index) {
                    setState(() {
            _currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    final offer = offerlists[index];
                    return SizedBox(
            width: MediaQuery.of(context).size.width * 1, 
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Image.asset(
                    offer["image1"],
                    width: 30,
                    height: 30,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                        SizedBox(height: 7),
                        Text(
                            offer["discount"] ?? '',
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                        SizedBox(height: 3),
                        Text(
                          offer["bankdetails"] ?? '',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
                    );
                  },
                )
            
              );
    }
       
),
             SizedBox(height: 27),

            // Dots Indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(13, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: 4.5,
                  height: 4.5,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == index
                        ? Colors.grey.shade800
                        : Colors.grey.shade300,
                  ),
                );
              }),
            ),
            const SizedBox(height: 7),
          ],
        ),
      ),
        Container(
          padding: EdgeInsets.all(10),
          height: 39,
          color: const Color.fromARGB(255, 246, 244, 244),
          child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
         
            children: [
              Center(child: Text("RECOMMENDED PAYMENT OPTION",style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontSize: 12
              ),)),
            ],
          ),
        ),
        // payment option cash on delivery
     PaymentOptionCard(
              totalMRP: widget.totalMRP,
              discountMRP: widget.discountMRP,
              totalAmount: calculatedTotalAmount,
              itemCount: widget.itemCount,
         
              selectedProducts: widget.selectedItems,
              isSelected: isCashOnDeliverySelected,
              onSelectionChanged: (value) {
                setState(() {
                  isCashOnDeliverySelected = value;
                });
              }, userId: widget.userId,
              bearerToken: widget.bearerToken, shippingAddress: widget.shippingAddress,
            ),
        
        
         Container(
          padding: EdgeInsets.all(10),
          height: 39,
          color: const Color.fromARGB(255, 246, 244, 244),
          child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
         
            children: [
              Center(child: Text("ONLINE PAYMENT OPTIONS",style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontSize: 12
              ),)),
            ],
          ),
        ),
        
        OnlinePaymentOption(
              totalMRP: widget.totalMRP,
              discountMRP: widget.discountMRP,
              totalAmount: widget.cartTotal,
              itemCount: widget.itemCount,    
              selectedProducts: widget.selectedItems,
              userId: widget.userId,
              bearerToken: widget.bearerToken, shippingAddress: widget.shippingAddress,
            ),
        Container(
          padding: EdgeInsets.all(10),
          height: 39,
          color: const Color.fromARGB(255, 246, 244, 244),
          child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
         
            children: [
              Center(child: Text("PAY ON DELIVERY OPTION",style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontSize: 12
              ),)),
            ],
          ),
        ),
        
        //  payment option cash on delivery
      PaymentOptionCard(
              totalMRP: widget.totalMRP,
              discountMRP: widget.discountMRP,
              totalAmount: calculatedTotalAmount,
              itemCount: widget.itemCount,
           
              selectedProducts: widget.selectedItems,
              isSelected: isCashOnDeliverySelected,
              onSelectionChanged: (value) {
                setState(() {
                  isCashOnDeliverySelected = value;
                });
              }, userId: widget.userId,
              bearerToken: widget.bearerToken, shippingAddress: widget.shippingAddress,
            ),

          Container(
          height: 16,
          color: const Color.fromARGB(255, 246, 244, 244),
        ),
        
        Container(
        padding: EdgeInsets.all(10),
        height: 55,
        color: Colors.white,
        child: Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
        
     
          children: [
            SizedBox(width: 7,),
            Icon(Icons.card_giftcard_outlined,size: 20,color: Colors.black87,),
            SizedBox(width: 10,),
            Text("Have a Gift Card?",style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 13.7
            ),),
            Spacer(),
          Text("Apply",style: TextStyle(
              color: const Color(0xFFFF3D57),
              fontWeight: FontWeight.bold,
              fontSize: 12.5
            ),)
          ],
        ),
      ),
        
          Container(
          height: 16,
          color: const Color.fromARGB(255, 246, 244, 244),
        ),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
        // Title
        Text(
          "PRICE DETAILS (${widget.itemCount} Item${widget.itemCount != 1 ? 's' : ''})",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12.2,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 10),
        Container(height: 1, color: Colors.black12), // horizontal line
        SizedBox(height: 10),
        
        // Total MRP
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Total MRP", style: TextStyle(fontSize: 12.7)),
            Text("₹${widget.totalMRP.toInt()}", style: TextStyle(fontSize: 12.7)),
          ],
        ),
        SizedBox(height: 8),
        
        // Discount
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Discount on MRP", style: TextStyle(fontSize: 12.7)),
            Text(
              "- ₹${widget.discountMRP.toInt()}",
              style: TextStyle(fontSize: 12.7, color: Colors.green),
            ),
          ],
        ),
        SizedBox(height: 8),
        
        // Platform Fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text("Platform Fee", style: TextStyle(fontSize: 12.7)),
                SizedBox(width: 5),
                Text(
                  "Know More",
                  style: TextStyle(
                    fontSize: 12.7,
                    color: Colors.pink,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Text("₹20", style: TextStyle(fontSize: 12.7)),
          ],
        ),
        SizedBox(height: 8),
        
        // COD Fee (visible only if selected)
                  if (isCashOnDeliverySelected)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text("Cash/Pay on Delivery Fee", style: TextStyle(fontSize: 12.7)),
                SizedBox(width: 5),
                Text(
                  "Know More",
                  style: TextStyle(
                    fontSize: 12.2,
                    color: Colors.pink,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Text("₹10", style: TextStyle(fontSize: 12.7)),
          ],
        ),
        SizedBox(height: 10),
        Container(height: 1, color: Colors.black12), // line before total
        SizedBox(height: 10),
        
        // Total Amount
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total Amount",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              "${calculatedTotalAmount.toInt()}",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
            ],
          ),
        ),
      Container(
  height: 90,
  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
  color: const Color.fromARGB(255, 246, 244, 244),
  child: Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: RichText(
          text: TextSpan(
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 13.1,
            ),
            children: [
              const TextSpan(
                text: "By placing the order, you agree to Myntra's ",
              ),
              TextSpan(
                text: "Terms of Use",
                style: const TextStyle(
                  color: Color(0xFFFF3D57),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const TextSpan(text: " and "),
              TextSpan(
                text: "Privacy Policy",
                style: const TextStyle(
                  color: Color(0xFFFF3D57),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
        ),
      ),
    ],
  ),
)


        
          ],
        ),
      ),
    );
  }
}

  //  PaymentOptionCard(
  //             totalMRP: widget.totalMRP,
  //             discountMRP: widget.discountMRP,
  //             totalAmount: calculatedTotalAmount,
  //             itemCount: widget.itemCount,
  //             selectedItemImages: widget.selectedItemImages,
  //             selectedProducts: widget.selectedItems,
  //             isSelected: isCashOnDeliverySelected,
  //             onSelectionChanged: (value) {
  //               setState(() {
  //                 isCashOnDeliverySelected = value;
  //               });
  //             },
  //           ),
            // OnlinePaymentOption(
            //   totalMRP: widget.totalMRP,
            //   discountMRP: widget.discountMRP,
            //   totalAmount: widget.cartTotal,
            //   itemCount: widget.itemCount,
            //   selectedItemImages: widget.selectedItemImages,
            //   selectedProducts: widget.selectedItems,
            // ),
           