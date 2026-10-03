enum ChartLibrary {
  flChart,
  graphic,
  syncfusion,
  chartsPainter,
  fusionCharts,
  fastCharts,
}

extension ChartLibraryExtension on ChartLibrary {
  String get name {
    switch (this) {
      case ChartLibrary.flChart:
        return 'FL Chart';
      case ChartLibrary.graphic:
        return 'Graphic';
      case ChartLibrary.syncfusion:
        return 'Syncfusion';
      case ChartLibrary.chartsPainter:
        return 'Charts Painter';
      case ChartLibrary.fusionCharts:
        return 'Fusion Charts';
      case ChartLibrary.fastCharts:
        return 'Fast Charts';
    }
  }

  String get folder {
    switch (this) {
      case ChartLibrary.flChart:
        return 'fl_chart';
      case ChartLibrary.graphic:
        return 'graphic';
      case ChartLibrary.syncfusion:
        return 'syncfusion';
      case ChartLibrary.chartsPainter:
        return 'charts_painter';
      case ChartLibrary.fusionCharts:
        return 'fusion';
      case ChartLibrary.fastCharts:
        return 'fast_charts';
    }
  }
}