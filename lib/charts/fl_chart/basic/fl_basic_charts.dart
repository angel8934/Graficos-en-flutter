import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../models/chart_case.dart';
import '../../../models/chart_data_source.dart';
import '../../../models/chart_definition.dart';
import '../../../models/chart_library.dart';

class FlBasicCharts {
  static const _colors = [
    Color(0xFF8B5CF6),
    Color(0xFF22D3EE),
    Color(0xFFF472B6),
    Color(0xFF34D399),
    Color(0xFFFBBF24),
    Color(0xFF60A5FA),
    Color(0xFFA78BFA),
    Color(0xFFFB7185),
  ];

  static List<ChartDefinition> all() {
    return [
      ChartDefinition(
        id: 'fl-basic-001',
        title: 'Puntuación por manga',
        description: 'Compara la puntuación de cada manga.',
        dataCompared: 'Score',
        idealFor: 'Comparar puntuaciones individuales.',
        library: ChartLibrary.flChart,
        level: ChartLevel.basic,
        chartType: 'Bar chart',
        keywords: ['score', 'puntuación', 'barra'],
        builder: (
          BuildContext context,
          ChartDataSource data,
        ) {
          return _scoreBars(data);
        },
      ),
      ChartDefinition(
        id: 'fl-basic-002',
        title: 'Popularidad por manga',
        description: 'Compara la popularidad de los mangas.',
        dataCompared: 'Popularity',
        idealFor: 'Comparar popularidad.',
        library: ChartLibrary.flChart,
        level: ChartLevel.basic,
        chartType: 'Bar chart',
        keywords: ['popularidad', 'popularity', 'barra'],
        builder: (
          BuildContext context,
          ChartDataSource data,
        ) {
          return _popularityBars(data);
        },
      ),
      ChartDefinition(
        id: 'fl-basic-003',
        title: 'Evolución de puntuaciones',
        description: 'Representa las puntuaciones en secuencia.',
        dataCompared: 'Score',
        idealFor: 'Observar variaciones de puntuación.',
        library: ChartLibrary.flChart,
        level: ChartLevel.basic,
        chartType: 'Line chart',
        keywords: ['score', 'puntuación', 'línea', 'tendencia'],
        builder: (
          BuildContext context,
          ChartDataSource data,
        ) {
          return _scoreLine(data);
        },
      ),
      ChartDefinition(
        id: 'fl-basic-004',
        title: 'Capítulos por manga',
        description: 'Compara la cantidad de capítulos.',
        dataCompared: 'Chapters',
        idealFor: 'Comparar extensión.',
        library: ChartLibrary.flChart,
        level: ChartLevel.basic,
        chartType: 'Bar chart',
        keywords: ['chapters', 'capítulos', 'extensión'],
        builder: (
          BuildContext context,
          ChartDataSource data,
        ) {
          return _chaptersBars(data);
        },
      ),
      ChartDefinition(
        id: 'fl-basic-005',
        title: 'Volúmenes por manga',
        description: 'Compara el número de volúmenes.',
        dataCompared: 'Volumes',
        idealFor: 'Comparar cantidad de volúmenes.',
        library: ChartLibrary.flChart,
        level: ChartLevel.basic,
        chartType: 'Bar chart',
        keywords: ['volumes', 'volúmenes'],
        builder: (
          BuildContext context,
          ChartDataSource data,
        ) {
          return _volumesBars(data);
        },
      ),
      ChartDefinition(
        id: 'fl-basic-006',
        title: 'Distribución por género',
        description: 'Muestra la composición por género.',
        dataCompared: 'Genres',
        idealFor: 'Analizar géneros.',
        library: ChartLibrary.flChart,
        level: ChartLevel.basic,
        chartType: 'Pie chart',
        keywords: ['género', 'genres', 'distribución'],
        builder: (
          BuildContext context,
          ChartDataSource data,
        ) {
          return _genrePie(data);
        },
      ),
      ChartDefinition(
        id: 'fl-basic-007',
        title: 'Distribución por tipo',
        description: 'Muestra la composición por tipo.',
        dataCompared: 'Type',
        idealFor: 'Comparar tipos.',
        library: ChartLibrary.flChart,
        level: ChartLevel.basic,
        chartType: 'Pie chart',
        keywords: ['tipo', 'type', 'distribución'],
        builder: (
          BuildContext context,
          ChartDataSource data,
        ) {
          return _typePie(data);
        },
      ),
      ChartDefinition(
        id: 'fl-basic-008',
        title: 'Estado de publicación',
        description: 'Representa la distribución de estados.',
        dataCompared: 'Status',
        idealFor: 'Analizar estados.',
        library: ChartLibrary.flChart,
        level: ChartLevel.basic,
        chartType: 'Donut chart',
        keywords: ['status', 'estado', 'donut'],
        builder: (
          BuildContext context,
          ChartDataSource data,
        ) {
          return _statusDonut(data);
        },
      ),
      ChartDefinition(
        id: 'fl-basic-009',
        title: 'Puntuación frente a popularidad',
        description: 'Relaciona score y popularidad.',
        dataCompared: 'Score + Popularity',
        idealFor: 'Explorar relaciones.',
        library: ChartLibrary.flChart,
        level: ChartLevel.basic,
        chartType: 'Scatter chart',
        keywords: ['score', 'popularidad', 'scatter', 'relación'],
        builder: (
          BuildContext context,
          ChartDataSource data,
        ) {
          return _scorePopularityScatter(data);
        },
      ),
      ChartDefinition(
        id: 'fl-basic-010',
        title: 'Puntuación frente a capítulos',
        description: 'Relaciona score y capítulos.',
        dataCompared: 'Score + Chapters',
        idealFor: 'Comparar valoración y extensión.',
        library: ChartLibrary.flChart,
        level: ChartLevel.basic,
        chartType: 'Scatter chart',
        keywords: ['score', 'capítulos', 'scatter', 'relación'],
        builder: (
          BuildContext context,
          ChartDataSource data,
        ) {
          return _scoreChaptersScatter(data);
        },
      ),
    ];
  }

  static Widget _scoreBars(ChartDataSource data) {
    final values = data.scores.take(12).toList();

    if (values.isEmpty) {
      return _empty();
    }

    return _chart(
      BarChart(
        BarChartData(
          minY: 0,
          maxY: 10,
          barGroups: [
            for (int i = 0; i < values.length; i++)
              BarChartGroupData(
                x: i,
                barRods: [
                  BarChartRodData(
                    toY: values[i].value,
                    width: 18,
                    color: _colors[i % _colors.length],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  static Widget _popularityBars(ChartDataSource data) {
    final values = data.topPopularity.take(12).toList();

    if (values.isEmpty) {
      return _empty();
    }

    final maxValue = values
        .map((item) => item.value)
        .reduce((a, b) => a > b ? a : b);

    return _chart(
      BarChart(
        BarChartData(
          minY: 0,
          maxY: maxValue == 0 ? 1 : maxValue * 1.15,
          barGroups: [
            for (int i = 0; i < values.length; i++)
              BarChartGroupData(
                x: i,
                barRods: [
                  BarChartRodData(
                    toY: values[i].value,
                    width: 18,
                    color: _colors[(i + 2) % _colors.length],
                    borderRadius: BorderRadius.circular(3),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  static Widget _scoreLine(ChartDataSource data) {
    final values = data.scores.take(20).toList();

    if (values.isEmpty) {
      return _empty();
    }

    return _chart(
      LineChart(
        LineChartData(
          minY: 0,
          maxY: 10,
          lineBarsData: [
            LineChartBarData(
              spots: [
                for (int i = 0; i < values.length; i++)
                  FlSpot(
                    i.toDouble(),
                    values[i].value,
                  ),
              ],
              color: _colors[0],
              barWidth: 3,
              isCurved: true,
              dotData: const FlDotData(show: true),
              belowBarData: BarAreaData(show: true),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _chaptersBars(ChartDataSource data) {
    final values = data.topChapters.take(12).toList();

    if (values.isEmpty) {
      return _empty();
    }

    final maxValue = values
        .map((item) => item.value)
        .reduce((a, b) => a > b ? a : b);

    return _chart(
      BarChart(
        BarChartData(
          minY: 0,
          maxY: maxValue == 0 ? 1 : maxValue * 1.15,
          barGroups: [
            for (int i = 0; i < values.length; i++)
              BarChartGroupData(
                x: i,
                barRods: [
                  BarChartRodData(
                    toY: values[i].value,
                    width: 15,
                    color: _colors[(i + 3) % _colors.length],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  static Widget _volumesBars(ChartDataSource data) {
    final values = data.topVolumes.take(12).toList();

    if (values.isEmpty) {
      return _empty();
    }

    final maxValue = values
        .map((item) => item.value)
        .reduce((a, b) => a > b ? a : b);

    return _chart(
      BarChart(
        BarChartData(
          minY: 0,
          maxY: maxValue == 0 ? 1 : maxValue * 1.2,
          barGroups: [
            for (int i = 0; i < values.length; i++)
              BarChartGroupData(
                x: i,
                barRods: [
                  BarChartRodData(
                    toY: values[i].value,
                    width: 20,
                    color: _colors[(i + 4) % _colors.length],
                    borderRadius: BorderRadius.circular(5),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  static Widget _genrePie(ChartDataSource data) {
    final values = data.genres.take(7).toList();

    if (values.isEmpty) {
      return _empty();
    }

    return _chart(
      PieChart(
        PieChartData(
          sectionsSpace: 3,
          sections: [
            for (int i = 0; i < values.length; i++)
              PieChartSectionData(
                value: values[i].value,
                color: _colors[i % _colors.length],
                radius: 70,
                showTitle: false,
              ),
          ],
        ),
      ),
    );
  }

  static Widget _typePie(ChartDataSource data) {
    final values = data.types.take(6).toList();

    if (values.isEmpty) {
      return _empty();
    }

    return _chart(
      PieChart(
        PieChartData(
          sectionsSpace: 4,
          sections: [
            for (int i = 0; i < values.length; i++)
              PieChartSectionData(
                value: values[i].value,
                color: _colors[(i + 1) % _colors.length],
                radius: 75,
                showTitle: false,
              ),
          ],
        ),
      ),
    );
  }

  static Widget _statusDonut(ChartDataSource data) {
    final values = data.statuses.take(6).toList();

    if (values.isEmpty) {
      return _empty();
    }

    return _chart(
      PieChart(
        PieChartData(
          centerSpaceRadius: 42,
          sectionsSpace: 3,
          sections: [
            for (int i = 0; i < values.length; i++)
              PieChartSectionData(
                value: values[i].value,
                color: _colors[(i + 5) % _colors.length],
                radius: 72,
                showTitle: false,
              ),
          ],
        ),
      ),
    );
  }

  static Widget _scorePopularityScatter(
    ChartDataSource data,
  ) {
    final values = data.scorePopularity.take(25).toList();

    if (values.isEmpty) {
      return _empty();
    }

    final maxY = values
        .map((item) => item.y)
        .reduce((a, b) => a > b ? a : b);

    return _chart(
      ScatterChart(
        ScatterChartData(
          minX: 0,
          maxX: 10,
          minY: 0,
          maxY: maxY == 0 ? 1 : maxY * 1.1,
          scatterSpots: [
            for (final point in values)
              ScatterSpot(
                point.x,
                point.y,
                dotPainter: FlDotCirclePainter(
                  radius: 5,
                  color: _colors[1],
                ),
              ),
          ],
        ),
      ),
    );
  }

  static Widget _scoreChaptersScatter(
    ChartDataSource data,
  ) {
    final values = data.scoreChapters.take(25).toList();

    if (values.isEmpty) {
      return _empty();
    }

    final maxY = values
        .map((item) => item.y)
        .reduce((a, b) => a > b ? a : b);

    return _chart(
      ScatterChart(
        ScatterChartData(
          minX: 0,
          maxX: 10,
          minY: 0,
          maxY: maxY == 0 ? 1 : maxY * 1.1,
          scatterSpots: [
            for (final point in values)
              ScatterSpot(
                point.x,
                point.y,
                dotPainter: FlDotCirclePainter(
                  radius: 5,
                  color: _colors[2],
                ),
              ),
          ],
        ),
      ),
    );
  }

  static Widget _chart(Widget child) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: child,
    );
  }

  static Widget _empty() {
    return const Center(
      child: Text(
        'Sin datos suficientes',
        style: TextStyle(
          color: Colors.white54,
        ),
      ),
    );
  }
}