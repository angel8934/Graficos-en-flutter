import 'package:flutter/material.dart';

import 'chart_case.dart';
import 'chart_data_source.dart';
import 'chart_library.dart';

typedef ChartBuilder = Widget Function(
  BuildContext context,
  ChartDataSource data,
);

class ChartDefinition {
  final String id;
  final String title;
  final String description;
  final String dataCompared;
  final String idealFor;
  final ChartLibrary library;
  final ChartLevel level;
  final String chartType;
  final List<String> keywords;
  final ChartBuilder builder;

  const ChartDefinition({
    required this.id,
    required this.title,
    required this.description,
    required this.dataCompared,
    required this.idealFor,
    required this.library,
    required this.level,
    required this.chartType,
    required this.keywords,
    required this.builder,
  });
}