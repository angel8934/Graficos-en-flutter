import 'package:flutter/material.dart';

class GlowContainer extends StatelessWidget {
  final Widget child;
  final Color glowColor;
  final EdgeInsetsGeometry padding;

  const GlowContainer({
    super.key,
    required this.child,
    this.glowColor = const Color(0xFF9D4EDD),
    this.padding = const EdgeInsets.all(20),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: const Color(0xFF11101D),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: glowColor.withValues(
            alpha: 0.55,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: glowColor.withValues(
              alpha: 0.22,
            ),
            blurRadius: 30,
            spreadRadius: 2,
          ),
        ],
      ),
      child: child,
    );
  }
}