import '../models/chart_case.dart';

class ChartRecipe {
  final int index;
  final ChartLevel level;
  final String type;
  final String metricA;
  final String? metricB;
  final String? metricC;
  final bool curved;
  final bool filled;
  final bool stacked;
  final bool grouped;
  final bool interactive;

  const ChartRecipe({
    required this.index,
    required this.level,
    required this.type,
    required this.metricA,
    this.metricB,
    this.metricC,
    this.curved = false,
    this.filled = false,
    this.stacked = false,
    this.grouped = false,
    this.interactive = false,
  });
}