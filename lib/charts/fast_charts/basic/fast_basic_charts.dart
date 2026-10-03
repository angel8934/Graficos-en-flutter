import 'package:flutter/material.dart';
import 'package:fast_charts/fast_charts.dart';

import '../../../models/chart_case.dart';
import '../../../models/chart_definition.dart';
import '../../../models/chart_library.dart';

class FastBasicCharts {
  static List<ChartDefinition> all() {
    return List.generate(
      50,
      (index) => ChartDefinition(
        id: 'FAST-B${(index + 1).toString().padLeft(2, '0')}',
        title: 'Fast Charts bÃ¡sico ${index + 1}',
        description:
            'RepresentaciÃ³n rÃ¡pida de estadÃ­sticas de manga.',
        dataCompared:
            'CategorÃ­as de manga frente a valores cuantitativos.',
        idealFor:
            'Comparaciones rÃ¡pidas y grandes cantidades de datos.',
        library: ChartLibrary.fastCharts,
        level: ChartLevel.basic,
        chartType: _types[index % _types.length],
        keywords: const [
          'fast charts',
          'manga',
          'anime',
          'basico',
          'rapido',
        ],
        builder: (context, data) =>
            _render(index),
      ),
    );
  }

  static Widget _render(int index) {
    final data = <String, int>{
      'A': 82 + index % 10,
      'B': 64 + index % 12,
      'C': 91 - index % 8,
      'D': 73 + index % 7,
    };

    final series = Series<String, int>(
      data: data,
      measureAccessor: (value) =>
          value.toDouble(),
      colorAccessor: (domain, value) =>
          Colors.primaries[
              domain.codeUnitAt(0) %
                  Colors.primaries.length],
      labelAccessor:
          (domain, value, percent) =>
              ChartLabel(
        '$value',
        style: const TextStyle(
          fontSize: 10,
          color: Colors.white,
        ),
      ),
    );

    if (index % 4 == 3) {
      return PieChart(
        data: series,
      );
    }

    return BarChart(
      data: [series],
    );
  }

  static const _types = [
    'Grouped Bar',
    'Vertical Bar',
    'Horizontal Bar',
    'Pie',
  ];
}

