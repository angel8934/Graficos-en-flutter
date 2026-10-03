import 'package:charts_painter/chart.dart' as cp;
import 'package:fast_charts/fast_charts.dart' as fast;
import 'package:fl_chart/fl_chart.dart' as fl;
import 'package:flutter/material.dart';
import 'package:fusion_charts_flutter/fusion_charts_flutter.dart' as fusion;
import 'package:graphic/graphic.dart' as graphic;
import 'package:syncfusion_flutter_charts/charts.dart' as sf;


import '../models/manga.dart';

import '../models/chart_case.dart';
import '../models/chart_data_source.dart';
import '../models/chart_definition.dart';
import '../models/chart_library.dart';
import 'chart_recipe.dart';
import 'chart_recipe_catalog.dart';

class GeneratedChartFactory {
  static const List<Color> _colors = [
    Color(0xFF8B5CF6),
    Color(0xFF22D3EE),
    Color(0xFFF472B6),
    Color(0xFF34D399),
    Color(0xFFFBBF24),
    Color(0xFF60A5FA),
  ];

  static List<ChartDefinition> forLibrary(
    ChartLibrary library,
  ) {
    final result = <ChartDefinition>[];

    final basicRecipes = ChartRecipeCatalog.basic();
    final advancedRecipes = ChartRecipeCatalog.advanced();

    for (final recipe in basicRecipes) {
      result.add(
        _definition(
          library: library,
          recipe: recipe,
        ),
      );
    }

    for (final recipe in advancedRecipes) {
      result.add(
        _definition(
          library: library,
          recipe: recipe,
        ),
      );
    }

    return result;
  }

  static ChartDefinition _definition({
    required ChartLibrary library,
    required ChartRecipe recipe,
  }) {
    return ChartDefinition(
      id:
          '${library.folder}-${recipe.level == ChartLevel.basic ? 'basic' : 'advanced'}-${(recipe.index + 1).toString().padLeft(2, '0')}',
      title: _title(
        library,
        recipe,
      ),
      description: _description(
        library,
        recipe,
      ),
      dataCompared: _dataCompared(recipe),
      idealFor: _idealFor(recipe),
      library: library,
      level: recipe.level,
      chartType: _chartType(
        library,
        recipe,
      ),
      keywords: _keywords(
        library,
        recipe,
      ),
      builder: (
        BuildContext context,
        ChartDataSource data,
      ) {
        return _render(
          library: library,
          recipe: recipe,
          data: data,
        );
      },
    );
  }

  static String _title(
    ChartLibrary library,
    ChartRecipe recipe,
  ) {
    return '${recipe.level == ChartLevel.basic ? 'Básico' : 'Avanzado'} ${recipe.index + 1}: ${_metricTitle(recipe)} - ${library.name}';
  }

  static String _description(
    ChartLibrary library,
    ChartRecipe recipe,
  ) {
    final second = recipe.metricB == null
        ? ''
        : ' y ${_metricLabel(recipe.metricB!)}';

    final third = recipe.metricC == null
        ? ''
        : ', ${_metricLabel(recipe.metricC!)}';

    return '${_chartType(library, recipe)} de ${_metricLabel(recipe.metricA)}$second$third usando datos reales de manga.';
  }

  static String _metricTitle(
    ChartRecipe recipe,
  ) {
    final parts = <String>[
      _metricLabel(recipe.metricA),
    ];

    if (recipe.metricB != null) {
      parts.add(
        _metricLabel(recipe.metricB!),
      );
    }

    if (recipe.metricC != null) {
      parts.add(
        _metricLabel(recipe.metricC!),
      );
    }

    return parts.join(' + ');
  }

  static String _dataCompared(
    ChartRecipe recipe,
  ) {
    final parts = <String>[
      _metricLabel(recipe.metricA),
    ];

    if (recipe.metricB != null) {
      parts.add(
        _metricLabel(recipe.metricB!),
      );
    }

    if (recipe.metricC != null) {
      parts.add(
        _metricLabel(recipe.metricC!),
      );
    }

    return parts.join(' + ');
  }

  static String _idealFor(
    ChartRecipe recipe,
  ) {
    switch (recipe.type) {
      case 'bar':
      case 'grouped_bar':
        return 'comparaciones cuantitativas';

      case 'line':
      case 'multi_line':
      case 'year_score':
      case 'year_popularity':
      case 'year_chapters':
      case 'year_volumes':
        return 'tendencias y evolución';

      case 'pie':
      case 'donut':
        return 'composición de categorías';

      case 'scatter':
      case 'scatter_line':
      case 'bubble':
        return 'relaciones entre variables';

      case 'stacked_bar':
        return 'composición multiserie';

      case 'genre_score':
      case 'genre_popularity':
      case 'type_score':
      case 'status_score':
        return 'comparaciones agrupadas';

      case 'pareto':
        return 'concentración de categorías';

      case 'radar':
        return 'perfil multidimensional';

      case 'dashboard':
      case 'multi_view':
        return 'resumen analítico';

      default:
        return recipe.interactive
            ? 'exploración interactiva'
            : 'análisis de datos';
    }
  }

  static String _chartType(
    ChartLibrary library,
    ChartRecipe recipe,
  ) {
    switch (library) {
      case ChartLibrary.flChart:
        switch (recipe.type) {
          case 'bar':
            return 'Bar';
          case 'line':
          case 'year_score':
          case 'year_popularity':
          case 'year_chapters':
          case 'year_volumes':
            return 'Line';
          case 'pie':
          case 'genre_score':
          case 'genre_popularity':
          case 'type_score':
          case 'status_score':
            return 'Pie';
          case 'donut':
            return 'Donut';
          case 'scatter':
          case 'bubble':
            return 'Scatter';
          case 'grouped_bar':
            return 'Grouped Bar';
          case 'stacked_bar':
            return 'Stacked Bar';
          case 'multi_line':
            return 'Multi-series Line';
          case 'scatter_line':
            return 'Scatter + Line';
          case 'pareto':
            return 'Bar + Line';
          case 'dashboard':
          case 'multi_view':
            return 'Dashboard';
          default:
            return 'Composite';
        }

      case ChartLibrary.graphic:
        switch (recipe.type) {
          case 'bar':
            return 'Interval';
          case 'line':
          case 'year_score':
          case 'year_popularity':
          case 'year_chapters':
          case 'year_volumes':
            return 'Line';
          case 'pie':
          case 'donut':
            return 'Point';
          case 'scatter':
          case 'bubble':
            return 'Point';
          case 'area':
            return 'Area';
          case 'line_point':
            return 'Line + Point';
          case 'interval_tooltip':
            return 'Interval + Tooltip';
          case 'area_selection':
            return 'Area + Selection';
          case 'multi_view':
            return 'Multi-view';
          case 'interactive_line':
            return 'Interactive Line';
          case 'dashboard':
            return 'Dashboard';
          default:
            return 'Composite';
        }

      case ChartLibrary.syncfusion:
        switch (recipe.type) {
          case 'bar':
            return 'Column';
          case 'grouped_bar':
            return 'Bar';
          case 'line':
          case 'year_score':
          case 'year_popularity':
          case 'year_chapters':
          case 'year_volumes':
            return 'Line';
          case 'pie':
            return 'Pie';
          case 'donut':
            return 'Doughnut';
          case 'scatter':
          case 'bubble':
            return 'Scatter';
          case 'stacked_bar':
            return 'Stacked Bar';
          case 'multi_line':
            return 'Multi-series Line';
          case 'dashboard':
            return 'Dashboard';
          default:
            return 'Composite';
        }

      case ChartLibrary.chartsPainter:
        switch (recipe.type) {
          case 'bar':
          case 'grouped_bar':
          case 'stacked_bar':
            return 'Bar';
          case 'line':
          case 'multi_line':
            return 'Line';
          case 'bubble':
          case 'scatter':
            return 'Bubble';
          case 'dashboard':
            return 'Dashboard';
          default:
            return 'Composite';
        }

      case ChartLibrary.fusionCharts:
        switch (recipe.type) {
          case 'line':
          case 'year_score':
          case 'year_popularity':
          case 'year_chapters':
          case 'year_volumes':
            return 'Line';
          case 'multi_line':
            return 'Multi-series Line';
          case 'bar':
            return 'Bar';
          case 'grouped_bar':
            return 'Grouped Bar';
          case 'stacked_bar':
            return 'Stacked Bar';
          case 'pie':
            return 'Pie';
          case 'donut':
            return 'Donut';
          case 'dashboard':
            return 'Dashboard';
          default:
            return 'Composite';
        }

      case ChartLibrary.fastCharts:
        switch (recipe.type) {
          case 'bar':
          case 'grouped_bar':
            return 'Grouped Bar';
          case 'stacked_bar':
            return 'Stacked Bar';
          case 'radial':
          case 'radar':
            return 'Radial';
          case 'pie':
          case 'donut':
            return 'Pie';
          case 'multi_line':
          case 'grouped_multi':
            return 'Grouped Multi-series';
          case 'stacked_multi':
            return 'Stacked Multi-series';
          case 'radial_multi':
            return 'Radial Multi-series';
          case 'dashboard':
            return 'Dashboard';
          default:
            return 'Composite';
        }
    }
  }

  static List<String> _keywords(
    ChartLibrary library,
    ChartRecipe recipe,
  ) {
    final result = <String>{
      library.name.toLowerCase(),
      library.folder,
      recipe.level == ChartLevel.basic
          ? 'basico'
          : 'avanzado',
      recipe.type,
      recipe.metricA,
      'manga',
      'grafica',
      'visualizacion',
    };

    if (recipe.metricB != null) {
      result.add(recipe.metricB!);
    }

    if (recipe.metricC != null) {
      result.add(recipe.metricC!);
    }

    final metricLabels = [
      recipe.metricA,
      recipe.metricB,
      recipe.metricC,
    ];

    for (final metric in metricLabels) {
      if (metric == null) {
        continue;
      }

      switch (metric) {
        case 'score':
          result.addAll([
            'score',
            'puntuacion',
            'calificacion',
          ]);
          break;

        case 'popularity':
          result.addAll([
            'popularity',
            'popularidad',
          ]);
          break;

        case 'chapters':
          result.addAll([
            'chapters',
            'capitulos',
          ]);
          break;

        case 'volumes':
          result.addAll([
            'volumes',
            'volumenes',
          ]);
          break;

        case 'ranking':
          result.addAll([
            'ranking',
            'rank',
          ]);
          break;

        case 'genres':
          result.addAll([
            'genres',
            'generos',
            'genero',
          ]);
          break;

        case 'types':
          result.addAll([
            'types',
            'tipos',
            'tipo',
          ]);
          break;

        case 'statuses':
          result.addAll([
            'statuses',
            'estados',
            'estado',
          ]);
          break;

        case 'authors':
          result.addAll([
            'authors',
            'autores',
            'autor',
          ]);
          break;

        case 'year':
          result.addAll([
            'year',
            'anio',
            'ano',
          ]);
          break;
      }
    }

    if (recipe.interactive) {
      result.addAll([
        'interactivo',
        'interactiva',
        'tooltip',
        'seleccion',
      ]);
    }

    if (recipe.grouped) {
      result.addAll([
        'agrupado',
        'grouped',
        'multiserie',
      ]);
    }

    if (recipe.stacked) {
      result.addAll([
        'apilado',
        'stacked',
      ]);
    }

    if (recipe.filled) {
      result.addAll([
        'area',
        'relleno',
      ]);
    }

    return result.toList();
  }

  static String _metricLabel(
    String metric,
  ) {
    switch (metric) {
      case 'score':
        return 'Score';
      case 'popularity':
        return 'Popularidad';
      case 'chapters':
        return 'Capítulos';
      case 'volumes':
        return 'Volúmenes';
      case 'ranking':
        return 'Ranking';
      case 'genres':
        return 'Géneros';
      case 'types':
        return 'Tipos';
      case 'statuses':
        return 'Estados';
      case 'authors':
        return 'Autores';
      case 'year':
        return 'Año';
      default:
        return metric;
    }
  }

  static Widget _render({
    required ChartLibrary library,
    required ChartRecipe recipe,
    required ChartDataSource data,
  }) {
    switch (library) {
      case ChartLibrary.flChart:
        return _renderFl(
          recipe,
          data,
        );

      case ChartLibrary.graphic:
        return _renderGraphic(
          recipe,
          data,
        );

      case ChartLibrary.syncfusion:
        return _renderSyncfusion(
          recipe,
          data,
        );

      case ChartLibrary.chartsPainter:
        return _renderChartsPainter(
          recipe,
          data,
        );

      case ChartLibrary.fusionCharts:
        return _renderFusion(
          recipe,
          data,
        );

      case ChartLibrary.fastCharts:
        return _renderFast(
          recipe,
          data,
        );
    }
  }

  static List<double> _values(
    ChartDataSource data,
    String metric,
  ) {
    switch (metric) {
      case 'score':
        return data.scores
            .take(12)
            .map((item) => item.value)
            .toList();

      case 'popularity':
        return data.popularity
            .take(12)
            .map((item) => item.value)
            .toList();

      case 'chapters':
        return data.chapters
            .take(12)
            .map((item) => item.value)
            .toList();

      case 'volumes':
        return data.volumes
            .take(12)
            .map((item) => item.value)
            .toList();

      case 'ranking':
        return data.rankings
            .take(12)
            .map((item) => item.value)
            .toList();

      case 'genres':
        return data.genres
            .take(12)
            .map((item) => item.value)
            .toList();

      case 'types':
        return data.types
            .take(12)
            .map((item) => item.value)
            .toList();

      case 'statuses':
        return data.statuses
            .take(12)
            .map((item) => item.value)
            .toList();

      case 'authors':
        return data.authors
            .take(12)
            .map((item) => item.value)
            .toList();

      default:
        return [];
    }
  }

  static List<ChartCategory> _categories(
    ChartDataSource data,
    String metric,
  ) {
    switch (metric) {
      case 'genres':
        return data.genres.take(10).toList();

      case 'types':
        return data.types.take(10).toList();

      case 'statuses':
        return data.statuses.take(10).toList();

      case 'authors':
        return data.authors.take(10).toList();

      default:
        return [];
    }
  }

  static List<ChartPair> _pairs(
    ChartDataSource data,
    String a,
    String b,
  ) {
    if (a == 'score' && b == 'popularity') {
      return data.scorePopularity
          .take(25)
          .toList();
    }

    if (a == 'score' && b == 'chapters') {
      return data.scoreChapters
          .take(25)
          .toList();
    }

    if (a == 'popularity' && b == 'chapters') {
      return data.popularityChapters
          .take(25)
          .toList();
    }

    if (a == 'chapters' && b == 'volumes') {
      return data.manga
          .where(
            (item) =>
                item.chapters != null &&
                item.volumes != null,
          )
          .take(25)
          .map(
            (item) => ChartPair(
              label: item.title,
              x: item.chapters!.toDouble(),
              y: item.volumes!.toDouble(),
            ),
          )
          .toList();
    }

    if (a == 'score' && b == 'volumes') {
      return data.manga
          .where(
            (item) =>
                item.score != null &&
                item.volumes != null,
          )
          .take(25)
          .map(
            (item) => ChartPair(
              label: item.title,
              x: item.score!,
              y: item.volumes!.toDouble(),
            ),
          )
          .toList();
    }

    return const [];
  }

  static List<double> _normalized(
    List<double> values,
  ) {
    if (values.isEmpty) {
      return [];
    }

    double maxValue = 0;

    for (final value in values) {
      if (value > maxValue) {
        maxValue = value;
      }
    }

    if (maxValue == 0) {
      return List<double>.filled(
        values.length,
        0,
      );
    }

    return values
        .map(
          (value) => value / maxValue * 100,
        )
        .toList();
  }

  static List<_YearPoint> _yearMetric(
    ChartDataSource data,
    String metric,
  ) {
    final grouped = <int, List<double>>{};

    for (final manga in data.manga) {
      final year =
          manga.publishedFrom?.year;

      if (year == null) {
        continue;
      }

      double? value;

      switch (metric) {
        case 'score':
          value = manga.score;
          break;

        case 'popularity':
          value =
              manga.popularity?.toDouble();
          break;

        case 'chapters':
          value =
              manga.chapters?.toDouble();
          break;

        case 'volumes':
          value =
              manga.volumes?.toDouble();
          break;
      }

      if (value == null) {
        continue;
      }

      grouped.putIfAbsent(
        year,
        () => [],
      );

      grouped[year]!.add(value);
    }

    final years = grouped.keys.toList()
      ..sort();

    final result = <_YearPoint>[];

    for (final year in years) {
      final values = grouped[year]!;

      double total = 0;

      for (final value in values) {
        total += value;
      }

      result.add(
        _YearPoint(
          year: year,
          value: total / values.length,
        ),
      );
    }

    return result;
  }

  static List<_CategoryMetric> _categoryMetric(
    ChartDataSource data,
    String category,
    String metric,
  ) {
    final groups =
        <String, List<double>>{};

    for (final manga in data.manga) {
      final values = _categoryValues(
        manga,
        category,
      );

      double? metricValue;

      switch (metric) {
        case 'score':
          metricValue = manga.score;
          break;

        case 'popularity':
          metricValue =
              manga.popularity?.toDouble();
          break;

        case 'chapters':
          metricValue =
              manga.chapters?.toDouble();
          break;

        case 'volumes':
          metricValue =
              manga.volumes?.toDouble();
          break;
      }

      if (metricValue == null) {
        continue;
      }

      for (final value in values) {
        groups.putIfAbsent(
          value,
          () => [],
        );

        groups[value]!.add(metricValue);
      }
    }

    final result = <_CategoryMetric>[];

    for (final entry in groups.entries) {
      double total = 0;

      for (final value in entry.value) {
        total += value;
      }

      result.add(
        _CategoryMetric(
          label: entry.key,
          value: total / entry.value.length,
        ),
      );
    }

    result.sort(
      (a, b) => b.value.compareTo(a.value),
    );

    return result.take(10).toList();
  }

  static List<String> _categoryValues(
    Manga manga,
    String category,
  ) {
    switch (category) {
      case 'genres':
        return manga.genres;

      case 'types':
        return manga.type == null
            ? const []
            : [manga.type!];

      case 'statuses':
        return manga.status == null
            ? const []
            : [manga.status!];

      case 'authors':
        return manga.authors;

      default:
        return const [];
    }
  }

  static Widget _empty() {
    return const Center(
      child: Text(
        'Sin datos',
        style: TextStyle(
          color: Colors.white54,
        ),
      ),
    );
  }

  static Widget _renderFl(
    ChartRecipe recipe,
    ChartDataSource data,
  ) {
    final values = _values(
      data,
      recipe.metricA,
    );

    final secondValues = recipe.metricB == null
        ? const <double>[]
        : _values(
            data,
            recipe.metricB!,
          );

    switch (recipe.type) {
      case 'bar':
        if (values.isEmpty) {
          return _empty();
        }

        return fl.BarChart(
          fl.BarChartData(
            minY: 0,
            maxY: _safeMax(values),
            barGroups: [
              for (int i = 0;
                  i < values.length;
                  i++)
                fl.BarChartGroupData(
                  x: i,
                  barRods: [
                    fl.BarChartRodData(
                      toY: values[i],
                      width:
                          recipe.grouped
                              ? 12
                              : 18,
                      color:
                          _colors[
                              i %
                                  _colors.length],
                      borderRadius:
                          BorderRadius.circular(
                        recipe.stacked
                            ? 2
                            : 5,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        );

      case 'grouped_bar':
        if (values.isEmpty) {
          return _empty();
        }

        return fl.BarChart(
          fl.BarChartData(
            minY: 0,
            maxY: _safeMax([
              ...values,
              ...secondValues,
            ]),
            barGroups: [
              for (int i = 0;
                  i < values.length;
                  i++)
                fl.BarChartGroupData(
                  x: i,
                  barsSpace: 4,
                  barRods: [
                    fl.BarChartRodData(
                      toY: values[i],
                      width: 8,
                      color: _colors[0],
                    ),
                    if (i <
                        secondValues.length)
                      fl.BarChartRodData(
                        toY: secondValues[i],
                        width: 8,
                        color: _colors[1],
                      ),
                    if (recipe.metricC != null)
                      ..._thirdRod(
                        data,
                        recipe.metricC!,
                        i,
                      ),
                  ],
                ),
            ],
          ),
        );

      case 'stacked_bar':
        if (values.isEmpty) {
          return _empty();
        }

        return fl.BarChart(
          fl.BarChartData(
            minY: 0,
            maxY: _safeMax([
              ...values,
              ...secondValues,
            ]),
            barGroups: [
              for (int i = 0;
                  i < values.length;
                  i++)
                fl.BarChartGroupData(
                  x: i,
                  barRods: [
                    fl.BarChartRodData(
                      toY: (
                        values[i] +
                            (i <
                                    secondValues
                                        .length
                                ? secondValues[i]
                                : 0)
                      ),
                      rodStackItems: [
                        fl.BarChartRodStackItem(
                          0,
                          values[i],
                          _colors[0],
                        ),
                        if (i <
                            secondValues.length)
                          fl.BarChartRodStackItem(
                            values[i],
                            values[i] +
                                secondValues[i],
                            _colors[1],
                          ),
                      ],
                    ),
                  ],
                ),
            ],
          ),
        );

      case 'line':
      case 'year_score':
      case 'year_popularity':
      case 'year_chapters':
      case 'year_volumes':
        final yearValues = recipe.type
                .startsWith('year_')
            ? _yearMetric(
                data,
                recipe.metricA,
              )
            : const <_YearPoint>[];

        final lineValues = yearValues.isNotEmpty
            ? [
                for (final item in yearValues)
                  item.value,
              ]
            : values;

        if (lineValues.isEmpty) {
          return _empty();
        }

        return fl.LineChart(
          fl.LineChartData(
            minY: 0,
            maxY: _safeMax(lineValues),
            lineBarsData: [
              fl.LineChartBarData(
                spots: [
                  for (int i = 0;
                      i < lineValues.length;
                      i++)
                    fl.FlSpot(
                      i.toDouble(),
                      lineValues[i],
                    ),
                ],
                color: _colors[0],
                barWidth: 3.5,
                isCurved: recipe.curved,
                dotData:
                    const fl.FlDotData(
                  show: true,
                ),
                belowBarData:
                    fl.BarAreaData(
                  show: recipe.filled,
                ),
              ),
            ],
          ),
        );

      case 'multi_line':
        if (values.isEmpty) {
          return _empty();
        }

        return fl.LineChart(
          fl.LineChartData(
            minY: 0,
            maxY: _safeMax([
              ...values,
              ...secondValues,
            ]),
            lineBarsData: [
              fl.LineChartBarData(
                spots: [
                  for (int i = 0;
                      i < values.length;
                      i++)
                    fl.FlSpot(
                      i.toDouble(),
                      values[i],
                    ),
                ],
                color: _colors[0],
                barWidth: 3,
                isCurved: recipe.curved,
              ),
              if (secondValues.isNotEmpty)
                fl.LineChartBarData(
                  spots: [
                    for (int i = 0;
                        i <
                            secondValues.length;
                        i++)
                      fl.FlSpot(
                        i.toDouble(),
                        secondValues[i],
                      ),
                  ],
                  color: _colors[1],
                  barWidth: 3,
                  isCurved: false,
                ),
            ],
          ),
        );

      case 'pie':
      case 'donut':
        final categories =
            _categories(
          data,
          recipe.metricA,
        );

        if (categories.isEmpty) {
          return _empty();
        }

        return fl.PieChart(
          fl.PieChartData(
            centerSpaceRadius:
                recipe.type == 'donut'
                    ? 45
                    : 0,
            sectionsSpace: 3,
            sections: [
              for (int i = 0;
                  i < categories.length;
                  i++)
                fl.PieChartSectionData(
                  value: categories[i].value,
                  color:
                      _colors[
                          i %
                              _colors.length],
                  radius: 75,
                  showTitle: false,
                ),
            ],
          ),
        );

      case 'scatter':
      case 'scatter_line':
      case 'bubble':
        if (recipe.metricB == null) {
          return _empty();
        }

        final pairs = _pairs(
          data,
          recipe.metricA,
          recipe.metricB!,
        );

        if (pairs.isEmpty) {
          return _empty();
        }

        final maxX = _maxPairX(pairs);
        final maxY = _maxPairY(pairs);

        final scatter =
            fl.ScatterChart(
          fl.ScatterChartData(
            minX: 0,
            maxX: maxX,
            minY: 0,
            maxY: maxY,
            scatterSpots: [
              for (int i = 0;
                  i < pairs.length;
                  i++)
                fl.ScatterSpot(
                  pairs[i].x,
                  pairs[i].y,
                  dotPainter:
                      fl.FlDotCirclePainter(
                    radius: recipe.type ==
                            'bubble'
                        ? 4 +
                            (recipe.metricC ==
                                    null
                                ? 0
                                : i %
                                    7)
                        : 5,
                    color:
                        _colors[
                            i %
                                _colors.length],
                  ),
                ),
            ],
          ),
        );

        if (recipe.type !=
            'scatter_line') {
          return scatter;
        }

        final line = fl.LineChart(
          fl.LineChartData(
            minX: 0,
            maxX: maxX,
            minY: 0,
            maxY: maxY,
            lineBarsData: [
              fl.LineChartBarData(
                spots: [
                  fl.FlSpot(
                    pairs.first.x,
                    pairs.first.y,
                  ),
                  fl.FlSpot(
                    pairs.last.x,
                    pairs.last.y,
                  ),
                ],
                color: _colors[4],
                barWidth: 2,
                dotData:
                    const fl.FlDotData(
                  show: false,
                ),
              ),
            ],
          ),
        );

        return Stack(
          children: [
            Positioned.fill(
              child: scatter,
            ),
            Positioned.fill(
              child: line,
            ),
          ],
        );

      case 'genre_score':
      case 'genre_popularity':
      case 'type_score':
      case 'status_score':
        final category =
            recipe.type.startsWith('genre')
                ? 'genres'
                : recipe.type.startsWith('type')
                    ? 'types'
                    : 'statuses';

        final metric = recipe.type.contains(
          'score',
        )
            ? 'score'
            : 'popularity';

        final entries =
            _categoryMetric(
          data,
          category,
          metric,
        );

        if (entries.isEmpty) {
          return _empty();
        }

        return fl.BarChart(
          fl.BarChartData(
            minY: 0,
            maxY: _safeMax([
              for (final item in entries)
                item.value,
            ]),
            barGroups: [
              for (int i = 0;
                  i < entries.length;
                  i++)
                fl.BarChartGroupData(
                  x: i,
                  barRods: [
                    fl.BarChartRodData(
                      toY: entries[i].value,
                      width: 16,
                      color:
                          _colors[
                              i %
                                  _colors.length],
                      borderRadius:
                          BorderRadius.circular(
                        4,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        );

      case 'pareto':
        final categories =
            _categories(
          data,
          recipe.metricA,
        );

        if (categories.isEmpty) {
          return _empty();
        }

        final total = categories.fold<double>(
          0,
          (sum, item) => sum + item.value,
        );

        if (total == 0) {
          return _empty();
        }

        double cumulative = 0;

        final spots = <fl.FlSpot>[];

        for (int i = 0;
            i < categories.length;
            i++) {
          cumulative +=
              categories[i].value;

          spots.add(
            fl.FlSpot(
              i.toDouble(),
              cumulative / total * 100,
            ),
          );
        }

        return Stack(
          children: [
            Positioned.fill(
              child: fl.BarChart(
                fl.BarChartData(
                  minY: 0,
                  maxY: 100,
                  barGroups: [
                    for (int i = 0;
                        i <
                            categories.length;
                        i++)
                      fl.BarChartGroupData(
                        x: i,
                        barRods: [
                          fl.BarChartRodData(
                            toY:
                                categories[i]
                                        .value /
                                    total *
                                    100,
                            width: 20,
                            color:
                                _colors[
                                    i %
                                        _colors
                                            .length],
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
            Positioned.fill(
              child: fl.LineChart(
                fl.LineChartData(
                  minY: 0,
                  maxY: 100,
                  lineBarsData: [
                    fl.LineChartBarData(
                      spots: spots,
                      color: _colors[4],
                      barWidth: 3,
                      dotData:
                          const fl.FlDotData(
                        show: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );

      case 'dashboard':
      case 'multi_view':
        return Row(
          children: [
            Expanded(
              child: _renderFl(
                const ChartRecipe(
                  index: 0,
                  level:
                      ChartLevel.basic,
                  type: 'bar',
                  metricA: 'score',
                ),
                data,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _renderFl(
                const ChartRecipe(
                  index: 0,
                  level:
                      ChartLevel.basic,
                  type: 'line',
                  metricA: 'popularity',
                  curved: true,
                ),
                data,
              ),
            ),
          ],
        );

      case 'radar':
        return Row(
          children: [
            Expanded(
              child: _renderFl(
                const ChartRecipe(
                  index: 0,
                  level:
                      ChartLevel.basic,
                  type: 'bar',
                  metricA: 'score',
                ),
                data,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _renderFl(
                const ChartRecipe(
                  index: 1,
                  level:
                      ChartLevel.basic,
                  type: 'scatter',
                  metricA:
                      'score',
                  metricB:
                      'popularity',
                ),
                data,
              ),
            ),
          ],
        );

      default:
        return _renderFl(
          const ChartRecipe(
            index: 0,
            level: ChartLevel.basic,
            type: 'line',
            metricA: 'score',
          ),
          data,
        );
    }
  }

  static Widget _renderGraphic(
    ChartRecipe recipe,
    ChartDataSource data,
  ) {
    final values = _values(
      data,
      recipe.metricA,
    );

    if (values.isEmpty) {
      return _empty();
    }

    final points = [
      for (int i = 0;
          i < values.length;
          i++)
        <String, dynamic>{
          'x': '$i',
          'y': values[i],
        },
    ];

    switch (recipe.type) {
      case 'bar':
        return _graphicChart(
          values: points,
          mark:
              graphic.IntervalMark(),
          interactive:
              recipe.interactive,
        );

      case 'line':
      case 'year_score':
      case 'year_popularity':
      case 'year_chapters':
      case 'year_volumes':
      case 'interactive_line':
        final yearValues =
            recipe.type.startsWith(
          'year_',
        )
            ? _yearMetric(
                data,
                recipe.metricA,
              )
            : const <_YearPoint>[];

        final finalValues =
            yearValues.isNotEmpty
                ? [
                    for (final item
                        in yearValues)
                      item.value,
                  ]
                : values;

        final finalPoints = [
          for (int i = 0;
              i < finalValues.length;
              i++)
            <String, dynamic>{
              'x': '$i',
              'y': finalValues[i],
            },
        ];

        return _graphicChart(
          values: finalPoints,
          mark: graphic.LineMark(),
          interactive:
              recipe.interactive,
        );

      case 'area':
      case 'area_selection':
        return _graphicChart(
          values: points,
          mark: graphic.AreaMark(),
          interactive:
              recipe.interactive,
        );

      case 'point':
      case 'scatter':
      case 'bubble':
      case 'pie':
      case 'donut':
        return _graphicChart(
          values: points,
          mark: graphic.PointMark(),
          interactive:
              recipe.interactive,
        );

      case 'line_point':
        return Row(
          children: [
            Expanded(
              child: _graphicChart(
                values: points,
                mark:
                    graphic.LineMark(),
              ),
            ),
            Expanded(
              child: _graphicChart(
                values: points,
                mark:
                    graphic.PointMark(),
              ),
            ),
          ],
        );

      case 'interval_tooltip':
        return _graphicChart(
          values: points,
          mark:
              graphic.IntervalMark(),
          interactive: true,
        );

      case 'multi_view':
      case 'dashboard':
        return Row(
          children: [
            Expanded(
              child: _graphicChart(
                values: points,
                mark:
                    graphic.LineMark(),
              ),
            ),
            Expanded(
              child: _graphicChart(
                values: points,
                mark:
                    graphic.IntervalMark(),
              ),
            ),
          ],
        );

      default:
        return _graphicChart(
          values: points,
          mark:
              graphic.LineMark(),
          interactive:
              recipe.interactive,
        );
    }
  }

  static Widget _graphicChart({
    required List<Map<String, dynamic>>
        values,
    required graphic.Mark mark,
    bool interactive = false,
  }) {
    return graphic.Chart(
      data: values,
      variables: {
        'x': graphic.Variable(
          accessor: (Map map) =>
              map['x'] as String,
        ),
        'y': graphic.Variable(
          accessor: (Map map) =>
              map['y'] as num,
        ),
      },
      marks: [
        mark,
      ],
      axes: [
        graphic.Defaults.horizontalAxis,
        graphic.Defaults.verticalAxis,
      ],
      selections: interactive
          ? {
              'tap':
                  graphic.PointSelection(),
            }
          : null,
      tooltip: interactive
          ? graphic.TooltipGuide()
          : null,
      crosshair: interactive
          ? graphic.CrosshairGuide()
          : null,
    );
  }

  static Widget _renderSyncfusion(
    ChartRecipe recipe,
    ChartDataSource data,
  ) {
    final values = _values(
      data,
      recipe.metricA,
    );

    final secondValues = recipe.metricB == null
        ? const <double>[]
        : _values(
            data,
            recipe.metricB!,
          );

    if (values.isEmpty &&
        ![
          'pie',
          'donut',
        ].contains(recipe.type)) {
      return _empty();
    }

    if (recipe.type == 'pie') {
      final categories =
          _categories(
        data,
        recipe.metricA,
      );

      if (categories.isEmpty) {
        return _empty();
      }

      return sf.SfCircularChart(
        series: <sf.CircularSeries<
            _SfPoint, String>>[
          sf.PieSeries<
              _SfPoint, String>(
            dataSource: [
              for (final item
                  in categories)
                _SfPoint(
                  item.label,
                  item.value,
                ),
            ],
            xValueMapper:
                (_SfPoint item, _) =>
                    item.x,
            yValueMapper:
                (_SfPoint item, _) =>
                    item.y,
          ),
        ],
      );
    }

    if (recipe.type == 'donut') {
      final categories =
          _categories(
        data,
        recipe.metricA,
      );

      if (categories.isEmpty) {
        return _empty();
      }

      return sf.SfCircularChart(
        series: <sf.CircularSeries<
            _SfPoint, String>>[
          sf.DoughnutSeries<
              _SfPoint, String>(
            dataSource: [
              for (final item
                  in categories)
                _SfPoint(
                  item.label,
                  item.value,
                ),
            ],
            xValueMapper:
                (_SfPoint item, _) =>
                    item.x,
            yValueMapper:
                (_SfPoint item, _) =>
                    item.y,
          ),
        ],
      );
    }

    final xValues = _sfPoints(
      recipe.type.startsWith('year_')
          ? [
              for (final item
                  in _yearMetric(
                data,
                recipe.metricA,
              ))
                item.value,
            ]
          : values,
    );

    switch (recipe.type) {
      case 'bar':
        return sf.SfCartesianChart(
          primaryXAxis:
              sf.CategoryAxis(),
          tooltipBehavior:
              sf.TooltipBehavior(
            enable: recipe.interactive,
          ),
          series: <sf.CartesianSeries<
              _SfPoint, String>>[
            sf.ColumnSeries<
                _SfPoint, String>(
              dataSource: xValues,
              xValueMapper:
                  (_SfPoint item, _) =>
                      item.x,
              yValueMapper:
                  (_SfPoint item, _) =>
                      item.y,
            ),
          ],
        );

      case 'grouped_bar':
        return sf.SfCartesianChart(
          primaryXAxis:
              sf.CategoryAxis(),
          legend:
              sf.Legend(isVisible: true),
          series: <sf.CartesianSeries<
              _SfPoint, String>>[
            sf.BarSeries<
                _SfPoint, String>(
              name: _metricLabel(
                recipe.metricA,
              ),
              dataSource: _sfPoints(
                values,
              ),
              xValueMapper:
                  (_SfPoint item, _) =>
                      item.x,
              yValueMapper:
                  (_SfPoint item, _) =>
                      item.y,
            ),
            if (secondValues.isNotEmpty)
              sf.BarSeries<
                  _SfPoint, String>(
                name: _metricLabel(
                  recipe.metricB ??
                      'Serie B',
                ),
                dataSource:
                    _sfPoints(
                  secondValues,
                ),
                xValueMapper:
                    (_SfPoint item, _) =>
                        item.x,
                yValueMapper:
                    (_SfPoint item, _) =>
                        item.y,
              ),
          ],
        );

      case 'stacked_bar':
        return sf.SfCartesianChart(
          primaryXAxis:
              sf.CategoryAxis(),
          legend:
              sf.Legend(isVisible: true),
          series: <sf.CartesianSeries<
              _SfPoint, String>>[
            sf.StackedColumnSeries<
                _SfPoint, String>(
              name: _metricLabel(
                recipe.metricA,
              ),
              dataSource:
                  _sfPoints(values),
              xValueMapper:
                  (_SfPoint item, _) =>
                      item.x,
              yValueMapper:
                  (_SfPoint item, _) =>
                      item.y,
            ),
            if (secondValues.isNotEmpty)
              sf.StackedColumnSeries<
                  _SfPoint, String>(
                name: _metricLabel(
                  recipe.metricB ??
                      'Serie B',
                ),
                dataSource:
                    _sfPoints(
                  secondValues,
                ),
                xValueMapper:
                    (_SfPoint item, _) =>
                        item.x,
                yValueMapper:
                    (_SfPoint item, _) =>
                        item.y,
              ),
          ],
        );

      case 'scatter':
      case 'bubble':
        if (recipe.metricB == null) {
          return _empty();
        }

        final pairs = _pairs(
          data,
          recipe.metricA,
          recipe.metricB!,
        );

        return sf.SfCartesianChart(
          primaryXAxis:
              sf.NumericAxis(),
          series: <sf.CartesianSeries<
              _SfScatterPoint, double>>[
            sf.ScatterSeries<
                _SfScatterPoint,
                double>(
              dataSource: [
                for (final pair
                    in pairs)
                  _SfScatterPoint(
                    pair.x,
                    pair.y,
                  ),
              ],
              xValueMapper:
                  (
                    _SfScatterPoint item,
                    _,
                  ) =>
                      item.x,
              yValueMapper:
                  (
                    _SfScatterPoint item,
                    _,
                  ) =>
                      item.y,
              markerSettings:
                  const sf.MarkerSettings(
                height: 9,
                width: 9,
              ),
            ),
          ],
        );

      case 'multi_line':
      case 'line':
      case 'year_score':
      case 'year_popularity':
      case 'year_chapters':
      case 'year_volumes':
        return sf.SfCartesianChart(
          primaryXAxis:
              sf.CategoryAxis(),
          legend: recipe.metricB != null
              ? sf.Legend(
                  isVisible: true,
                )
              : sf.Legend(
                  isVisible: false,
                ),
          tooltipBehavior:
              sf.TooltipBehavior(
            enable: recipe.interactive,
          ),
          series: <sf.CartesianSeries<
              _SfPoint, String>>[
            sf.LineSeries<
                _SfPoint, String>(
              name: _metricLabel(
                recipe.metricA,
              ),
              dataSource: xValues,
              xValueMapper:
                  (_SfPoint item, _) =>
                      item.x,
              yValueMapper:
                  (_SfPoint item, _) =>
                      item.y,
            ),
            if (recipe.metricB != null)
              sf.LineSeries<
                  _SfPoint, String>(
                name: _metricLabel(
                  recipe.metricB!,
                ),
                dataSource:
                    _sfPoints(
                  secondValues,
                ),
                xValueMapper:
                    (_SfPoint item, _) =>
                        item.x,
                yValueMapper:
                    (_SfPoint item, _) =>
                        item.y,
              ),
          ],
        );

      case 'dashboard':
        return Row(
          children: [
            Expanded(
              child: sf.SfCartesianChart(
                primaryXAxis:
                    sf.CategoryAxis(),
                series:
                    <sf.CartesianSeries<
                        _SfPoint,
                        String>>[
                  sf.ColumnSeries<
                      _SfPoint,
                      String>(
                    dataSource:
                        _sfPoints(
                      values
                          .take(8)
                          .toList(),
                    ),
                    xValueMapper:
                        (_SfPoint item,
                                _) =>
                            item.x,
                    yValueMapper:
                        (_SfPoint item,
                                _) =>
                            item.y,
                  ),
                ],
              ),
            ),
            Expanded(
              child: sf.SfCircularChart(
                series:
                    <sf.CircularSeries<
                        _SfPoint,
                        String>>[
                  sf.DoughnutSeries<
                      _SfPoint,
                      String>(
                    dataSource: [
                      for (final item
                          in data.genres
                              .take(6))
                        _SfPoint(
                          item.label,
                          item.value,
                        ),
                    ],
                    xValueMapper:
                        (_SfPoint item,
                                _) =>
                            item.x,
                    yValueMapper:
                        (_SfPoint item,
                                _) =>
                            item.y,
                  ),
                ],
              ),
            ),
          ],
        );

      default:
        return sf.SfCartesianChart(
          primaryXAxis:
              sf.CategoryAxis(),
          series: <sf.CartesianSeries<
              _SfPoint, String>>[
            sf.AreaSeries<
                _SfPoint, String>(
              dataSource:
                  _sfPoints(values),
              xValueMapper:
                  (_SfPoint item, _) =>
                      item.x,
              yValueMapper:
                  (_SfPoint item, _) =>
                      item.y,
            ),
          ],
        );
    }
  }

  static List<_SfPoint> _sfPoints(
    List<double> values,
  ) {
    return [
      for (int i = 0;
          i < values.length;
          i++)
        _SfPoint(
          '$i',
          values[i],
        ),
    ];
  }

  static Widget _renderChartsPainter(
    ChartRecipe recipe,
    ChartDataSource data,
  ) {
    final values = _values(
      data,
      recipe.metricA,
    );

    if (values.isEmpty) {
      return _empty();
    }

    List<cp.ChartItem<void>> items(
      List<double> source,
    ) {
      return [
        for (final value in source)
          cp.ChartItem<void>(
            value,
          ),
      ];
    }

    switch (recipe.type) {
      case 'bar':
      case 'grouped_bar':
      case 'stacked_bar':
        final second = recipe.metricB == null
            ? const <double>[]
            : _values(
                data,
                recipe.metricB!,
              );

        return cp.Chart(
          state: cp.ChartState<void>(
            data: cp.ChartData<void>(
              [
                items(values),
                if (second.isNotEmpty)
                  items(
                    second
                        .take(
                          values.length,
                        )
                        .toList(),
                  ),
              ],
            ),
            itemOptions:
                cp.BarItemOptions(),
          ),
        );

      case 'line':
      case 'multi_line':
        final second = recipe.metricB == null
            ? const <double>[]
            : _values(
                data,
                recipe.metricB!,
              );

        return cp.Chart(
          state: cp.ChartState<void>(
            data: cp.ChartData<void>(
              [
                items(values),
                if (second.isNotEmpty)
                  items(
                    second
                        .take(
                          values.length,
                        )
                        .toList(),
                  ),
              ],
            ),
            itemOptions:
                cp.BubbleItemOptions(),
          ),
        );

      case 'bubble':
      case 'scatter':
        return cp.Chart(
          state: cp.ChartState<void>(
            data: cp.ChartData<void>(
              [
                items(values),
              ],
            ),
            itemOptions:
                cp.BubbleItemOptions(),
          ),
        );

      case 'dashboard':
        return Row(
          children: [
            Expanded(
              child: cp.Chart(
                state:
                    cp.ChartState<void>(
                  data:
                      cp.ChartData<void>(
                    [
                      items(values),
                    ],
                  ),
                  itemOptions:
                      cp.BarItemOptions(),
                ),
              ),
            ),
            Expanded(
              child: cp.Chart(
                state:
                    cp.ChartState<void>(
                  data:
                      cp.ChartData<void>(
                    [
                      items(
                        recipe.metricB ==
                                null
                            ? values
                            : _values(
                                data,
                                recipe
                                    .metricB!,
                              ),
                      ),
                    ],
                  ),
                  itemOptions:
                      cp.BubbleItemOptions(),
                ),
              ),
            ),
          ],
        );

      default:
        return cp.Chart(
          state: cp.ChartState<void>(
            data: cp.ChartData<void>(
              [
                items(values),
              ],
            ),
            itemOptions:
                cp.BubbleItemOptions(),
          ),
        );
    }
  }

  static List<fusion.FusionDataPoint>
      _fusionPoints(
    List<double> values, {
    bool labels = false,
  }) {
    return [
      for (int i = 0;
          i < values.length;
          i++)
        fusion.FusionDataPoint(
          i.toDouble(),
          values[i],
          label:
              labels ? '$i' : null,
        ),
    ];
  }

  static Widget _renderFusion(
    ChartRecipe recipe,
    ChartDataSource data,
  ) {
    final values = _values(
      data,
      recipe.metricA,
    );

    if (values.isEmpty &&
        recipe.type != 'pie' &&
        recipe.type != 'donut') {
      return _empty();
    }

    switch (recipe.type) {
      case 'line':
      case 'year_score':
      case 'year_popularity':
      case 'year_chapters':
      case 'year_volumes':
        final finalValues =
            recipe.type.startsWith(
          'year_',
        )
                ? [
                    for (final item
                        in _yearMetric(
                      data,
                      recipe.metricA,
                    ))
                      item.value,
                  ]
                : values;

        return fusion.FusionLineChart(
          series: [
            fusion.FusionLineSeries(
              name: _metricLabel(
                recipe.metricA,
              ),
              dataPoints:
                  _fusionPoints(
                finalValues,
                labels: true,
              ),
              color: _colors[0],
              lineWidth: recipe.interactive
                  ? 4
                  : 3,
              isCurved:
                  recipe.curved,
            ),
          ],
        );

      case 'multi_line':
        final second = recipe.metricB == null
            ? const <double>[]
            : _values(
                data,
                recipe.metricB!,
              );

        return fusion.FusionLineChart(
          series: [
            fusion.FusionLineSeries(
              name: _metricLabel(
                recipe.metricA,
              ),
              dataPoints:
                  _fusionPoints(values),
              color: _colors[0],
              lineWidth: 3,
              isCurved: recipe.curved,
            ),
            if (second.isNotEmpty)
              fusion.FusionLineSeries(
                name: _metricLabel(
                  recipe.metricB!,
                ),
                dataPoints:
                    _fusionPoints(
                  second.take(
                    values.length,
                  ).toList(),
                ),
                color: _colors[1],
                lineWidth: 2,
              ),
          ],
          config:
              fusion.FusionChartConfiguration(
            theme:
                fusion.FusionDarkTheme(),
            enableAnimation:
                recipe.interactive,
            enableTooltip:
                recipe.interactive,
            enableCrosshair:
                recipe.interactive,
            enableZoom:
                recipe.interactive,
            enablePanning:
                recipe.interactive,
          ),
        );

      case 'bar':
      case 'grouped_bar':
        final second = recipe.metricB == null
            ? const <double>[]
            : _values(
                data,
                recipe.metricB!,
              );

        return fusion.FusionBarChart(
          series: [
            fusion.FusionBarSeries(
              name: _metricLabel(
                recipe.metricA,
              ),
              dataPoints:
                  _fusionPoints(
                values,
                labels: true,
              ),
              color: _colors[0],
              borderRadius:
                  recipe.grouped ? 8 : 6,
            ),
            if (recipe.grouped &&
                second.isNotEmpty)
              fusion.FusionBarSeries(
                name: _metricLabel(
                  recipe.metricB!,
                ),
                dataPoints:
                    _fusionPoints(
                  second.take(
                    values.length,
                  ).toList(),
                  labels: true,
                ),
                color: _colors[1],
                borderRadius: 8,
              ),
          ],
        );

      case 'stacked_bar':
        final second = recipe.metricB == null
            ? const <double>[]
            : _values(
                data,
                recipe.metricB!,
              );

        return fusion.FusionStackedBarChart(
          series: [
            fusion.FusionStackedBarSeries(
              name: _metricLabel(
                recipe.metricA,
              ),
              dataPoints:
                  _fusionPoints(values),
              color: _colors[0],
            ),
            if (second.isNotEmpty)
              fusion.FusionStackedBarSeries(
                name: _metricLabel(
                  recipe.metricB!,
                ),
                dataPoints:
                    _fusionPoints(
                  second.take(
                    values.length,
                  ).toList(),
                ),
                color: _colors[1],
              ),
          ],
          config:
              fusion.FusionChartConfiguration(
            theme:
                fusion.FusionDarkTheme(),
            enableAnimation:
                recipe.interactive,
            enableTooltip:
                recipe.interactive,
          ),
        );

      case 'pie':
        final categories =
            _categories(
          data,
          recipe.metricA,
        );

        if (categories.isEmpty) {
          return _empty();
        }

        return fusion.FusionPieChart(
          series:
              fusion.FusionPieSeries(
            dataPoints: [
              for (int i = 0;
                  i < categories.length;
                  i++)
                fusion.FusionPieDataPoint(
                  categories[i].value,
                  label:
                      categories[i].label,
                  color:
                      _colors[
                          i %
                              _colors.length],
                ),
            ],
          ),
        );

      case 'donut':
        final categories =
            _categories(
          data,
          recipe.metricA,
        );

        if (categories.isEmpty) {
          return _empty();
        }

        return fusion.FusionPieChart(
          series:
              fusion.FusionPieSeries(
            dataPoints: [
              for (int i = 0;
                  i < categories.length;
                  i++)
                fusion.FusionPieDataPoint(
                  categories[i].value,
                  label:
                      categories[i].label,
                  color:
                      _colors[
                          i %
                              _colors.length],
                ),
            ],
          ),
          config:
              const fusion
                  .FusionPieChartConfiguration(
            innerRadiusPercent:
                0.5,
            showCenterLabel:
                true,
            centerLabelText:
                'NEXUS',
            centerSubLabelText:
                'MANGA',
          ),
        );

      case 'dashboard':
        return Column(
          children: [
            Expanded(
              child:
                  fusion.FusionLineChart(
                series: [
                  fusion
                      .FusionLineSeries(
                    name: _metricLabel(
                      recipe.metricA,
                    ),
                    dataPoints:
                        _fusionPoints(
                      values.take(10).toList(),
                    ),
                    color: _colors[0],
                  ),
                ],
              ),
            ),
            Expanded(
              child:
                  fusion.FusionBarChart(
                series: [
                  fusion
                      .FusionBarSeries(
                    name:
                        _metricLabel(
                      recipe.metricB ??
                          'popularity',
                    ),
                    dataPoints:
                        _fusionPoints(
                      recipe.metricB ==
                              null
                          ? values
                              .take(10)
                              .toList()
                          : _values(
                              data,
                              recipe
                                  .metricB!,
                            ).take(10).toList(),
                    ),
                    color: _colors[2],
                  ),
                ],
              ),
            ),
          ],
        );

      default:
        return fusion.FusionLineChart(
          series: [
            fusion.FusionLineSeries(
              name: 'Nexus',
              dataPoints:
                  _fusionPoints(
                values,
              ),
              color: _colors[5],
            ),
          ],
        );
    }
  }

  static Widget _renderFast(
    ChartRecipe recipe,
    ChartDataSource data,
  ) {
    final values = _values(
      data,
      recipe.metricA,
    );

    if (values.isEmpty &&
        recipe.type != 'pie' &&
        recipe.type != 'donut') {
      return _empty();
    }

    fast.Series<String, double>
        seriesFor(
      List<double> source,
      Color color,
    ) {
      final map = <String, double>{};

      for (int i = 0;
          i < source.length;
          i++) {
        map['M${i + 1}'] = source[i];
      }

      return fast.Series<String, double>(
  data: map,
  measureAccessor: (value) => value,
  colorAccessor: (_, value) => color,
);
    }

    switch (recipe.type) {
      case 'bar':
      case 'grouped_bar':
      case 'grouped_multi':
        final second = recipe.metricB == null
            ? const <double>[]
            : _values(
                data,
                recipe.metricB!,
              );

        final third = recipe.metricC == null
            ? const <double>[]
            : _values(
                data,
                recipe.metricC!,
              );

        return fast.BarChart<
            String, double>(
          data: [
            seriesFor(
              values,
              _colors[0],
            ),
            if (recipe.grouped &&
                second.isNotEmpty)
              seriesFor(
                second.take(
                  values.length,
                ).toList(),
                _colors[1],
              ),
            if (recipe.grouped &&
                third.isNotEmpty)
              seriesFor(
                third.take(
                  values.length,
                ).toList(),
                _colors[2],
              ),
          ],
          inverted:
              recipe.interactive &&
                  recipe.index.isOdd,
          animationDuration:
              recipe.interactive
                  ? const Duration(
                      milliseconds: 500,
                    )
                  : Duration.zero,
          barPadding: recipe.grouped
              ? 2
              : 4,
          groupSpacing:
              recipe.grouped ? 8 : 4,
          radius:
              const Radius.circular(7),
        );

      case 'stacked_bar':
      case 'stacked_multi':
        final second = recipe.metricB == null
            ? const <double>[]
            : _values(
                data,
                recipe.metricB!,
              );

        final third = recipe.metricC == null
            ? const <double>[]
            : _values(
                data,
                recipe.metricC!,
              );

        return fast.StackedBarChart<
            String, double>(
          data: [
            seriesFor(
              values,
              _colors[0],
            ),
            if (second.isNotEmpty)
              seriesFor(
                second.take(
                  values.length,
                ).toList(),
                _colors[1],
              ),
            if (third.isNotEmpty)
              seriesFor(
                third.take(
                  values.length,
                ).toList(),
                _colors[2],
              ),
          ],
          inverted:
              recipe.interactive &&
                  recipe.index.isOdd,
          animationDuration:
              recipe.interactive
                  ? const Duration(
                      milliseconds: 650,
                    )
                  : Duration.zero,
          barPadding: 2,
          radius:
              const Radius.circular(7),
        );

      case 'radial':
      case 'radial_multi':
      case 'radar':
        final second = recipe.metricB == null
            ? const <double>[]
            : _values(
                data,
                recipe.metricB!,
              );

        final third = recipe.metricC == null
            ? const <double>[]
            : _values(
                data,
                recipe.metricC!,
              );

        return fast.RadialStackedBarChart<
            String, double>(
          data: [
            seriesFor(
              values,
              _colors[0],
            ),
            if (second.isNotEmpty)
              seriesFor(
                second.take(
                  values.length,
                ).toList(),
                _colors[1],
              ),
            if (third.isNotEmpty)
              seriesFor(
                third.take(
                  values.length,
                ).toList(),
                _colors[2],
              ),
          ],
          angle:
              recipe.index * 0.1,
          holeSize:
              recipe.type == 'radar'
                  ? 30
                  : 45,
          arcSpacing: 4,
          roundStart: true,
          roundEnd: true,
          animationDuration:
              recipe.interactive
                  ? const Duration(
                      milliseconds: 700,
                    )
                  : Duration.zero,
        );

      case 'pie':
      case 'donut':
      case 'pie_analysis':
        final categories =
            _categories(
          data,
          recipe.metricA,
        );

        if (categories.isEmpty) {
          return _empty();
        }

        return fast.PieChart<
            String, double>(
          data:
              fast.Series<String, double>(
            data: {
              for (final item
                  in categories)
                item.label:
                    item.value,
            },
            measureAccessor:
                (value) => value,
            colorAccessor:
                (domain, value) {
              final index =
                  categories.indexWhere(
                (item) =>
                    item.label ==
                    domain,
              );

              return _colors[
                  index < 0
                      ? 0
                      : index %
                          _colors.length];
            },
          ),
          holeSize:
              recipe.type ==
                          'donut' ||
                      recipe.type ==
                          'pie_analysis'
                  ? 50
                  : 0,
          animationDuration:
              recipe.interactive
                  ? const Duration(
                      milliseconds: 800,
                    )
                  : Duration.zero,
        );

      case 'dashboard':
        return Column(
          children: [
            Expanded(
              child:
                  fast.BarChart<
                      String, double>(
                data: [
                  seriesFor(
                    values
                        .take(8)
                        .toList(),
                    _colors[0],
                  ),
                ],
                radius:
                    const Radius.circular(
                  6,
                ),
              ),
            ),
            Expanded(
              child:
                  fast.RadialStackedBarChart<
                      String, double>(
                data: [
                  seriesFor(
                    recipe.metricB ==
                            null
                        ? values
                            .take(8)
                            .toList()
                        : _values(
                            data,
                            recipe
                                .metricB!,
                          ).take(8).toList(),
                    _colors[2],
                  ),
                ],
                holeSize: 40,
                arcSpacing: 3,
              ),
            ),
          ],
        );

      default:
        return fast.BarChart<
            String, double>(
          data: [
            seriesFor(
              values,
              _colors[5],
            ),
          ],
          radius:
              const Radius.circular(5),
        );
    }
  }

  static List<fl.BarChartRodData>
      _thirdRod(
    ChartDataSource data,
    String metric,
    int index,
  ) {
    final values = _values(
      data,
      metric,
    );

    if (index >= values.length) {
      return const [];
    }

    return [
      fl.BarChartRodData(
        toY: values[index],
        width: 7,
        color: _colors[2],
      ),
    ];
  }

  static double _safeMax(
    List<double> values,
  ) {
    if (values.isEmpty) {
      return 1;
    }

    double maxValue = 0;

    for (final value in values) {
      if (value > maxValue) {
        maxValue = value;
      }
    }

    if (maxValue <= 0) {
      return 1;
    }

    return maxValue * 1.15;
  }

  static double _maxPairX(
    List<ChartPair> values,
  ) {
    double maxValue = 1;

    for (final value in values) {
      if (value.x > maxValue) {
        maxValue = value.x;
      }
    }

    return maxValue * 1.1;
  }

  static double _maxPairY(
    List<ChartPair> values,
  ) {
    double maxValue = 1;

    for (final value in values) {
      if (value.y > maxValue) {
        maxValue = value.y;
      }
    }

    return maxValue * 1.1;
  }
}

class _YearPoint {
  final int year;
  final double value;

  const _YearPoint({
    required this.year,
    required this.value,
  });
}

class _CategoryMetric {
  final String label;
  final double value;

  const _CategoryMetric({
    required this.label,
    required this.value,
  });
}

class _SfPoint {
  final String x;
  final double y;

  const _SfPoint(
    this.x,
    this.y,
  );
}

class _SfScatterPoint {
  final double x;
  final double y;

  const _SfScatterPoint(
    this.x,
    this.y,
  );
}