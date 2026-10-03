import 'package:flutter/material.dart';
import 'package:charts_painter/chart.dart';

import '../../../models/chart_case.dart';
import '../../../models/chart_definition.dart';
import '../../../models/chart_library.dart';

class CpBasicCharts {
  static List<ChartDefinition> all() {
    return List.generate(
      50,
      (index) {
        final type = index % 5;

        return ChartDefinition(
          id: 'CP-B${(index + 1).toString().padLeft(2, '0')}',
          title: _titles[type],
          description:
              'VisualizaciÃ³n bÃ¡sica de datos estadÃ­sticos de manga mediante Charts Painter.',
          dataCompared: _data[type],
          idealFor: _ideal[type],
          library: ChartLibrary.chartsPainter,
          level: ChartLevel.basic,
          chartType: _types[type],
          keywords: [
            'manga',
            'anime',
            'charts painter',
            'basico',
            _types[type],
          ],
          builder: (context, data) => _chart(type),
        );
      },
    );
  }

  static Widget _chart(int type) {
    final values = [
      82.0,
      76.0,
      91.0,
      68.0,
      88.0,
      73.0,
      95.0,
    ];

    return Chart<void>(
      state: ChartState<void>(
        data: ChartData<void>(
          [
            values
                .map(
                  (value) => ChartItem<void>(value),
                )
                .toList(),
          ],
        ),
        itemOptions: BarItemOptions(
          barItemBuilder: (data) {
            return BarItem(
              color: Colors.deepPurple,
            );
          },
        ),
        backgroundDecorations: [
          HorizontalAxisDecoration(
            axisStep: 20,
            showValues: true,
          ),
        ],
      ),
    );
  }

  static const _titles = [
    'PuntuaciÃ³n por manga',
    'Popularidad por manga',
    'CapÃ­tulos por manga',
    'Ranking por manga',
    'DistribuciÃ³n de manga',
  ];

  static const _types = [
    'Bar Chart',
    'Bar Chart',
    'Bar Chart',
    'Bar Chart',
    'Bar Chart',
  ];

  static const _data = [
    'Manga frente a puntuaciÃ³n.',
    'Manga frente a popularidad.',
    'Manga frente a cantidad de capÃ­tulos.',
    'Manga frente a posiciÃ³n del ranking.',
    'CategorÃ­a frente a cantidad de manga.',
  ];

  static const _ideal = [
    'Comparaciones simples de puntuaciÃ³n.',
    'AnÃ¡lisis de popularidad.',
    'AnÃ¡lisis de longitud.',
    'Comparaciones de ranking.',
    'Distribuciones categÃ³ricas.',
  ];
}
