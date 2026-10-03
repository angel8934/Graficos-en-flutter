import 'package:flutter/material.dart';

import '../models/chart_case.dart';

class CategoryTab extends StatelessWidget {
  final ChartLevel level;
  final bool selected;
  final VoidCallback onTap;

  const CategoryTab({
    super.key,
    required this.level,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      selected: selected,
      label: Text(
        level.name.toUpperCase(),
      ),
      onSelected: (_) => onTap(),
      selectedColor: const Color(0xFF9D4EDD),
      labelStyle: TextStyle(
        color: selected
            ? Colors.white
            : Colors.white70,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}