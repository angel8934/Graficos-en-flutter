import '../models/manga.dart';

class MangaAnalytics {
  static List<double> scores(
    List<Manga> manga,
  ) {
    return manga
        .where((item) => item.score != null)
        .map((item) => item.score!)
        .toList();
  }

  static List<double> popularity(
    List<Manga> manga,
  ) {
    return manga
        .where((item) => item.popularity != null)
        .map((item) => item.popularity!.toDouble())
        .toList();
  }

  static List<double> members(
    List<Manga> manga,
  ) {
    return manga
        .where((item) => item.members != null)
        .map((item) => item.members!.toDouble())
        .toList();
  }

  static List<double> chapters(
    List<Manga> manga,
  ) {
    return manga
        .where((item) => item.chapters != null)
        .map((item) => item.chapters!.toDouble())
        .toList();
  }

  static Map<String, int> genreCounts(
    List<Manga> manga,
  ) {
    final result = <String, int>{};

    for (final item in manga) {
      for (final genre in item.genres) {
        result[genre] = (result[genre] ?? 0) + 1;
      }
    }

    return result;
  }

  static Map<String, int> typeCounts(
    List<Manga> manga,
  ) {
    final result = <String, int>{};

    for (final item in manga) {
      final type = item.type;

      if (type == null || type.isEmpty) {
        continue;
      }

      result[type] = (result[type] ?? 0) + 1;
    }

    return result;
  }

  static Map<String, int> statusCounts(
    List<Manga> manga,
  ) {
    final result = <String, int>{};

    for (final item in manga) {
      final status = item.status;

      if (status == null || status.isEmpty) {
        continue;
      }

      result[status] = (result[status] ?? 0) + 1;
    }

    return result;
  }

  static double averageScore(
    List<Manga> manga,
  ) {
    final values = scores(manga);

    if (values.isEmpty) {
      return 0;
    }

    return values.reduce((a, b) => a + b) /
        values.length;
  }

  static int totalMembers(
    List<Manga> manga,
  ) {
    return manga.fold(
      0,
      (total, item) =>
          total + (item.members ?? 0),
    );
  }

  static int totalChapters(
    List<Manga> manga,
  ) {
    return manga.fold(
      0,
      (total, item) =>
          total + (item.chapters ?? 0),
    );
  }

  static Manga? highestScored(
    List<Manga> manga,
  ) {
    final values = manga
        .where((item) => item.score != null)
        .toList();

    if (values.isEmpty) {
      return null;
    }

    values.sort(
      (a, b) => b.score!.compareTo(a.score!),
    );

    return values.first;
  }
}