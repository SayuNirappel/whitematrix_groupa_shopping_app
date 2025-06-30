import 'package:flutter/material.dart';

class CouponShapePainter extends CustomPainter {
  final Color borderColor;

  CouponShapePainter({required this.borderColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.transparent
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final path = Path();
    const double notchRadius = 2;

    // Start from top-left corner notch
    path.moveTo(0, notchRadius);
    path.arcToPoint(
      Offset(notchRadius, 0),
      radius: Radius.circular(notchRadius),
      clockwise: false,
    );

    // Top edge to top-right corner
    path.lineTo(size.width - notchRadius, 0);
    path.arcToPoint(
      Offset(size.width, notchRadius),
      radius: Radius.circular(notchRadius),
      clockwise: false,
    );

    // Right edge to bottom-right corner
    path.lineTo(size.width, size.height - notchRadius);
    path.arcToPoint(
      Offset(size.width - notchRadius, size.height),
      radius: Radius.circular(notchRadius),
      clockwise: false,
    );

    // Bottom edge to bottom-left corner
    path.lineTo(notchRadius, size.height);
    path.arcToPoint(
      Offset(0, size.height - notchRadius),
      radius: Radius.circular(notchRadius),
      clockwise: false,
    );

    // Left edge back to top-left
    path.lineTo(0, notchRadius);

    canvas.drawPath(path, paint);
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
