import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';

import '../../../models/chart_case.dart';
import '../../../models/chart_definition.dart';
import '../../../models/chart_library.dart';

class GraphicBasicCharts {
  static List<ChartDefinition> all() {
    return List.generate(
      50,
      (index) => ChartDefinition(
        id: 'GR-B${(index + 1).toString().padLeft(2, '0')}',
        title: 'Graphic bÃ¡sico ${index + 1}',
        description:
            'VisualizaciÃ³n declarativa usando Grammar of Graphics.',
        dataCompared:
            'CategorÃ­as de manga frente a mÃ©tricas cuantitativas.',
        idealFor:
            'Visualizaciones declarativas y acadÃ©micas.',
        library: ChartLibrary.graphic,
        level: ChartLevel.basic,
        chartType: 'Interval',
        keywords: const [
          'graphic',
          'manga',
          'anime',
          'basico',
          'grammar',
        ],
        builder: (context, data) =>
            _render(index),
      ),
    );
  }

  static Widget _render(int index) {
    final data = [
      {
        'genre': 'Shonen',
        'value': 70 + index % 15,
      },
      {
        'genre': 'Seinen',
        'value': 55 + index % 20,
      },
      {
        'genre': 'Shojo',
        'value': 45 + index % 18,
      },
      {
        'genre': 'Josei',
        'value': 35 + index % 12,
      },
    ];

    return Chart(
      data: data,
      variables: {
        'genre': Variable(
          accessor: (Map map) =>
              map['genre'] as String,
        ),
        'value': Variable(
          accessor: (Map map) =>
              map['value'] as num,
        ),
      },
      marks: [
        IntervalMark(),
      ],
      axes: [
        Defaults.horizontalAxis,
        Defaults.verticalAxis,
      ],
    );
  }
}

