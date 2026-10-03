import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';

import '../../../models/chart_case.dart';
import '../../../models/chart_definition.dart';
import '../../../models/chart_library.dart';

class GraphicAdvancedCharts {
  static List<ChartDefinition> all() {
    return List.generate(
      35,
      (index) => ChartDefinition(
        id: 'GR-A${(index + 1).toString().padLeft(2, '0')}',
        title: 'Graphic avanzado ${index + 1}',
        description:
            'VisualizaciÃ³n avanzada con mÃºltiples dimensiones.',
        dataCompared:
            'PuntuaciÃ³n y popularidad por gÃ©nero de manga.',
        idealFor:
            'AnÃ¡lisis multidimensional, selecciÃ³n y tooltips.',
        library: ChartLibrary.graphic,
        level: ChartLevel.advanced,
        chartType: 'Multi-variable',
        keywords: const [
          'graphic',
          'manga',
          'anime',
          'avanzado',
          'interactivo',
          'multivariable',
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
        'score': 80 + index % 15,
        'popularity': 70 + index % 20,
      },
      {
        'genre': 'Seinen',
        'score': 72 + index % 18,
        'popularity': 60 + index % 25,
      },
      {
        'genre': 'Shojo',
        'score': 76 + index % 12,
        'popularity': 52 + index % 22,
      },
      {
        'genre': 'Josei',
        'score': 68 + index % 15,
        'popularity': 48 + index % 18,
      },
    ];

    return Chart(
      data: data,
      variables: {
        'genre': Variable(
          accessor: (Map map) =>
              map['genre'] as String,
        ),
        'score': Variable(
          accessor: (Map map) =>
              map['score'] as num,
        ),
        'popularity': Variable(
          accessor: (Map map) =>
              map['popularity'] as num,
        ),
      },
      marks: [
        IntervalMark(
          position: Varset('genre') *
              Varset('score'),
          color: ColorEncode(
            variable: 'genre',
            values: [
              Colors.deepPurple,
              Colors.cyan,
              Colors.pink,
              Colors.orange,
            ],
          ),
        ),
        PointMark(
          position: Varset('genre') *
              Varset('popularity'),
          size: SizeEncode(
            value: 8,
          ),
          color: ColorEncode(
            value: Colors.white,
          ),
        ),
      ],
      axes: [
        Defaults.horizontalAxis,
        Defaults.verticalAxis,
      ],
      
    );
  }
}

