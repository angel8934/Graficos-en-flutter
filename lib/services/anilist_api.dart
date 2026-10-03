import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/manga.dart';

class AniListApi {
  static const String endpoint =
      'https://graphql.anilist.co';

  final http.Client client;

  AniListApi({
    http.Client? client,
  }) : client = client ?? http.Client();

  Future<List<Manga>> fetchTopManga({
    int page = 1,
    int perPage = 25,
  }) async {
    const query = r'''
query ($page: Int, $perPage: Int) {
  Page(page: $page, perPage: $perPage) {
    media(
      type: MANGA
      sort: SCORE_DESC
      isAdult: false
    ) {
      id
      title {
        romaji
        english
        native
      }
      type
      chapters
      volumes
      status
      averageScore
      popularity
      rankings {
        rank
        type
        allTime
      }
      genres
      staff {
        edges {
          role
          node {
            name {
              full
            }
          }
        }
      }
      startDate {
        year
        month
        day
      }
      endDate {
        year
        month
        day
      }
      coverImage {
        large
        medium
      }
    }
  }
}
''';

    return _request(
      query: query,
      variables: {
        'page': page,
        'perPage': perPage,
      },
    );
  }

  Future<List<Manga>> searchManga(
    String search, {
    int page = 1,
    int perPage = 25,
  }) async {
    const query = r'''
query ($search: String, $page: Int, $perPage: Int) {
  Page(page: $page, perPage: $perPage) {
    media(
      type: MANGA
      search: $search
      sort: SEARCH_MATCH
      isAdult: false
    ) {
      id
      title {
        romaji
        english
        native
      }
      type
      chapters
      volumes
      status
      averageScore
      popularity
      rankings {
        rank
        type
        allTime
      }
      genres
      staff {
        edges {
          role
          node {
            name {
              full
            }
          }
        }
      }
      startDate {
        year
        month
        day
      }
      endDate {
        year
        month
        day
      }
      coverImage {
        large
        medium
      }
    }
  }
}
''';

    return _request(
      query: query,
      variables: {
        'search': search,
        'page': page,
        'perPage': perPage,
      },
    );
  }

  Future<List<Manga>> _request({
    required String query,
    required Map<String, dynamic> variables,
  }) async {
    final uri = Uri.parse(endpoint);

    Object? lastError;

    for (var attempt = 1; attempt <= 3; attempt++) {
      try {
        final response = await client.post(
          uri,
          headers: const {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          body: jsonEncode({
            'query': query,
            'variables': variables,
          }),
        );

        if (response.statusCode == 200) {
          final decoded = jsonDecode(response.body);

          if (decoded is! Map<String, dynamic>) {
            throw Exception(
              'AniList devolvió una respuesta inválida.',
            );
          }

          final errors = decoded['errors'];

          if (errors is List && errors.isNotEmpty) {
            throw Exception(
              'AniList GraphQL: ${errors.first}',
            );
          }

          final data =
              decoded['data'] as Map<String, dynamic>?;

          final page =
              data?['Page'] as Map<String, dynamic>?;

          final media =
              page?['media'] as List<dynamic>?;

          if (media == null) {
            throw Exception(
              'AniList no devolvió resultados.',
            );
          }

          return media
              .whereType<Map<String, dynamic>>()
              .map(_mangaFromJson)
              .toList();
        }

        lastError = Exception(
          'AniList HTTP ${response.statusCode}: '
          '${response.body}',
        );

        if (attempt < 3) {
          await Future.delayed(
            Duration(seconds: attempt * 2),
          );
        }
      } catch (error) {
        lastError = error;

        if (attempt < 3) {
          await Future.delayed(
            Duration(seconds: attempt * 2),
          );
        }
      }
    }

    throw Exception(
      'AniList no está disponible después de '
      'varios intentos. $lastError',
    );
  }

  Manga _mangaFromJson(
    Map<String, dynamic> json,
  ) {
    final title =
        json['title'] as Map<String, dynamic>?;

    final rankings =
        json['rankings'] as List<dynamic>? ?? [];

    int? rank;

    for (final item in rankings) {
      if (item is Map<String, dynamic> &&
          item['rank'] is int) {
        rank = item['rank'] as int;
        break;
      }
    }

    final staff =
        json['staff'] as Map<String, dynamic>?;

    final edges =
        staff?['edges'] as List<dynamic>? ?? [];

    final authors = <String>[];

    for (final edge in edges) {
      if (edge is! Map<String, dynamic>) {
        continue;
      }

      final role = edge['role'] as String? ?? '';

      if (!role.toLowerCase().contains('story') &&
          !role.toLowerCase().contains('art') &&
          !role.toLowerCase().contains('author')) {
        continue;
      }

      final node =
          edge['node'] as Map<String, dynamic>?;

      final name =
          node?['name'] as Map<String, dynamic>?;

      final fullName =
          name?['full'] as String?;

      if (fullName != null &&
          fullName.isNotEmpty &&
          !authors.contains(fullName)) {
        authors.add(fullName);
      }
    }

    final startDate =
        json['startDate'] as Map<String, dynamic>?;

    final endDate =
        json['endDate'] as Map<String, dynamic>?;

    DateTime? buildDate(
      Map<String, dynamic>? date,
    ) {
      if (date == null) {
        return null;
      }

      final year = date['year'] as int?;
      final month = date['month'] as int?;
      final day = date['day'] as int?;

      if (year == null) {
        return null;
      }

      return DateTime(
        year,
        month ?? 1,
        day ?? 1,
      );
    }

    final cover =
        json['coverImage'] as Map<String, dynamic>?;

    final romaji =
        title?['romaji'] as String?;

    final english =
        title?['english'] as String?;

    final native =
        title?['native'] as String?;

    final displayTitle =
        english?.isNotEmpty == true
            ? english!
            : romaji?.isNotEmpty == true
                ? romaji!
                : native ?? 'Sin título';

    return Manga(
      id: json['id'] as int? ?? 0,
      title: displayTitle,
      titleJapanese: native,
      type: json['type'] as String?,
      chapters: json['chapters'] as int?,
      volumes: json['volumes'] as int?,
      status: json['status'] as String?,
      score:
          (json['averageScore'] as num?)?.toDouble(),
      rank: rank,
      popularity: json['popularity'] as int?,
      members: json['popularity'] as int?,
      genres:
          (json['genres'] as List<dynamic>? ?? [])
              .whereType<String>()
              .toList(),
      authors: authors,
      publishedFrom: buildDate(startDate),
      publishedTo: buildDate(endDate),
      imageUrl:
          cover?['large'] as String? ??
          cover?['medium'] as String?,
    );
  }

  void dispose() {
    client.close();
  }
}