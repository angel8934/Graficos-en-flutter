import 'package:flutter/material.dart';
import 'package:fusion_charts_flutter/fusion_charts_flutter.dart';

import '../../../models/chart_case.dart';
import '../../../models/chart_definition.dart';
import '../../../models/chart_library.dart';

class FusionAdvancedCharts {
  static List<ChartDefinition> all() {
    return List.generate(
      35,
      (index) => ChartDefinition(
        id: 'FC-A${(index + 1).toString().padLeft(2, '0')}',
        title: 'Fusion avanzado ${index + 1}',
        description:
            'ComparaciÃ³n avanzada de mÃºltiples series.',
        dataCompared:
            'PuntuaciÃ³n frente a popularidad.',
        idealFor:
            'AnÃ¡lisis comparativo e interacciÃ³n.',
        library: ChartLibrary.fusionCharts,
        level: ChartLevel.advanced,
        chartType:
            _types[index % _types.length],
        keywords: const [
          'fusion',
          'manga',
          'anime',
          'avanzado',
          'multiserie',
        ],
        builder: (context, data) => _chart(index),
      ),
    );
  }

  static Widget _chart(int index) {
    if (index % 3 == 0) {
      return FusionLineChart(
        series: [
          FusionLineSeries(
            name: 'Score',
            dataPoints: _score,
            color: Colors.deepPurple,
            isCurved: true,
          ),
          FusionLineSeries(
            name: 'Popularity',
            dataPoints: _popularity,
            color: Colors.cyan,
            isCurved: true,
          ),
        ],
        config:
            const FusionLineChartConfiguration(
          enableMarkers: true,
        ),
      );
    }

    if (index % 3 == 1) {
      return FusionBarChart(
        series: [
          FusionBarSeries(
            name: 'Score',
            dataPoints: _score,
            color: Colors.deepPurple,
          ),
          FusionBarSeries(
            name: 'Popularity',
            dataPoints: _popularity,
            color: Colors.cyan,
          ),
        ],
        config:
            const FusionBarChartConfiguration(
          enableLegend: true,
        ),
      );
    }

    return FusionStackedBarChart(
      series: [
        FusionStackedBarSeries(
          name: 'Score',
          dataPoints: _score,
          color: Colors.deepPurple,
        ),
        FusionStackedBarSeries(
          name: 'Popularity',
          dataPoints: _popularity,
          color: Colors.cyan,
        ),
      ],
      config:
          const FusionStackedBarChartConfiguration(
        enableLegend: true,
      ),
    );
  }

  static final _score = [
    FusionDataPoint(0, 82, label: 'A'),
    FusionDataPoint(1, 76, label: 'B'),
    FusionDataPoint(2, 91, label: 'C'),
    FusionDataPoint(3, 68, label: 'D'),
  ];

  static final _popularity = [
    FusionDataPoint(0, 62, label: 'A'),
    FusionDataPoint(1, 72, label: 'B'),
    FusionDataPoint(2, 84, label: 'C'),
    FusionDataPoint(3, 55, label: 'D'),
  ];

  static const _types = [
    'Multi-Series Line',
    'Multi-Series Bar',
    'Stacked Bar',
  ];
}
