import '../../models/chart_definition.dart';
import '../../models/chart_library.dart';
import '../generated_chart_factory.dart';

class FlChartRegistry {
  static List<ChartDefinition> all() {
    return GeneratedChartFactory.forLibrary(
      ChartLibrary.flChart,
    );
  }
}