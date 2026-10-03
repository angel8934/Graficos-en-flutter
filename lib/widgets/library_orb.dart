import 'package:flutter/material.dart';

import '../models/chart_library.dart';

class LibraryOrb extends StatefulWidget {
  final ChartLibrary library;
  final int chartCount;
  final VoidCallback onTap;

  const LibraryOrb({
    super.key,
    required this.library,
    required this.chartCount,
    required this.onTap,
  });

  @override
  State<LibraryOrb> createState() => _LibraryOrbState();
}

class _LibraryOrbState extends State<LibraryOrb> {
  bool hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => hovering = true),
      onExit: (_) => setState(() => hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          width: hovering ? 250 : 230,
          height: hovering ? 250 : 230,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const RadialGradient(
              colors: [
                Color(0xFFB967FF),
                Color(0xFF54258A),
                Color(0xFF160B29),
              ],
            ),
            border: Border.all(
              color: const Color(0xFFC084FC),
              width: hovering ? 3 : 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF9D4EDD).withValues(
                  alpha: hovering ? 0.75 : 0.35,
                ),
                blurRadius: hovering ? 45 : 25,
                spreadRadius: hovering ? 5 : 1,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.auto_awesome,
                size: 42,
                color: Colors.white,
              ),
              const SizedBox(height: 12),
              Text(
                widget.library.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 7),
              Text(
                '${widget.chartCount} charts',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.75),
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}