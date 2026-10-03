import 'dart:math' as math;

import 'package:flutter/material.dart';

class MagicalBackground extends StatelessWidget {
  final Widget child;

  const MagicalBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF05030B),
                  Color(0xFF0C0718),
                  Color(0xFF120822),
                  Color(0xFF05030B),
                ],
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: IgnorePointer(
            child: CustomPaint(
              painter: _MagicGridPainter(),
            ),
          ),
        ),
        child,
      ],
    );
  }
}

class _MagicGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF8B5CF6).withValues(alpha: 0.08)
      ..strokeWidth = 1;

    const spacing = 42.0;

    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        paint,
      );
    }

    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );
    }

    final glowPaint = Paint()
      ..color = const Color(0xFFB967FF).withValues(alpha: 0.12)
      ..maskFilter = const MaskFilter.blur(
        BlurStyle.normal,
        60,
      );

    canvas.drawCircle(
      Offset(size.width * 0.15, size.height * 0.2),
      100,
      glowPaint,
    );

    canvas.drawCircle(
      Offset(size.width * 0.85, size.height * 0.7),
      130,
      glowPaint,
    );

    final starPaint = Paint()
      ..color = const Color(0xFFD8B4FE).withValues(alpha: 0.35);

    final random = math.Random(7);

    for (int i = 0; i < 90; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final radius = 0.5 + random.nextDouble() * 1.2;

      canvas.drawCircle(
        Offset(x, y),
        radius,
        starPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}