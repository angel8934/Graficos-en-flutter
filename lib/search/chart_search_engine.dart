import '../data/chart_catalog.dart';
import '../models/chart_definition.dart';
import '../models/chart_case.dart';
import '../models/chart_library.dart';
import 'search_result.dart';

class ChartSearchEngine {
  static List<SearchResult> search(
    List<ChartDefinition> charts,
    String query,
  ) {
    final normalizedQuery = _normalize(query);

    if (normalizedQuery.isEmpty) {
      return [];
    }

    final queryTokens = _meaningfulTokens(
      normalizedQuery,
    );

    if (queryTokens.isEmpty) {
      return [];
    }

    final results = <SearchResult>[];

    for (final chart in charts) {
      final result = _scoreChart(
        chart,
        normalizedQuery,
        queryTokens,
      );

      if (result != null) {
        results.add(result);
      }
    }

    results.sort((a, b) {
      final scoreCompare =
          b.score.compareTo(a.score);

      if (scoreCompare != 0) {
        return scoreCompare;
      }

      return a.chart.title.compareTo(
        b.chart.title,
      );
    });

    return results.take(30).toList();
  }

  static SearchResult? _scoreChart(
    ChartDefinition chart,
    String query,
    List<String> tokens,
  ) {
    final title = _normalize(chart.title);
    final description =
        _normalize(chart.description);
    final compared =
        _normalize(chart.dataCompared);
    final idealFor =
        _normalize(chart.idealFor);
    final type =
        _normalize(chart.chartType);
    final library =
        _normalize(chart.library.name);
    final folder =
        _normalize(chart.library.folder);

    final keywords = chart.keywords
        .map(_normalize)
        .where((value) => value.isNotEmpty)
        .toSet();

    final searchable = [
      title,
      description,
      compared,
      idealFor,
      type,
      library,
      folder,
      ...keywords,
    ].join(' ');

    if (searchable.isEmpty) {
      return null;
    }

    int score = 0;

    final matched = <String>{};

    if (title == query) {
      score += 150;
    }

    if (title.contains(query)) {
      score += 80;
    }

    if (compared == query) {
      score += 100;
    }

    if (compared.contains(query)) {
      score += 45;
    }

    if (type == query) {
      score += 75;
    }

    if (type.contains(query)) {
      score += 35;
    }

    if (idealFor.contains(query)) {
      score += 20;
    }

    if (description.contains(query)) {
      score += 15;
    }

    if (library.contains(query) ||
        folder.contains(query)) {
      score += 40;
    }

    final aliases = _queryAliases(tokens);

    int matchedTokens = 0;

    for (final token in tokens) {
      final tokenAliases =
          aliases[token] ?? {token};

      bool tokenMatched = false;

      for (final alias in tokenAliases) {
        if (title.contains(alias)) {
          score += 30;
          tokenMatched = true;
          matched.add(alias);
          continue;
        }

        if (compared.contains(alias)) {
          score += 35;
          tokenMatched = true;
          matched.add(alias);
          continue;
        }

        if (type.contains(alias)) {
          score += 30;
          tokenMatched = true;
          matched.add(alias);
          continue;
        }

        if (idealFor.contains(alias)) {
          score += 18;
          tokenMatched = true;
          matched.add(alias);
          continue;
        }

        if (keywords.contains(alias)) {
          score += 25;
          tokenMatched = true;
          matched.add(alias);
          continue;
        }

        if (description.contains(alias)) {
          score += 10;
          tokenMatched = true;
          matched.add(alias);
        }
      }

      if (tokenMatched) {
        matchedTokens++;
      }
    }

    if (tokens.length > 1) {
      final coverage =
          matchedTokens / tokens.length;

      if (coverage < 0.5) {
        return null;
      }

      if (matchedTokens == tokens.length) {
        score += 60;
      } else {
        score += (coverage * 20).round();
      }
    }

    _applyLevelIntent(
      query,
      chart,
      (value) {
        score += value;
      },
    );

    _applyChartTypeIntent(
      tokens,
      chart,
      (value) {
        score += value;
      },
    );

    if (score < 25) {
      return null;
    }

    return SearchResult(
      chart: chart,
      score: score,
      matchedKeywords: matched.toList(),
    );
  }

  static void _applyLevelIntent(
    String query,
    ChartDefinition chart,
    void Function(int) add,
  ) {
    final normalized = _normalize(query);

    final advancedWords = {
      'avanzado',
      'avanzada',
      'advanced',
    };

    final basicWords = {
      'basico',
      'basica',
      'basic',
    };

    if (advancedWords.any(normalized.contains)) {
      if (chart.level == ChartLevel.advanced) {
        add(80);
      } else {
        add(-35);
      }
    }

    if (basicWords.any(normalized.contains)) {
      if (chart.level == ChartLevel.basic) {
        add(80);
      } else {
        add(-35);
      }
    }
  }

  static void _applyChartTypeIntent(
    List<String> tokens,
    ChartDefinition chart,
    void Function(int) add,
  ) {
    final type = _normalize(chart.chartType);

    for (final token in tokens) {
      final aliases =
          _chartTypeAliases[token];

      if (aliases == null) {
        continue;
      }

      for (final alias in aliases) {
        if (type.contains(alias)) {
          add(50);
          break;
        }
      }
    }
  }

  static Map<String, Set<String>>
      _queryAliases(
    List<String> tokens,
  ) {
    final result =
        <String, Set<String>>{};

    for (final token in tokens) {
      result[token] = {
        token,
        ...?_metricAliases[token],
        ...?_chartTypeAliases[token],
      };
    }

    return result;
  }

  static const Map<String, Set<String>>
      _metricAliases = {
    'score': {
      'score',
      'puntuacion',
      'calificacion',
      'valoracion',
    },
    'puntuacion': {
      'score',
      'puntuacion',
      'calificacion',
      'valoracion',
    },
    'popularidad': {
      'popularidad',
      'popularity',
    },
    'popularity': {
      'popularidad',
      'popularity',
    },
    'capitulos': {
      'capitulos',
      'chapters',
      'chapter',
    },
    'chapters': {
      'capitulos',
      'chapters',
      'chapter',
    },
    'volumenes': {
      'volumenes',
      'volumes',
      'volume',
    },
    'volumes': {
      'volumenes',
      'volumes',
      'volume',
    },
    'ranking': {
      'ranking',
      'rank',
    },
    'genero': {
      'genero',
      'generos',
      'genre',
      'genres',
    },
    'generos': {
      'genero',
      'generos',
      'genre',
      'genres',
    },
    'tipo': {
      'tipo',
      'type',
    },
    'estado': {
      'estado',
      'status',
    },
    'autor': {
      'autor',
      'autores',
      'author',
      'authors',
    },
    'autores': {
      'autor',
      'autores',
      'author',
      'authors',
    },
    'anio': {
      'anio',
      'year',
      'years',
    },
  };

  static const Map<String, Set<String>>
      _chartTypeAliases = {
    'bar': {
      'bar',
      'barra',
      'barras',
      'column',
      'interval',
    },
    'barra': {
      'bar',
      'barra',
      'barras',
      'column',
      'interval',
    },
    'barras': {
      'bar',
      'barra',
      'barras',
      'column',
      'interval',
    },
    'line': {
      'line',
      'linea',
      'lineas',
      'tendencia',
    },
    'linea': {
      'line',
      'linea',
      'lineas',
      'tendencia',
    },
    'scatter': {
      'scatter',
      'dispersion',
      'correlacion',
      'relacion',
    },
    'pie': {
      'pie',
      'pastel',
      'circular',
    },
    'donut': {
      'donut',
      'doughnut',
      'anillo',
    },
    'radial': {
      'radial',
      'circular',
    },
    'heatmap': {
      'heatmap',
      'mapa',
      'calor',
    },
    'multiserie': {
      'multiserie',
      'multi',
      'series',
    },
    'dashboard': {
      'dashboard',
      'panel',
      'resumen',
    },
  };

  static List<String> _meaningfulTokens(
    String value,
  ) {
    const stopWords = {
      'de',
      'del',
      'la',
      'el',
      'los',
      'las',
      'un',
      'una',
      'y',
      'o',
      'en',
      'por',
      'para',
      'con',
      'que',
      'quiero',
      'mostrar',
      'muestra',
      'ver',
      'comparar',
      'grafica',
      'graficas',
      'grafico',
      'graficos',
      'chart',
      'charts',
      'manga',
      'datos',
    };

    return value
        .split(RegExp(r'\s+'))
        .map(_normalize)
        .where(
          (token) =>
              token.isNotEmpty &&
              token.length >= 2 &&
              !stopWords.contains(token),
        )
        .toSet()
        .toList();
  }

  static String _normalize(
    String value,
  ) {
    return value
        .toLowerCase()
        .replaceAll('á', 'a')
        .replaceAll('é', 'e')
        .replaceAll('í', 'i')
        .replaceAll('ó', 'o')
        .replaceAll('ú', 'u')
        .replaceAll('ü', 'u')
        .replaceAll('ñ', 'n')
        .replaceAll(
          RegExp(r'[^a-z0-9\s]'),
          ' ',
        )
        .replaceAll(
          RegExp(r'\s+'),
          ' ',
        )
        .trim();
  }

  static List<SearchResult> searchCatalog(
    String query,
  ) {
    return search(
      ChartCatalog.all(),
      query,
    );
  }
}