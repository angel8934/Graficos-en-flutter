import 'package:flutter/material.dart';
import 'package:charts_painter/chart.dart';

import '../../../models/chart_case.dart';
import '../../../models/chart_definition.dart';
import '../../../models/chart_library.dart';

class CpAdvancedCharts {
  static List<ChartDefinition> all() {
    return List.generate(
      35,
      (index) {
        final stacked = index.isOdd;

        return ChartDefinition(
          id: 'CP-A${(index + 1).toString().padLeft(2, '0')}',
          title: stacked
              ? 'Charts Painter avanzado apilado ${index + 1}'
              : 'Charts Painter avanzado multiserie ${index + 1}',
          description:
              'VisualizaciÃ³n avanzada de mÃºltiples mÃ©tricas estadÃ­sticas de manga.',
          dataCompared:
              'PuntuaciÃ³n y popularidad de manga.',
          idealFor:
              'Comparaciones multidimensionales y anÃ¡lisis avanzado.',
          library: ChartLibrary.chartsPainter,
          level: ChartLevel.advanced,
          chartType:
              stacked ? 'Stacked Bar' : 'Multi-Series Bar',
          keywords: const [
            'manga',
            'anime',
            'charts painter',
            'avanzado',
            'multiserie',
            'stacked',
          ],
          builder: (context, data) => _chart(stacked),
        );
      },
    );
  }

  static Widget _chart(bool stacked) {
    final score = [
      82.0,
      76.0,
      91.0,
      68.0,
      88.0,
      73.0,
      95.0,
    ];

    final popularity = [
      62.0,
      72.0,
      84.0,
      55.0,
      79.0,
      67.0,
      89.0,
    ];

    final data = ChartData<void>(
      [
        score
            .map(
              (value) => ChartItem<void>(value),
            )
            .toList(),
        popularity
            .map(
              (value) => ChartItem<void>(value),
            )
            .toList(),
      ],
      dataStrategy: stacked
          ? StackDataStrategy()
          : const DefaultDataStrategy(
              stackMultipleValues: true,
            ),
    );

    return Chart<void>(
      state: ChartState<void>(
        data: data,
        itemOptions: BarItemOptions(
          barItemBuilder: (item) {
            return BarItem(
              color: item.listIndex == 0
                  ? Colors.deepPurple
                  : Colors.cyan,
              radius: const BorderRadius.vertical(
                top: Radius.circular(6),
              ),
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
}
