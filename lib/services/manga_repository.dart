import '../models/manga.dart';
import 'anilist_api.dart';

class MangaRepository {
  final AniListApi api;

  MangaRepository({
    AniListApi? api,
  }) : api = api ?? AniListApi();

  Future<List<Manga>> getTopManga() {
    return api.fetchTopManga(
      page: 1,
      perPage: 25,
    );
  }

  Future<List<Manga>> search(String query) {
    return api.searchManga(
      query,
      page: 1,
      perPage: 25,
    );
  }

  void dispose() {
    api.dispose();
  }
}