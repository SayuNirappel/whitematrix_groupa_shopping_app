import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whitematrix_groupa_shopping_app/controllers/cartcontroller.dart';


class Couponscreen extends StatefulWidget {
  final String userId;
  final double cartTotal;
  const Couponscreen({super.key, required this.userId, required this.cartTotal});

  @override
  State<Couponscreen> createState() => _CouponscreenState();
}

class _CouponscreenState extends State<Couponscreen> {
  
  bool _isLoading = false;

  bool isSelected = false;
  final TextEditingController _controller = TextEditingController();
  bool _hasText = false;
  bool _isCouponValid = false;
  String? _errorMessage;
  String? _successMessage;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _hasText = _controller.text.trim().isNotEmpty;
        _errorMessage = null;
        _successMessage = null; // Clear success message when typing
      });
    });
  }

void _checkCoupon() async {
  final cartProvider = Provider.of<CartProvider>(context, listen: false);
  final couponCode = _controller.text.trim();

  if (couponCode.isNotEmpty) {
    setState(() {
      _isLoading = true;
    });

    final success = await cartProvider.applyCoupon(
      userId: widget.userId,
      couponCode: couponCode,
      cartTotal: widget.cartTotal,
    );

    setState(() {
      _isLoading = false;
      _isCouponValid = success;
      if (success) {
        isSelected = true;
      } else {
        _errorMessage = cartProvider.couponMessage ?? 'Invalid coupon code';
        isSelected = false;
      }
    });
  }
}


void _applyCoupon() {
  final cartProvider = Provider.of<CartProvider>(context, listen: false);
  setState(() {
    if (_isCouponValid) {
      _successMessage = cartProvider.couponMessage ?? 'Coupon applied successfully';
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Coupon applied successfully!'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  });
  Navigator.pop(context, {'discount': _isCouponValid ? 30.0 : 0.0});
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "COUPONS",
          style: TextStyle(
            color: Colors.black87,
            fontSize: 15.5,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 239, 238, 238),
      body: 
      
      Column(
        children: [
          
          Container(
            color: Colors.white,
            child: Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'Enter coupon code',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: _hasText ? _checkCoupon : null,
                    child: Text(
                      "CHECK",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _hasText ? Colors.red : Colors.pink.shade200,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
           if (_isLoading)
          Container(
            padding: EdgeInsets.only(top: 50),
            color: const Color.fromARGB(255, 239, 238, 238),
            child: const Center(
              child: CircularProgressIndicator(color: Colors.black),
            ),
          ),
          if (_errorMessage != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red, fontSize: 14),
              ),
            ),
          if (_successMessage != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                _successMessage!,
                style: const TextStyle(color: Colors.green, fontSize: 14),
              ),
            ),
          if (_isCouponValid)
            Expanded(
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isSelected = !isSelected;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(24.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: isSelected ? const Color(0xFFE91E63) : Colors.transparent,
                                    border: Border.all(
                                      color: isSelected ? const Color(0xFFE91E63) : Colors.grey,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: isSelected
                                      ? const Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 16,
                                        )
                                      : null,
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: CustomPaint(
                                    painter: DottedBorderPainter(
                                      color: isSelected ? const Color(0xFFE91E63) : Colors.black,
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                      child: Text(
                                        _controller.text.trim(),
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: isSelected ? const Color(0xFFE91E63) : Colors.black,
                                          letterSpacing: 1.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            RichText(
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text: 'Save ',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '₹30',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Expires on: 30th June 2025 | 11:59 PM',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          else
            const Expanded(
              child: Center(
                child: Text(
                  'Enter a valid coupon code',
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ),
            ),
            
        ],
      ),
      bottomNavigationBar: Container(
        height: 90,
        color: Colors.white,
        padding: const EdgeInsets.only(top: 20, bottom: 20, left: 30, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Maximum savings:",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _isCouponValid ? "₹30" : "₹0",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(width: 15,),
            Expanded(
              child: GestureDetector(
                onTap: _applyCoupon,
                
                child: Container(
                  decoration: BoxDecoration(
                    color: _isCouponValid ? Colors.red : Colors.grey,
                  ),
                  child: const Center(
                    child: Text(
                      "APPLY",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class DottedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashLength;
  final double dashSpace;

  DottedBorderPainter({
    required this.color,
    this.strokeWidth = 2.0,
    this.dashLength = 5.0,
    this.dashSpace = 3.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        const Radius.circular(8),
      ));

    _drawDashedPath(canvas, path, paint);
  }

  void _drawDashedPath(Canvas canvas, Path path, Paint paint) {
    final pathMetrics = path.computeMetrics();
    for (final pathMetric in pathMetrics) {
      double distance = 0.0;
      while (distance < pathMetric.length) {
        final nextDistance = distance + dashLength;
        final extractPath = pathMetric.extractPath(
          distance,
          nextDistance > pathMetric.length ? pathMetric.length : nextDistance,
        );
        canvas.drawPath(extractPath, paint);
        distance = nextDistance + dashSpace;
      }
    }
    
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}