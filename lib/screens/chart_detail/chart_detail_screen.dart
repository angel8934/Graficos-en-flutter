import 'package:flutter/material.dart';

import '../../models/chart_case.dart';
import '../../models/chart_data_source.dart';
import '../../models/chart_definition.dart';
import '../../models/manga.dart';
import '../../widgets/magical_background.dart';

class ChartDetailScreen extends StatelessWidget {
  final ChartDefinition chart;
  final List<Manga> manga;

  const ChartDetailScreen({
    super.key,
    required this.chart,
    required this.manga,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MagicalBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(28),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 1400,
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    _buildTopBar(context),
                    const SizedBox(height: 30),
                    _buildTitle(),
                    const SizedBox(height: 20),
                    _buildTags(),
                    const SizedBox(height: 26),
                    _buildChart(context),
                    const SizedBox(height: 26),
                    _buildAcademicInfo(),
                    const SizedBox(height: 26),
                    _buildKeywords(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          chart.library.name,
          style: const TextStyle(
            color: Color(0xFFB967FF),
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        const Spacer(),
        Text(
          chart.id,
          style: TextStyle(
            color: Colors.white.withValues(
              alpha: 0.45,
            ),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Text(
          chart.title,
          style: const TextStyle(
            fontSize: 38,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          chart.description,
          style: TextStyle(
            fontSize: 16,
            height: 1.5,
            color: Colors.white.withValues(
              alpha: 0.62,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTags() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        _Tag(
          icon: Icons.auto_graph,
          text: chart.library.name,
        ),
        _Tag(
          icon: Icons.layers_outlined,
          text: chart.level.name,
        ),
        _Tag(
          icon: Icons.bar_chart_rounded,
          text: chart.chartType,
        ),
        _Tag(
          icon: Icons.tag,
          text: chart.id,
        ),
      ],
    );
  }

  Widget _buildChart(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 540,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF080611),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFF6D3A96),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF8B5CF6).withValues(
              alpha: 0.12,
            ),
            blurRadius: 35,
            spreadRadius: 2,
          ),
        ],
      ),
      child: _safeChartBuilder(context),
    );
  }

  Widget _safeChartBuilder(BuildContext context) {
    try {
      return chart.builder(
        context,
        ChartDataSource(
          manga: manga,
        ),
      );
    } catch (error, stackTrace) {
      debugPrint(
        'ERROR AL CONSTRUIR CHART: ${chart.id}',
      );
      debugPrint('$error');
      debugPrint('$stackTrace');

      return Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: const Color(0xFF160B1F),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: const Color(0xFF7F1D3A),
          ),
        ),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline_rounded,
              color: Colors.redAccent,
              size: 52,
            ),
            const SizedBox(height: 18),
            const Text(
              'ERROR AL CARGAR LA GRÁFICA',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              chart.id,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFFC084FC),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            SelectableText(
              '$error',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white70,
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildAcademicInfo() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final wide =
            constraints.maxWidth >= 850;

        final cards = [
          _InfoCard(
            icon: Icons.compare_arrows_rounded,
            title: 'DATOS COMPARADOS',
            text: chart.dataCompared,
          ),
          _InfoCard(
            icon: Icons.psychology_outlined,
            title: 'IDEAL PARA',
            text: chart.idealFor,
          ),
          _InfoCard(
            icon: Icons.school_outlined,
            title: 'NIVEL',
            text: chart.level.name,
          ),
          _InfoCard(
            icon: Icons.category_outlined,
            title: 'TIPO DE VISUALIZACION',
            text: chart.chartType,
          ),
        ];

        if (wide) {
          return GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 18,
            mainAxisSpacing: 18,
            shrinkWrap: true,
            physics:
                const NeverScrollableScrollPhysics(),
            childAspectRatio: 3.2,
            children: cards,
          );
        }

        return Column(
          children: [
            for (final card in cards) ...[
              card,
              const SizedBox(height: 14),
            ],
          ],
        );
      },
    );
  }

  Widget _buildKeywords() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: const Color(0xFF0D0A18),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF42205C),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          const Text(
            'KEYWORDS',
            style: TextStyle(
              color: Color(0xFFC084FC),
              fontSize: 14,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final keyword in chart.keywords)
                Container(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 11,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF211331),
                    borderRadius:
                        BorderRadius.circular(9),
                  ),
                  child: Text(
                    keyword,
                    style: const TextStyle(
                      color: Color(0xFFD8B4FE),
                      fontSize: 12,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final IconData icon;
  final String text;

  const _Tag({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF1B0D2B),
        borderRadius:
            BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFF54258A),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 15,
            color: const Color(0xFFC084FC),
          ),
          const SizedBox(width: 7),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String text;

  const _InfoCard({
    required this.icon,
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF0D0A18),
        borderRadius:
            BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFF42205C),
        ),
      ),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF211331),
              border: Border.all(
                color: const Color(0xFF6D3A96),
              ),
            ),
            child: Icon(
              icon,
              color: const Color(0xFFC084FC),
              size: 20,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFFC084FC),
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white70,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}