import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:whitematrix_groupa_shopping_app/views/orderconfirmation/orders.dart';



class Deliveryconirm extends StatefulWidget {
  

   Deliveryconirm({
    Key? key,
 
  }) : super(key: key);

  @override
  State<Deliveryconirm> createState() => _OrderConfirmationScreenState();
}

class _OrderConfirmationScreenState extends State<Deliveryconirm> {
  
    @override
  void initState() {
    super.initState();
 
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Lottie.asset(
              'assets/delivery1.json',
              width: 200,
              height: 200,
              fit: BoxFit.fill,
            ),
             SizedBox(height: 20),
  
             Text(
              'Order Delivered !',
              style: GoogleFonts.roboto(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green[700],
              ),
            ),
             SizedBox(height: 10),
             Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'Yay! Your Order Delivered Successfully \n Thank you for choosing us!',
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
            ),
            SizedBox(height: 50),
           Row(
            mainAxisAlignment: MainAxisAlignment.center,
             children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Orders()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[800],
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                child: Text(
                  'Previous Orders',
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
             ],
           ),
            SizedBox(height: 20),
           
          ],
        ),
      ),
      
    );
  }
}