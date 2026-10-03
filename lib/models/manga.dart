class Manga {
  final int id;
  final String title;
  final String? titleJapanese;
  final String? type;
  final int? chapters;
  final int? volumes;
  final String? status;
  final double? score;
  final int? rank;
  final int? popularity;
  final int? members;
  final List<String> genres;
  final List<String> authors;
  final DateTime? publishedFrom;
  final DateTime? publishedTo;
  final String? imageUrl;

  const Manga({
    required this.id,
    required this.title,
    this.titleJapanese,
    this.type,
    this.chapters,
    this.volumes,
    this.status,
    this.score,
    this.rank,
    this.popularity,
    this.members,
    this.genres = const [],
    this.authors = const [],
    this.publishedFrom,
    this.publishedTo,
    this.imageUrl,
  });
}