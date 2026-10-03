import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../models/chart_case.dart';
import '../../../models/chart_data_source.dart';
import '../../../models/chart_definition.dart';
import '../../../models/chart_library.dart';

class FlAdvancedCharts {
  static const _colors = [
    Color(0xFF8B5CF6),
    Color(0xFF22D3EE),
    Color(0xFFF472B6),
    Color(0xFF34D399),
    Color(0xFFFBBF24),
    Color(0xFF60A5FA),
  ];

  static List<ChartDefinition> all() {
    return [
      ChartDefinition(
        id: 'fl-advanced-001',
        title: 'Score y popularidad',
        description: 'Compara ambas métricas normalizadas.',
        dataCompared: 'Score + Popularity',
        idealFor: 'Comparaciones multiserie.',
        library: ChartLibrary.flChart,
        level: ChartLevel.advanced,
        chartType: 'Multi-series line',
        keywords: [
          'score',
          'popularidad',
          'multiserie',
          'avanzada',
        ],
        builder: (
          BuildContext context,
          ChartDataSource data,
        ) {
          return _scorePopularity(data);
        },
      ),
      ChartDefinition(
        id: 'fl-advanced-002',
        title: 'Capítulos y volúmenes',
        description: 'Compara dos métricas de extensión.',
        dataCompared: 'Chapters + Volumes',
        idealFor: 'Analizar tamaño editorial.',
        library: ChartLibrary.flChart,
        level: ChartLevel.advanced,
        chartType: 'Multi-series line',
        keywords: [
          'capítulos',
          'volúmenes',
          'multiserie',
        ],
        builder: (
          BuildContext context,
          ChartDataSource data,
        ) {
          return _chaptersVolumes(data);
        },
      ),
      ChartDefinition(
        id: 'fl-advanced-003',
        title: 'Perfil de cuatro métricas',
        description: 'Compara score, popularidad, capítulos y volúmenes.',
        dataCompared: 'Score + Popularity + Chapters + Volumes',
        idealFor: 'Perfil cuantitativo.',
        library: ChartLibrary.flChart,
        level: ChartLevel.advanced,
        chartType: 'Grouped bar',
        keywords: [
          'métricas',
          'barras agrupadas',
          'multiserie',
        ],
        builder: (
          BuildContext context,
          ChartDataSource data,
        ) {
          return _metricGroups(data);
        },
      ),
      ChartDefinition(
        id: 'fl-advanced-004',
        title: 'Publicaciones por año',
        description: 'Separa mangas con y sin puntuación.',
        dataCompared: 'Year + Score availability',
        idealFor: 'Analizar evolución temporal.',
        library: ChartLibrary.flChart,
        level: ChartLevel.advanced,
        chartType: 'Stacked bar',
        keywords: [
          'año',
          'publicación',
          'stacked',
          'apilado',
        ],
        builder: (
          BuildContext context,
          ChartDataSource data,
        ) {
          return _yearStacked(data);
        },
      ),
      ChartDefinition(
        id: 'fl-advanced-005',
        title: 'Score promedio por año',
        description: 'Calcula el promedio de score por año.',
        dataCompared: 'Year + Average Score',
        idealFor: 'Estudiar evolución temporal.',
        library: ChartLibrary.flChart,
        level: ChartLevel.advanced,
        chartType: 'Line chart',
        keywords: [
          'año',
          'score',
          'promedio',
          'tendencia',
        ],
        builder: (
          BuildContext context,
          ChartDataSource data,
        ) {
          return _yearAverage(data);
        },
      ),
      ChartDefinition(
        id: 'fl-advanced-006',
        title: 'Distribución de géneros',
        description: 'Usa barras para comparar la frecuencia de géneros.',
        dataCompared: 'Genre frequency',
        idealFor: 'Analizar concentración de géneros.',
        library: ChartLibrary.flChart,
        level: ChartLevel.advanced,
        chartType: 'Horizontal bar',
        keywords: [
          'géneros',
          'frecuencia',
          'horizontal',
          'ranking',
        ],
        builder: (
          BuildContext context,
          ChartDataSource data,
        ) {
          return _genreBars(data);
        },
      ),
      ChartDefinition(
        id: 'fl-advanced-007',
        title: 'Score frente a popularidad',
        description: 'Muestra la relación entre las dos variables.',
        dataCompared: 'Score + Popularity',
        idealFor: 'Análisis de correlación visual.',
        library: ChartLibrary.flChart,
        level: ChartLevel.advanced,
        chartType: 'Scatter chart',
        keywords: [
          'scatter',
          'correlación',
          'score',
          'popularidad',
        ],
        builder: (
          BuildContext context,
          ChartDataSource data,
        ) {
          return _scorePopularityScatter(data);
        },
      ),
      ChartDefinition(
        id: 'fl-advanced-008',
        title: 'Popularidad frente a capítulos',
        description: 'Relaciona popularidad y extensión.',
        dataCompared: 'Popularity + Chapters',
        idealFor: 'Analizar relación entre métricas.',
        library: ChartLibrary.flChart,
        level: ChartLevel.advanced,
        chartType: 'Scatter chart',
        keywords: [
          'scatter',
          'popularidad',
          'capítulos',
        ],
        builder: (
          BuildContext context,
          ChartDataSource data,
        ) {
          return _popularityChaptersScatter(data);
        },
      ),
      ChartDefinition(
        id: 'fl-advanced-009',
        title: 'Estados de publicación',
        description: 'Presenta la distribución de estados en un donut.',
        dataCompared: 'Status',
        idealFor: 'Analizar composición.',
        library: ChartLibrary.flChart,
        level: ChartLevel.advanced,
        chartType: 'Donut',
        keywords: [
          'status',
          'estado',
          'donut',
          'composición',
        ],
        builder: (
          BuildContext context,
          ChartDataSource data,
        ) {
          return _statusDonut(data);
        },
      ),
      ChartDefinition(
        id: 'fl-advanced-010',
        title: 'Dashboard general',
        description: 'Integra score, popularidad y capítulos.',
        dataCompared: 'Score + Popularity + Chapters',
        idealFor: 'Resumen analítico.',
        library: ChartLibrary.flChart,
        level: ChartLevel.advanced,
        chartType: 'Dashboard',
        keywords: [
          'dashboard',
          'panel',
          'resumen',
          'analítica',
        ],
        builder: (
          BuildContext context,
          ChartDataSource data,
        ) {
          return _dashboard(data);
        },
      ),
    ];
  }

  static Widget _scorePopularity(
    ChartDataSource data,
  ) {
    final values = data.manga
        .where(
          (manga) =>
              manga.score != null &&
              manga.popularity != null,
        )
        .take(15)
        .toList();

    if (values.isEmpty) {
      return _empty();
    }

    int maxPopularity = 1;

    for (final manga in values) {
      final popularity = manga.popularity ?? 0;

      if (popularity > maxPopularity) {
        maxPopularity = popularity;
      }
    }

    return _chart(
      LineChart(
        LineChartData(
          minY: 0,
          maxY: 100,
          lineBarsData: [
            LineChartBarData(
              spots: [
                for (int i = 0; i < values.length; i++)
                  FlSpot(
                    i.toDouble(),
                    (values[i].score! * 10)
                        .clamp(0.0, 100.0),
                  ),
              ],
              color: _colors[0],
              barWidth: 4,
              isCurved: true,
            ),
            LineChartBarData(
              spots: [
                for (int i = 0; i < values.length; i++)
                  FlSpot(
                    i.toDouble(),
                    ((values[i].popularity ?? 0) /
                            maxPopularity *
                            100)
                        .clamp(0.0, 100.0),
                  ),
              ],
              color: _colors[1],
              barWidth: 3,
              isCurved: false,
            ),
          ],
        ),
      ),
    );
  }

  static Widget _chaptersVolumes(
    ChartDataSource data,
  ) {
    final values = data.manga
        .where(
          (manga) =>
              manga.chapters != null &&
              manga.volumes != null,
        )
        .take(15)
        .toList();

    if (values.isEmpty) {
      return _empty();
    }

    int maxChapters = 1;
    int maxVolumes = 1;

    for (final manga in values) {
      final chapters = manga.chapters ?? 0;
      final volumes = manga.volumes ?? 0;

      if (chapters > maxChapters) {
        maxChapters = chapters;
      }

      if (volumes > maxVolumes) {
        maxVolumes = volumes;
      }
    }

    return _chart(
      LineChart(
        LineChartData(
          minY: 0,
          maxY: 100,
          lineBarsData: [
            LineChartBarData(
              spots: [
                for (int i = 0; i < values.length; i++)
                  FlSpot(
                    i.toDouble(),
                    ((values[i].chapters ?? 0) /
                            maxChapters *
                            100)
                        .clamp(0.0, 100.0),
                  ),
              ],
              color: _colors[2],
              barWidth: 4,
              isCurved: true,
            ),
            LineChartBarData(
              spots: [
                for (int i = 0; i < values.length; i++)
                  FlSpot(
                    i.toDouble(),
                    ((values[i].volumes ?? 0) /
                            maxVolumes *
                            100)
                        .clamp(0.0, 100.0),
                  ),
              ],
              color: _colors[3],
              barWidth: 3,
              isCurved: true,
            ),
          ],
        ),
      ),
    );
  }

  static Widget _metricGroups(
    ChartDataSource data,
  ) {
    final values = data.manga.take(10).toList();

    if (values.isEmpty) {
      return _empty();
    }

    int maxPopularity = 1;
    int maxChapters = 1;
    int maxVolumes = 1;

    for (final manga in values) {
      final popularity = manga.popularity ?? 0;
      final chapters = manga.chapters ?? 0;
      final volumes = manga.volumes ?? 0;

      if (popularity > maxPopularity) {
        maxPopularity = popularity;
      }

      if (chapters > maxChapters) {
        maxChapters = chapters;
      }

      if (volumes > maxVolumes) {
        maxVolumes = volumes;
      }
    }

    return _chart(
      BarChart(
        BarChartData(
          minY: 0,
          maxY: 100,
          barGroups: [
            for (int i = 0; i < values.length; i++)
              BarChartGroupData(
                x: i,
                barsSpace: 4,
                barRods: [
                  BarChartRodData(
                    toY: ((values[i].score ?? 0) * 10)
                        .clamp(0.0, 100.0),
                    width: 7,
                    color: _colors[0],
                  ),
                  BarChartRodData(
                    toY: ((values[i].popularity ?? 0) /
                            maxPopularity *
                            100)
                        .clamp(0.0, 100.0),
                    width: 7,
                    color: _colors[1],
                  ),
                  BarChartRodData(
                    toY: ((values[i].chapters ?? 0) /
                            maxChapters *
                            100)
                        .clamp(0.0, 100.0),
                    width: 7,
                    color: _colors[2],
                  ),
                  BarChartRodData(
                    toY: ((values[i].volumes ?? 0) /
                            maxVolumes *
                            100)
                        .clamp(0.0, 100.0),
                    width: 7,
                    color: _colors[3],
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  static Widget _yearStacked(
    ChartDataSource data,
  ) {
    final scored = <int, int>{};
    final unscored = <int, int>{};

    for (final manga in data.manga) {
      final year = manga.publishedFrom?.year;

      if (year == null) {
        continue;
      }

      if (manga.score != null) {
        scored[year] = (scored[year] ?? 0) + 1;
      } else {
        unscored[year] = (unscored[year] ?? 0) + 1;
      }
    }

    final years = <int>{
      ...scored.keys,
      ...unscored.keys,
    }.toList()
      ..sort();

    if (years.isEmpty) {
      return _empty();
    }

    return _chart(
      BarChart(
        BarChartData(
          minY: 0,
          barGroups: [
            for (int i = 0; i < years.length; i++)
              BarChartGroupData(
                x: i,
                barRods: [
                  BarChartRodData(
                    toY: ((scored[years[i]] ?? 0) +
                            (unscored[years[i]] ?? 0))
                        .toDouble(),
                    rodStackItems: [
                      BarChartRodStackItem(
                        0,
                        (scored[years[i]] ?? 0)
                            .toDouble(),
                        _colors[0],
                      ),
                      BarChartRodStackItem(
                        (scored[years[i]] ?? 0)
                            .toDouble(),
                        ((scored[years[i]] ?? 0) +
                                (unscored[years[i]] ?? 0))
                            .toDouble(),
                        _colors[4],
                      ),
                    ],
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  static Widget _yearAverage(
    ChartDataSource data,
  ) {
    final grouped = <int, List<double>>{};

    for (final manga in data.manga) {
      final year = manga.publishedFrom?.year;

      if (year == null || manga.score == null) {
        continue;
      }

      grouped.putIfAbsent(year, () => []);
      grouped[year]!.add(manga.score!);
    }

    final years = grouped.keys.toList()..sort();

    if (years.isEmpty) {
      return _empty();
    }

    final spots = <FlSpot>[];

    for (int i = 0; i < years.length; i++) {
      final scores = grouped[years[i]]!;

      double total = 0;

      for (final score in scores) {
        total += score;
      }

      final average = total / scores.length;

      spots.add(
        FlSpot(
          i.toDouble(),
          average,
        ),
      );
    }

    return _chart(
      LineChart(
        LineChartData(
          minY: 0,
          maxY: 10,
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              color: _colors[5],
              barWidth: 4,
              isCurved: true,
              dotData: const FlDotData(show: true),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _genreBars(
    ChartDataSource data,
  ) {
    final values = data.genres.take(10).toList();

    if (values.isEmpty) {
      return _empty();
    }

    return _chart(
      BarChart(
        BarChartData(
          minY: 0,
          barGroups: [
            for (int i = 0; i < values.length; i++)
              BarChartGroupData(
                x: i,
                barRods: [
                  BarChartRodData(
                    toY: values[i].value,
                    width: 20,
                    color: _colors[i % _colors.length],
                    borderRadius: BorderRadius.circular(3),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  static Widget _scorePopularityScatter(
    ChartDataSource data,
  ) {
    final values = data.scorePopularity.take(30).toList();

    if (values.isEmpty) {
      return _empty();
    }

    double maxY = 1;

    for (final point in values) {
      if (point.y > maxY) {
        maxY = point.y;
      }
    }

    return _chart(
      ScatterChart(
        ScatterChartData(
          minX: 0,
          maxX: 10,
          minY: 0,
          maxY: maxY * 1.1,
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

  static Widget _popularityChaptersScatter(
    ChartDataSource data,
  ) {
    final values =
        data.popularityChapters.take(30).toList();

    if (values.isEmpty) {
      return _empty();
    }

    double maxX = 1;
    double maxY = 1;

    for (final point in values) {
      if (point.x > maxX) {
        maxX = point.x;
      }

      if (point.y > maxY) {
        maxY = point.y;
      }
    }

    return _chart(
      ScatterChart(
        ScatterChartData(
          minX: 0,
          maxX: maxX * 1.1,
          minY: 0,
          maxY: maxY * 1.1,
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

  static Widget _statusDonut(
    ChartDataSource data,
  ) {
    final values = data.statuses.take(6).toList();

    if (values.isEmpty) {
      return _empty();
    }

    return _chart(
      PieChart(
        PieChartData(
          centerSpaceRadius: 45,
          sectionsSpace: 3,
          sections: [
            for (int i = 0; i < values.length; i++)
              PieChartSectionData(
                value: values[i].value,
                color: _colors[i % _colors.length],
                radius: 75,
                showTitle: false,
              ),
          ],
        ),
      ),
    );
  }

  static Widget _dashboard(
    ChartDataSource data,
  ) {
    return Column(
      children: [
        Expanded(
          child: _scorePopularity(data),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: _metricGroups(data),
        ),
      ],
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