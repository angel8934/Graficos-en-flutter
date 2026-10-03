import 'package:flutter/material.dart';

import '../screens/home/home_screen.dart';
import 'routes.dart';

class MangaGraphNexusApp extends StatelessWidget {
  const MangaGraphNexusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Manga Graph Nexus',
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF08060F),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF8B5CF6),
          brightness: Brightness.dark,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0D0A18),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      home: const HomeScreen(),
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}