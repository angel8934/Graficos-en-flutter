import '../charts/charts_painter/registry.dart';
import '../charts/fast_charts/registry.dart';
import '../charts/fl_chart/registry.dart';
import '../charts/fusion/registry.dart';
import '../charts/graphic/registry.dart';
import '../charts/syncfusion/registry.dart';
import '../models/chart_definition.dart';
import '../models/chart_library.dart';

class ChartCatalog {
  static List<ChartDefinition> all() {
    return [
      ...FlChartRegistry.all(),
      ...GraphicRegistry.all(),
      ...SyncfusionRegistry.all(),
      ...ChartsPainterRegistry.all(),
      ...FusionRegistry.all(),
      ...FastChartsRegistry.all(),
    ];
  }

  static List<ChartDefinition> forLibrary(
    ChartLibrary library,
  ) {
    return all()
        .where(
          (chart) => chart.library == library,
        )
        .toList();
  }

  static int get total {
    return all().length;
  }
}