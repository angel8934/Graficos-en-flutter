import 'package:flutter/material.dart';
import 'package:fast_charts/fast_charts.dart';

import '../../../models/chart_case.dart';
import '../../../models/chart_definition.dart';
import '../../../models/chart_library.dart';

class FastAdvancedCharts {
  static List<ChartDefinition> all() {
    return List.generate(
      35,
      (index) => ChartDefinition(
        id: 'FAST-A${(index + 1).toString().padLeft(2, '0')}',
        title: 'Fast Charts avanzado ${index + 1}',
        description:
            'VisualizaciÃ³n avanzada de mÃºltiples series estadÃ­sticas de manga.',
        dataCompared:
            'PuntuaciÃ³n frente a popularidad y distribuciÃ³n de categorÃ­as.',
        idealFor:
            'Comparaciones multidimensionales y visualizaciones avanzadas.',
        library: ChartLibrary.fastCharts,
        level: ChartLevel.advanced,
        chartType: _types[index % _types.length],
        keywords: const [
          'fast charts',
          'manga',
          'anime',
          'avanzado',
          'multiserie',
          'stacked',
          'radial',
        ],
        builder: (context, data) => _chart(index),
      ),
    );
  }

  static Widget _chart(int index) {
    final first = Series<String, int>(
      data: {
        'A': 80 + index % 15,
        'B': 65 + index % 20,
        'C': 90 - index % 12,
        'D': 72 + index % 10,
      },
      measureAccessor: (value) => value.toDouble(),
      colorAccessor: (domain, value) => Colors.deepPurple,
    );

    final second = Series<String, int>(
      data: {
        'A': 45 + index % 15,
        'B': 55 + index % 20,
        'C': 70 - index % 10,
        'D': 60 + index % 12,
      },
      measureAccessor: (value) => value.toDouble(),
      colorAccessor: (domain, value) => Colors.cyan,
    );

    if (index % 4 == 0) {
      return BarChart(
        data: [
          first,
          second,
        ],
      );
    }

    if (index % 4 == 1) {
      return StackedBarChart(
        data: [
          first,
          second,
        ],
      );
    }

    if (index % 4 == 2) {
      return RadialStackedBarChart(
        data: [
          first,
          second,
        ],
      );
    }

    return PieChart(
      data: first,
    );
  }

  static const _types = [
    'Grouped Bar',
    'Stacked Bar',
    'Radial Stacked Bar',
    'Pie',
  ];
}
