import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../models/chart_case.dart';
import '../../../models/chart_definition.dart';
import '../../../models/chart_library.dart';

class SfAdvancedCharts {
  static List<ChartDefinition> all() {
    return List.generate(
      35,
      (index) {
        final type = index % 7;

        return ChartDefinition(
          id: 'SF-A${(index + 1).toString().padLeft(2, '0')}',
          title: _titles[type],
          description:
              'VisualizaciÃ³n avanzada de mÃºltiples dimensiones de datos de manga mediante Syncfusion.',
          dataCompared: _data[type],
          idealFor: _ideal[type],
          library: ChartLibrary.syncfusion,
          level: ChartLevel.advanced,
          chartType: _types[type],
          keywords: [
            'manga',
            'anime',
            'syncfusion',
            'avanzado',
            'multiserie',
            _types[type],
          ],
          builder: (context, data) => _render(type),
        );
      },
    );
  }

  static Widget _render(int type) {
    switch (type) {
      case 0:
        return SfCartesianChart(
          title: const ChartTitle(
            text: 'PuntuaciÃ³n y popularidad',
          ),
          legend: const Legend(
            isVisible: true,
          ),
          tooltipBehavior: TooltipBehavior(
            enable: true,
          ),
          primaryXAxis: const CategoryAxis(),
          series: <CartesianSeries<_Point, String>>[
            LineSeries<_Point, String>(
              name: 'PuntuaciÃ³n',
              dataSource: _points,
              xValueMapper: (point, _) => point.label,
              yValueMapper: (point, _) => point.a,
            ),
            LineSeries<_Point, String>(
              name: 'Popularidad',
              dataSource: _points,
              xValueMapper: (point, _) => point.label,
              yValueMapper: (point, _) => point.b,
            ),
          ],
        );

      case 1:
        return SfCartesianChart(
          title: const ChartTitle(
            text: 'ComparaciÃ³n multiserie',
          ),
          legend: const Legend(
            isVisible: true,
          ),
          tooltipBehavior: TooltipBehavior(
            enable: true,
          ),
          primaryXAxis: const CategoryAxis(),
          series: <CartesianSeries<_Point, String>>[
            ColumnSeries<_Point, String>(
              name: 'PuntuaciÃ³n',
              dataSource: _points,
              xValueMapper: (point, _) => point.label,
              yValueMapper: (point, _) => point.a,
            ),
            ColumnSeries<_Point, String>(
              name: 'Popularidad',
              dataSource: _points,
              xValueMapper: (point, _) => point.label,
              yValueMapper: (point, _) => point.b,
            ),
          ],
        );

      case 2:
        return SfCartesianChart(
          title: const ChartTitle(
            text: 'Barras apiladas',
          ),
          legend: const Legend(
            isVisible: true,
          ),
          tooltipBehavior: TooltipBehavior(
            enable: true,
          ),
          primaryXAxis: const CategoryAxis(),
          series: <CartesianSeries<_Point, String>>[
            StackedColumnSeries<_Point, String>(
              name: 'PuntuaciÃ³n',
              dataSource: _points,
              xValueMapper: (point, _) => point.label,
              yValueMapper: (point, _) => point.a,
            ),
            StackedColumnSeries<_Point, String>(
              name: 'Popularidad',
              dataSource: _points,
              xValueMapper: (point, _) => point.label,
              yValueMapper: (point, _) => point.b,
            ),
          ],
        );

      case 3:
        return SfCartesianChart(
          title: const ChartTitle(
            text: 'Ãrea multiserie',
          ),
          legend: const Legend(
            isVisible: true,
          ),
          tooltipBehavior: TooltipBehavior(
            enable: true,
          ),
          primaryXAxis: const CategoryAxis(),
          series: <CartesianSeries<_Point, String>>[
            AreaSeries<_Point, String>(
              name: 'PuntuaciÃ³n',
              dataSource: _points,
              xValueMapper: (point, _) => point.label,
              yValueMapper: (point, _) => point.a,
            ),
            AreaSeries<_Point, String>(
              name: 'Popularidad',
              dataSource: _points,
              xValueMapper: (point, _) => point.label,
              yValueMapper: (point, _) => point.b,
            ),
          ],
        );

      case 4:
        return SfCartesianChart(
          title: const ChartTitle(
            text: 'Spline multiserie',
          ),
          legend: const Legend(
            isVisible: true,
          ),
          tooltipBehavior: TooltipBehavior(
            enable: true,
          ),
          primaryXAxis: const CategoryAxis(),
          series: <CartesianSeries<_Point, String>>[
            SplineSeries<_Point, String>(
              name: 'PuntuaciÃ³n',
              dataSource: _points,
              xValueMapper: (point, _) => point.label,
              yValueMapper: (point, _) => point.a,
            ),
            SplineSeries<_Point, String>(
              name: 'Popularidad',
              dataSource: _points,
              xValueMapper: (point, _) => point.label,
              yValueMapper: (point, _) => point.b,
            ),
          ],
        );

      case 5:
        return SfCartesianChart(
          title: const ChartTitle(
            text: 'DispersiÃ³n',
          ),
          legend: const Legend(
            isVisible: true,
          ),
          tooltipBehavior: TooltipBehavior(
            enable: true,
          ),
          primaryXAxis: const CategoryAxis(),
          series: <CartesianSeries<_Point, String>>[
            ScatterSeries<_Point, String>(
              name: 'PuntuaciÃ³n',
              dataSource: _points,
              xValueMapper: (point, _) => point.label,
              yValueMapper: (point, _) => point.a,
            ),
            ScatterSeries<_Point, String>(
              name: 'Popularidad',
              dataSource: _points,
              xValueMapper: (point, _) => point.label,
              yValueMapper: (point, _) => point.b,
            ),
          ],
        );

      default:
        return SfCartesianChart(
          title: const ChartTitle(
            text: 'Barras horizontales multiserie',
          ),
          legend: const Legend(
            isVisible: true,
          ),
          tooltipBehavior: TooltipBehavior(
            enable: true,
          ),
          primaryXAxis: const CategoryAxis(),
          series: <CartesianSeries<_Point, String>>[
            BarSeries<_Point, String>(
              name: 'PuntuaciÃ³n',
              dataSource: _points,
              xValueMapper: (point, _) => point.label,
              yValueMapper: (point, _) => point.a,
            ),
            BarSeries<_Point, String>(
              name: 'Popularidad',
              dataSource: _points,
              xValueMapper: (point, _) => point.label,
              yValueMapper: (point, _) => point.b,
            ),
          ],
        );
    }
  }

  static final List<_Point> _points = [
    _Point('A', 82, 62),
    _Point('B', 76, 72),
    _Point('C', 91, 84),
    _Point('D', 68, 55),
    _Point('E', 88, 79),
    _Point('F', 73, 67),
    _Point('G', 95, 89),
  ];

  static const _titles = [
    'PuntuaciÃ³n y popularidad',
    'ComparaciÃ³n multiserie',
    'Barras apiladas',
    'Ãrea multiserie',
    'Spline multiserie',
    'DispersiÃ³n multiserie',
    'Barras horizontales multiserie',
  ];

  static const _types = [
    'Multi-Series Line',
    'Multi-Series Column',
    'Stacked Column',
    'Multi-Series Area',
    'Multi-Series Spline',
    'Multi-Series Scatter',
    'Multi-Series Bar',
  ];

  static const _data = [
    'PuntuaciÃ³n frente a popularidad.',
    'PuntuaciÃ³n frente a popularidad.',
    'PuntuaciÃ³n y popularidad acumuladas.',
    'PuntuaciÃ³n frente a popularidad a lo largo de categorÃ­as.',
    'Tendencia de puntuaciÃ³n frente a popularidad.',
    'RelaciÃ³n entre puntuaciÃ³n y popularidad.',
    'PuntuaciÃ³n frente a popularidad por manga.',
  ];

  static const _ideal = [
    'Comparaciones de dos mÃ©tricas.',
    'Comparaciones multiserie.',
    'ComposiciÃ³n de mÃ©tricas.',
    'Tendencias multidimensionales.',
    'AnÃ¡lisis de tendencias.',
    'Relaciones entre variables.',
    'Comparaciones horizontales.',
  ];
}

class _Point {
  final String label;
  final double a;
  final double b;

  _Point(
    this.label,
    num a,
    num b,
  )   : a = a.toDouble(),
        b = b.toDouble();
}
