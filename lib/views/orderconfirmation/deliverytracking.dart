import 'package:flutter/material.dart';
import 'dart:async';

import 'package:google_fonts/google_fonts.dart';
import 'package:whitematrix_groupa_shopping_app/views/orderconfirmation/orders.dart';

class DeliveryTrackingScreen extends StatefulWidget {
  final double totalMRP;
  final double discountMRP;
  final double totalAmount;
  final int itemCount;
  final List<String> selectedItemImages;
  final List<Map<String, dynamic>> selectedProducts;

  const DeliveryTrackingScreen({
    Key? key,
    required this.totalMRP,
    required this.discountMRP,
    required this.totalAmount,
    required this.itemCount,
    required this.selectedItemImages,
    required this.selectedProducts,
  }) : super(key: key);

  @override
  _DeliveryTrackingScreenState createState() => _DeliveryTrackingScreenState();
}

class _DeliveryTrackingScreenState extends State<DeliveryTrackingScreen> {
  double _progress = 0.0;
  String _status = "Order Confirmed";
  String _timeRemaining = "30 min";
  bool _isDelivered = false;
  List<DeliveryStep> _steps = [];
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _initializeSteps();
    _startTracking();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _initializeSteps() {
    _steps = [
      DeliveryStep("Order Confirmed", "We've received your order",
          Icons.check_circle, true),
      DeliveryStep(
          "Packed", "Your item has been packed", Icons.inventory_2, false),
      DeliveryStep("Picked Up", "Delivery partner has picked your order",
          Icons.local_shipping, false),
      DeliveryStep("On the Way", "Your order is coming to you",
          Icons.directions_bike, false),
      DeliveryStep(
          "Delivered", "Your order has been delivered", Icons.home, false),
    ];
  }

  void _startTracking() {
    // Fast-forward through all steps in 5 seconds
    const totalDuration = Duration(seconds: 5);
    const interval = Duration(milliseconds: 100);
    final steps = totalDuration.inMilliseconds ~/ interval.inMilliseconds;

    _timer = Timer.periodic(interval, (timer) {
      setState(() {
        _progress = (timer.tick / steps).clamp(0.0, 1.0);

        // Update status based on progress
        if (_progress < 0.2) {
          _status = "Packed";
          _steps[1].isCompleted = true;
          _timeRemaining = "25 min";
        } else if (_progress < 0.4) {
          _status = "Picked Up";
          _steps[2].isCompleted = true;
          _timeRemaining = "20 min";
        } else if (_progress < 0.6) {
          _status = "On the Way";
          _steps[3].isCompleted = true;
          _timeRemaining = "15 min";
        } else if (_progress < 0.8) {
          _status = "Nearby";
          _timeRemaining = "5 min";
        } else {
          _status = "Delivered";
          _steps[4].isCompleted = true;
          _timeRemaining = "0 min";
          _isDelivered = true;
        }

        if (_progress >= 1.0) {
          timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Myntra Fast Delivery'),
        backgroundColor: Colors.pink,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your order will arrive in',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Text(
              _timeRemaining,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            LinearProgressIndicator(
              value: _progress,
              backgroundColor: Colors.grey[200],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.pink),
              minHeight: 10,
            ),
            const SizedBox(height: 30),
            Text(
              _status,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              _isDelivered
                  ? "Your order has been delivered!"
                  : "Your order is on the way!",
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: ListView.builder(
                itemCount: _steps.length,
                itemBuilder: (context, index) {
                  final step = _steps[index];
                  return DeliveryStepWidget(
                    step: step,
                    isLast: index == _steps.length - 1,
                  );
                },
              ),
            ),
            if (_isDelivered)
              Center(
                  child: InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Orders(
                        totalMRP: widget.totalMRP,
                        discountMRP: widget.discountMRP,
                        totalAmount: widget.totalAmount,
                        itemCount: widget.itemCount,
                        selectedItemImages: widget.selectedItemImages,
                        selectedProducts: widget.selectedProducts,
                      ),
                    ),
                  );
                },
                child: Container(
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey, width: 2),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: Text(
                        "Previous Order",
                        style: GoogleFonts.roboto(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  ),
                ),
              )),
          ],
        ),
      ),
    );
  }
}

class DeliveryStep {
  final String title;
  final String description;
  final IconData icon;
  bool isCompleted;

  DeliveryStep(this.title, this.description, this.icon, this.isCompleted);
}

class DeliveryStepWidget extends StatelessWidget {
  final DeliveryStep step;
  final bool isLast;

  const DeliveryStepWidget({
    super.key,
    required this.step,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Icon(
              step.isCompleted ? Icons.check_circle : step.icon,
              color: step.isCompleted ? Colors.pink : Colors.grey,
            ),
            if (!isLast)
              Container(
                width: 1,
                height: 40,
                color: step.isCompleted ? Colors.pink : Colors.grey,
              ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                step.title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: step.isCompleted ? Colors.black : Colors.grey,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                step.description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }
}
