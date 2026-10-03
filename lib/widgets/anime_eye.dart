import 'package:flutter/material.dart';

class AnimeEye extends StatefulWidget {
  final double size;

  const AnimeEye({
    super.key,
    this.size = 180,
  });

  @override
  State<AnimeEye> createState() => _AnimeEyeState();
}

class _AnimeEyeState extends State<AnimeEye>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 2200,
      ),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final glow = 0.25 + controller.value * 0.3;

        return Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFB86CFF).withValues(
                  alpha: glow,
                ),
                blurRadius: 40,
                spreadRadius: 8,
              ),
            ],
          ),
          child: CustomPaint(
            painter: _AnimeEyePainter(
              animation: controller.value,
            ),
          ),
        );
      },
    );
  }
}

class _AnimeEyePainter extends CustomPainter {
  final double animation;

  _AnimeEyePainter({
    required this.animation,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(
      size.width / 2,
      size.height / 2,
    );

    final eyePaint = Paint()
      ..color = const Color(0xFF181329)
      ..style = PaintingStyle.fill;

    final irisPaint = Paint()
      ..shader = const RadialGradient(
        colors: [
          Color(0xFFE9B7FF),
          Color(0xFF9D4EDD),
          Color(0xFF24113D),
        ],
      ).createShader(
        Rect.fromCircle(
          center: center,
          radius: size.width * 0.31,
        ),
      );

    final pupilPaint = Paint()
      ..color = const Color(0xFF080611);

    final outlinePaint = Paint()
      ..color = const Color(0xFFDFA8FF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    final eyePath = Path();

    eyePath.moveTo(
      size.width * 0.12,
      center.dy,
    );

    eyePath.quadraticBezierTo(
      size.width * 0.5,
      size.height * 0.12,
      size.width * 0.88,
      center.dy,
    );

    eyePath.quadraticBezierTo(
      size.width * 0.5,
      size.height * 0.88,
      size.width * 0.12,
      center.dy,
    );

    eyePath.close();

    canvas.drawPath(
      eyePath,
      eyePaint,
    );

    canvas.drawPath(
      eyePath,
      outlinePaint,
    );

    canvas.drawCircle(
      center,
      size.width * 0.31,
      irisPaint,
    );

    final pupilRadius =
        size.width * (0.105 + animation * 0.025);

    canvas.drawCircle(
      center,
      pupilRadius,
      pupilPaint,
    );

    canvas.drawCircle(
      Offset(
        center.dx - size.width * 0.08,
        center.dy - size.width * 0.08,
      ),
      size.width * 0.045,
      Paint()..color = Colors.white,
    );
  }

  @override
  bool shouldRepaint(
    covariant _AnimeEyePainter oldDelegate,
  ) {
    return oldDelegate.animation != animation;
  }
}