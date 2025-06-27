// import 'package:flutter/material.dart';
// import 'package:whitematrix_groupa_shopping_app/views/shoppingbag/paymentpage.dart';
// import 'package:whitematrix_groupa_shopping_app/views/shoppingbag/shoppingbag.dart';


// class Addresspage extends StatelessWidget {
//  final double totalMRP;
//   final double discountMRP;
//   final double totalAmount;
//   final int itemCount;
//   final List<String> selectedItemImages;
//     final List<Map<String, dynamic>> selectedProducts;

//   const Addresspage({
//     Key? key,
//     required this.totalMRP,
//     required this.discountMRP,
//     required this.totalAmount,
//     required this.itemCount,
//     required this.selectedItemImages,
//       required this.selectedProducts,
//   }) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("ADDRESS",
//         style: TextStyle(
//           color: Colors.black,
//           fontSize: 16,
//           fontWeight: FontWeight.bold
//         ),),
//         backgroundColor: Colors.white,
//       ),
//       backgroundColor: const Color.fromARGB(255, 246, 244, 244),
//   body:  Column(
//         children: [
//           const ShoppingProgressIndicator(currentStep: 1),
//           Container(
//         height: 15,
//         color: const Color.fromARGB(255, 246, 244, 244),
//       ),
//       Container(
//   padding: EdgeInsets.all(16),
//   decoration: BoxDecoration(
//     color: Colors.white,
//     borderRadius: BorderRadius.circular(8),
//   ),
//   child: Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           /// Left column: Name + HOME
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     Text(
//                       "user",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 15.5,
//                         color: Colors.black87,
//                       ),
//                     ),
//                     SizedBox(width: 5),
//                     Text(
//                       "(Default)",
//                       style: TextStyle(
//                         fontSize: 13.5,
//                         color: Colors.grey,
//                       ),
//                     ),
//                     SizedBox(width: 6),
//                     Container(
//                       padding: EdgeInsets.symmetric(horizontal: 7, vertical: 3),
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.green),
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Text(
//                         "HOME",
//                         style: TextStyle(
//                           color: Colors.green,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 10,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 10),
//                 Text(
//                   "House\nIrinjalakuda, Vellangallur\nVadakkumkara, Kerala 680662",
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: Colors.black54,
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 RichText(
//                   text: TextSpan(
//                     style: TextStyle(fontSize: 14, color: Colors.black),
//                     children: [
//                       TextSpan(
//                           text: "Mobile: ",
//                           style: TextStyle(color: Colors.black54)),
//                       TextSpan(
//                         text: "7356556028",
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black87,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           /// Right side: CHANGE
//           Align(
//             alignment: Alignment.topRight,
//             child: Text(
//               "Change",
//               style: TextStyle(
//                 color: Colors.pink,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 14,
//               ),
//             ),
//           )
//         ],
//       )
//     ],
//   ),
// ),
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
//           itemCount: selectedItemImages.length,
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
//               selectedItemImages[index], // Use index to select one image
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


//         ],
//       ),
//        bottomNavigationBar: Container(
//   padding: const EdgeInsets.only(left: 16,right: 16,bottom: 12, ),
//   decoration: BoxDecoration(
//     color: const Color(0xFFFFF5F5), // soft pinkish-white background
//     boxShadow: [
//       BoxShadow(
//         color: Colors.black.withOpacity(0.05),
//         blurRadius: 5,
//         offset: const Offset(0, -2),
//       ),
//     ],
//   ),
//   child: Column(
//     mainAxisSize: MainAxisSize.min,
//     children: [
//       // Top Text: 1 Item selected for ordersi
      
      

//       // Place Order Button
//       SizedBox(
//         width: double.infinity,
//         height: 48,
//         child: ElevatedButton(
//           onPressed: () {
         
//             Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => Paymentpage(
//                         totalMRP: totalMRP,
//                         discountMRP: discountMRP,
//                         totalAmount: totalAmount,
//                         itemCount: itemCount,
//                         selectedItemImages: selectedItemImages,
//                           selectedProducts: selectedProducts, 
//                       ),
//                     ),
//                   );

//           },
//           style: ElevatedButton.styleFrom(
//             backgroundColor: const Color(0xFFFF3D57), // vibrant pink-red
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10),
//             ),
//             elevation: 0,
//           ),
//           child: const Text(
//             'Continue',
//             style: TextStyle(
//               fontSize: 13.5,
//               fontWeight: FontWeight.w700,
//               letterSpacing: 0.5,
//               color: Colors.white,
//             ),
//           ),
//         ),
//       ),
//       SizedBox(height: 13,)
//     ],
//   ),
// ),
//     );
//   }
// }