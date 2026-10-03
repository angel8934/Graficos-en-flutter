import 'package:flutter_test/flutter_test.dart';

import 'package:manga_graph_nexus/app/app.dart';

void main() {
  testWidgets(
    'Manga Graph Nexus inicia correctamente',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const MangaGraphNexusApp(),
      );

      expect(
        find.text('MANGA GRAPH NEXUS'),
        findsOneWidget,
      );

      expect(
        find.text('THE CHART LIBRARY BATTLEFIELD'),
        findsOneWidget,
      );
    },
  );
}