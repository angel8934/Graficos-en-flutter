import '../models/chart_definition.dart';

class SearchResult {
  final ChartDefinition chart;
  final int score;
  final List<String> matchedKeywords;

  const SearchResult({
    required this.chart,
    required this.score,
    required this.matchedKeywords,
  });
}