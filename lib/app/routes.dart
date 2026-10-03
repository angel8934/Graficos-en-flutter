import 'package:flutter/material.dart';

import '../models/chart_definition.dart';
import '../models/chart_library.dart';
import '../models/manga.dart';
import '../screens/chart_detail/chart_detail_screen.dart';
import '../screens/library/library_screen.dart';

class AppRoutes {
  static Route<dynamic> onGenerateRoute(
    RouteSettings settings,
  ) {
    switch (settings.name) {
      case '/library':
        final arguments =
            settings.arguments as Map<String, dynamic>? ?? {};

        final library =
            arguments['library'] as ChartLibrary;

        final manga =
            arguments['manga'] as List<Manga>? ?? [];

        return MaterialPageRoute(
          builder: (_) => LibraryScreen(
            library: library,
            manga: manga,
          ),
        );

      case '/chart-detail':
        final arguments =
            settings.arguments as Map<String, dynamic>? ?? {};

        final chart =
            arguments['chart'] as ChartDefinition;

        final manga =
            arguments['manga'] as List<Manga>? ?? [];

        return MaterialPageRoute(
          builder: (_) => ChartDetailScreen(
            chart: chart,
            manga: manga,
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            backgroundColor: Color(0xFF08060F),
            body: Center(
              child: Text(
                'Ruta no encontrada',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
    }
  }
}