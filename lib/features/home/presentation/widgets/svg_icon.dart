
import 'package:flutter/material.dart';

class SvgIcon extends StatelessWidget {
  const SvgIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 16,
      height: 16,
      child: CustomPaint(
        painter: LogoPainter(),
      ),
    );
  }
}

class LogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF101518)
      ..style = PaintingStyle.fill;
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width * 0.361, 0)
      ..lineTo(size.width * 0.361, size.height * 0.361)
      ..lineTo(size.width * 0.639, size.height * 0.361)
      ..lineTo(size.width * 0.639, size.height * 0.639)
      ..lineTo(size.width, size.height * 0.639)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

