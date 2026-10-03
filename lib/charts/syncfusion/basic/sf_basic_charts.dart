import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../models/chart_case.dart';
import '../../../models/chart_definition.dart';
import '../../../models/chart_library.dart';

class SfBasicCharts {
  static List<ChartDefinition> all() {
    return List.generate(
      50,
      (index) {
        final type = index % _titles.length;

        return ChartDefinition(
          id: 'SF-B${(index + 1).toString().padLeft(2, '0')}',
          title: '${_titles[type]} ${index + 1}',
          description:
              'Visualización básica de datos de manga mediante Syncfusion.',
          dataCompared: _data[type],
          idealFor: _ideal[type],
          library: ChartLibrary.syncfusion,
          level: ChartLevel.basic,
          chartType: _types[type],
          keywords: [
            'manga',
            'anime',
            'syncfusion',
            'basico',
            _types[type],
          ],
          builder: (context, data) => _render(type),
        );
      },
    );
  }

  static Widget _render(int type) {
    if (type == 7) {
      return SfCircularChart(
        title: const ChartTitle(
          text: 'Distribución de géneros',
        ),
        legend: const Legend(
          isVisible: true,
        ),
        series: <CircularSeries<_Point, String>>[
          PieSeries<_Point, String>(
            dataSource: _points,
            xValueMapper: (point, _) => point.label,
            yValueMapper: (point, _) => point.value,
            dataLabelSettings: const DataLabelSettings(
              isVisible: true,
            ),
          ),
        ],
      );
    }

    if (type == 8) {
      return SfCircularChart(
        title: const ChartTitle(
          text: 'Distribución de estados',
        ),
        legend: const Legend(
          isVisible: true,
        ),
        series: <CircularSeries<_Point, String>>[
          DoughnutSeries<_Point, String>(
            dataSource: _points,
            xValueMapper: (point, _) => point.label,
            yValueMapper: (point, _) => point.value,
            dataLabelSettings: const DataLabelSettings(
              isVisible: true,
            ),
          ),
        ],
      );
    }

    if (type == 9) {
      return SfCircularChart(
        title: const ChartTitle(
          text: 'Participación por tipo',
        ),
        legend: const Legend(
          isVisible: true,
        ),
        series: <CircularSeries<_Point, String>>[
          RadialBarSeries<_Point, String>(
            dataSource: _points,
            xValueMapper: (point, _) => point.label,
            yValueMapper: (point, _) => point.value,
            dataLabelSettings: const DataLabelSettings(
              isVisible: true,
            ),
          ),
        ],
      );
    }

    return SfCartesianChart(
      primaryXAxis: const CategoryAxis(),
      tooltipBehavior: TooltipBehavior(
        enable: true,
      ),
      series: <CartesianSeries<_Point, String>>[
        if (type == 0)
          LineSeries<_Point, String>(
            dataSource: _points,
            xValueMapper: (point, _) => point.label,
            yValueMapper: (point, _) => point.value,
          ),
        if (type == 1)
          ColumnSeries<_Point, String>(
            dataSource: _points,
            xValueMapper: (point, _) => point.label,
            yValueMapper: (point, _) => point.value,
          ),
        if (type == 2)
          BarSeries<_Point, String>(
            dataSource: _points,
            xValueMapper: (point, _) => point.label,
            yValueMapper: (point, _) => point.value,
          ),
        if (type == 3)
          AreaSeries<_Point, String>(
            dataSource: _points,
            xValueMapper: (point, _) => point.label,
            yValueMapper: (point, _) => point.value,
          ),
        if (type == 4)
          SplineSeries<_Point, String>(
            dataSource: _points,
            xValueMapper: (point, _) => point.label,
            yValueMapper: (point, _) => point.value,
          ),
        if (type == 5)
          StepLineSeries<_Point, String>(
            dataSource: _points,
            xValueMapper: (point, _) => point.label,
            yValueMapper: (point, _) => point.value,
          ),
        if (type == 6)
          ScatterSeries<_Point, String>(
            dataSource: _points,
            xValueMapper: (point, _) => point.label,
            yValueMapper: (point, _) => point.value,
          ),
      ],
    );
  }

  static final List<_Point> _points = [
    _Point('A', 82),
    _Point('B', 76),
    _Point('C', 91),
    _Point('D', 68),
    _Point('E', 88),
    _Point('F', 73),
  ];

  static const _titles = [
    'Puntuación por grupo',
    'Popularidad por grupo',
    'Capítulos por manga',
    'Área de puntuaciones',
    'Tendencia de ranking',
    'Evolución escalonada',
    'Relación manga-puntuación',
    'Distribución de géneros',
    'Distribución de estados',
    'Participación por tipo',
  ];

  static const _types = [
    'Line',
    'Column',
    'Bar',
    'Area',
    'Spline',
    'Step Line',
    'Scatter',
    'Pie',
    'Doughnut',
    'Radial Bar',
  ];

  static const _data = [
    'Manga frente a puntuación.',
    'Manga frente a popularidad.',
    'Manga frente a cantidad de capítulos.',
    'Categorías frente a puntuación.',
    'Orden frente a puntuación.',
    'Orden frente a puntuación.',
    'Índice frente a puntuación.',
    'Género frente a cantidad.',
    'Estado frente a cantidad.',
    'Tipo frente a cantidad.',
  ];

  static const _ideal = [
    'Comparaciones simples.',
    'Ranking visual.',
    'Conteo de capítulos.',
    'Tendencias.',
    'Series ordenadas.',
    'Datos discretos.',
    'Relaciones entre valores.',
    'Distribuciones.',
    'Distribuciones.',
    'Proporciones.',
  ];
}

class _Point {
  final String label;
  final double value;

  _Point(
    this.label,
    num value,
  ) : value = value.toDouble();
}
