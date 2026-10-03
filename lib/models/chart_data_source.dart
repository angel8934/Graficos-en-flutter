import 'manga.dart';

class ChartDataSource {
  final List<Manga> manga;

  const ChartDataSource({
    required this.manga,
  });

  bool get isEmpty => manga.isEmpty;

  bool get isNotEmpty => manga.isNotEmpty;

  int get length => manga.length;

  List<String> get labels {
    return manga.map((item) => item.title).toList();
  }

  List<ChartValue> get scores {
    return manga
        .where((item) => item.score != null)
        .map(
          (item) => ChartValue(
            label: item.title,
            value: item.score!,
          ),
        )
        .toList();
  }

  List<ChartValue> get popularity {
    return manga
        .where((item) => item.popularity != null)
        .map(
          (item) => ChartValue(
            label: item.title,
            value: item.popularity!.toDouble(),
          ),
        )
        .toList();
  }

  List<ChartValue> get members {
    return manga
        .where((item) => item.members != null)
        .map(
          (item) => ChartValue(
            label: item.title,
            value: item.members!.toDouble(),
          ),
        )
        .toList();
  }

  List<ChartValue> get chapters {
    return manga
        .where((item) => item.chapters != null)
        .map(
          (item) => ChartValue(
            label: item.title,
            value: item.chapters!.toDouble(),
          ),
        )
        .toList();
  }

  List<ChartValue> get volumes {
    return manga
        .where((item) => item.volumes != null)
        .map(
          (item) => ChartValue(
            label: item.title,
            value: item.volumes!.toDouble(),
          ),
        )
        .toList();
  }

  List<ChartValue> get rankings {
    return manga
        .where((item) => item.rank != null)
        .map(
          (item) => ChartValue(
            label: item.title,
            value: item.rank!.toDouble(),
          ),
        )
        .toList();
  }

  List<ChartPair> get scorePopularity {
    return manga
        .where(
          (item) =>
              item.score != null &&
              item.popularity != null,
        )
        .map(
          (item) => ChartPair(
            label: item.title,
            x: item.score!,
            y: item.popularity!.toDouble(),
          ),
        )
        .toList();
  }

  List<ChartPair> get scoreChapters {
    return manga
        .where(
          (item) =>
              item.score != null &&
              item.chapters != null,
        )
        .map(
          (item) => ChartPair(
            label: item.title,
            x: item.score!,
            y: item.chapters!.toDouble(),
          ),
        )
        .toList();
  }

  List<ChartPair> get popularityChapters {
    return manga
        .where(
          (item) =>
              item.popularity != null &&
              item.chapters != null,
        )
        .map(
          (item) => ChartPair(
            label: item.title,
            x: item.popularity!.toDouble(),
            y: item.chapters!.toDouble(),
          ),
        )
        .toList();
  }

  List<ChartCategory> get genres {
    final counts = <String, int>{};

    for (final item in manga) {
      for (final genre in item.genres) {
        counts[genre] = (counts[genre] ?? 0) + 1;
      }
    }

    return counts.entries
        .map(
          (entry) => ChartCategory(
            label: entry.key,
            value: entry.value.toDouble(),
          ),
        )
        .toList()
      ..sort(
        (a, b) => b.value.compareTo(a.value),
      );
  }

  List<ChartCategory> get types {
    final counts = <String, int>{};

    for (final item in manga) {
      final type = item.type;

      if (type == null || type.isEmpty) {
        continue;
      }

      counts[type] = (counts[type] ?? 0) + 1;
    }

    return counts.entries
        .map(
          (entry) => ChartCategory(
            label: entry.key,
            value: entry.value.toDouble(),
          ),
        )
        .toList()
      ..sort(
        (a, b) => b.value.compareTo(a.value),
      );
  }

  List<ChartCategory> get statuses {
    final counts = <String, int>{};

    for (final item in manga) {
      final status = item.status;

      if (status == null || status.isEmpty) {
        continue;
      }

      counts[status] = (counts[status] ?? 0) + 1;
    }

    return counts.entries
        .map(
          (entry) => ChartCategory(
            label: entry.key,
            value: entry.value.toDouble(),
          ),
        )
        .toList()
      ..sort(
        (a, b) => b.value.compareTo(a.value),
      );
  }

  List<ChartCategory> get years {
    final counts = <int, int>{};

    for (final item in manga) {
      final year = item.publishedFrom?.year;

      if (year == null) {
        continue;
      }

      counts[year] = (counts[year] ?? 0) + 1;
    }

    return counts.entries
        .map(
          (entry) => ChartCategory(
            label: entry.key.toString(),
            value: entry.value.toDouble(),
          ),
        )
        .toList()
      ..sort(
        (a, b) => a.label.compareTo(b.label),
      );
  }

  List<ChartCategory> get authors {
    final counts = <String, int>{};

    for (final item in manga) {
      for (final author in item.authors) {
        counts[author] = (counts[author] ?? 0) + 1;
      }
    }

    return counts.entries
        .map(
          (entry) => ChartCategory(
            label: entry.key,
            value: entry.value.toDouble(),
          ),
        )
        .toList()
      ..sort(
        (a, b) => b.value.compareTo(a.value),
      );
  }

  List<ChartValue> get topScores {
    final result = scores.toList();

    result.sort(
      (a, b) => b.value.compareTo(a.value),
    );

    return result;
  }

  List<ChartValue> get topPopularity {
    final result = popularity.toList();

    result.sort(
      (a, b) => b.value.compareTo(a.value),
    );

    return result;
  }

  List<ChartValue> get topChapters {
    final result = chapters.toList();

    result.sort(
      (a, b) => b.value.compareTo(a.value),
    );

    return result;
  }

  List<ChartValue> get topVolumes {
    final result = volumes.toList();

    result.sort(
      (a, b) => b.value.compareTo(a.value),
    );

    return result;
  }

  List<ChartValue> get topRankings {
    final result = rankings.toList();

    result.sort(
      (a, b) => a.value.compareTo(b.value),
    );

    return result;
  }

  double get averageScore {
    if (scores.isEmpty) {
      return 0;
    }

    final total = scores.fold<double>(
      0,
      (sum, item) => sum + item.value,
    );

    return total / scores.length;
  }

  double get averagePopularity {
    if (popularity.isEmpty) {
      return 0;
    }

    final total = popularity.fold<double>(
      0,
      (sum, item) => sum + item.value,
    );

    return total / popularity.length;
  }

  double get averageChapters {
    if (chapters.isEmpty) {
      return 0;
    }

    final total = chapters.fold<double>(
      0,
      (sum, item) => sum + item.value,
    );

    return total / chapters.length;
  }

  double get averageVolumes {
    if (volumes.isEmpty) {
      return 0;
    }

    final total = volumes.fold<double>(
      0,
      (sum, item) => sum + item.value,
    );

    return total / volumes.length;
  }

  Manga? get highestScored {
    final available = manga
        .where((item) => item.score != null)
        .toList();

    if (available.isEmpty) {
      return null;
    }

    return available.reduce(
      (a, b) =>
          (a.score ?? 0) >= (b.score ?? 0) ? a : b,
    );
  }

  Manga? get mostPopular {
    final available = manga
        .where((item) => item.popularity != null)
        .toList();

    if (available.isEmpty) {
      return null;
    }

    return available.reduce(
      (a, b) =>
          (a.popularity ?? 0) >=
                  (b.popularity ?? 0)
              ? a
              : b,
    );
  }
}

class ChartValue {
  final String label;
  final double value;

  const ChartValue({
    required this.label,
    required this.value,
  });
}

class ChartPair {
  final String label;
  final double x;
  final double y;

  const ChartPair({
    required this.label,
    required this.x,
    required this.y,
  });
}

class ChartCategory {
  final String label;
  final double value;

  const ChartCategory({
    required this.label,
    required this.value,
  });
}