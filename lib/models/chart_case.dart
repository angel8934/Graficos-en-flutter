enum ChartLevel {
  basic,
  advanced,
}

extension ChartLevelExtension on ChartLevel {
  String get name {
    switch (this) {
      case ChartLevel.basic:
        return 'Básica';
      case ChartLevel.advanced:
        return 'Avanzada';
    }
  }
}