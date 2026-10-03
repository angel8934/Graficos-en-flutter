import 'package:flutter/material.dart';
import 'package:fusion_charts_flutter/fusion_charts_flutter.dart';

import '../../../models/chart_case.dart';
import '../../../models/chart_definition.dart';
import '../../../models/chart_library.dart';

class FusionBasicCharts {
  static List<ChartDefinition> all() {
    return List.generate(
      50,
      (index) => ChartDefinition(
        id: 'FC-B${(index + 1).toString().padLeft(2, '0')}',
        title: 'Fusion bÃ¡sico ${index + 1}',
        description: 'GrÃ¡fico bÃ¡sico construido con Fusion Charts.',
        dataCompared: 'CategorÃ­as de manga frente a valores estadÃ­sticos.',
        idealFor: 'Primer anÃ¡lisis visual de datos de manga.',
        library: ChartLibrary.fusionCharts,
        level: ChartLevel.basic,
        chartType: _types[index % _types.length],
        keywords: const ['manga', 'anime', 'fusion', 'basico'],
        builder: (context, data) => _render(index),
      ),
    );
  }

  static Widget _render(int index) {
    switch (index % 4) {
      case 0:
        return FusionLineChart(
          series: [
            FusionLineSeries(
              name: 'Score',
              dataPoints: _line,
              color: Colors.deepPurple,
            ),
          ],
        );

      case 1:
        return FusionBarChart(
          series: [FusionBarSeries(name: 'Popularity', dataPoints: _bar, color: Colors.cyan)],
        );

      case 2:
        return FusionPieChart(
          series: FusionPieSeries(
            dataPoints: [
              FusionPieDataPoint(35, label: 'Shonen'),
              FusionPieDataPoint(25, label: 'Seinen'),
              FusionPieDataPoint(20, label: 'Shojo'),
              FusionPieDataPoint(20, label: 'Otros'),
            ],
          ),
        );

      default:
        return FusionPieChart(
          series: FusionPieSeries(
            dataPoints: [
              FusionPieDataPoint(45, label: 'Finalizado'),
              FusionPieDataPoint(35, label: 'En emisiÃ³n'),
              FusionPieDataPoint(20, label: 'Hiatus'),
            ],
          ),
          config: const FusionPieChartConfiguration(
            innerRadiusPercent: 0.5,
            showCenterLabel: true,
            centerLabelText: '100',
            centerSubLabelText: 'Manga',
          ),
        );
    }
  }

  static final _line = [
    FusionDataPoint(0, 82),
    FusionDataPoint(1, 76),
    FusionDataPoint(2, 91),
    FusionDataPoint(3, 68),
    FusionDataPoint(4, 88),
  ];

  static final _bar = [
    FusionDataPoint(0, 65, label: 'A'),
    FusionDataPoint(1, 82, label: 'B'),
    FusionDataPoint(2, 54, label: 'C'),
    FusionDataPoint(3, 91, label: 'D'),
  ];

  static const _types = ['Line', 'Bar', 'Pie', 'Donut'];
}


