import 'package:flutter/material.dart';

import '../../data/chart_catalog.dart';
import '../../models/chart_case.dart';
import '../../models/chart_definition.dart';
import '../../models/chart_library.dart';
import '../../models/manga.dart';
import '../../widgets/magical_background.dart';

class LibraryScreen extends StatefulWidget {
  final ChartLibrary library;
  final List<Manga> manga;

  const LibraryScreen({
    super.key,
    required this.library,
    required this.manga,
  });

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final TextEditingController _searchController =
      TextEditingController();

  String _query = '';

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      length: 2,
      vsync: this,
    );

    _searchController.addListener(() {
      if (!mounted) {
        return;
      }

      setState(() {
        _query =
            _searchController.text.trim().toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<ChartDefinition> _charts(ChartLevel level) {
    final charts =
        ChartCatalog.forLibrary(widget.library)
            .where(
              (chart) => chart.level == level,
            )
            .toList();

    if (_query.isEmpty) {
      return charts;
    }

    return charts.where((chart) {
      final content = [
        chart.id,
        chart.title,
        chart.description,
        chart.dataCompared,
        chart.idealFor,
        chart.chartType,
        ...chart.keywords,
      ].join(' ').toLowerCase();

      return content.contains(_query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MagicalBackground(
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(context),
              _buildSearch(),
              const SizedBox(height: 18),
              _buildTabs(),
              const SizedBox(height: 18),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildChartGrid(
                      _charts(ChartLevel.basic),
                    ),
                    _buildChartGrid(
                      _charts(ChartLevel.advanced),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final total =
        ChartCatalog.forLibrary(widget.library).length;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        24,
        20,
        24,
        8,
      ),
      child: Row(
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
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  widget.library.name,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$total visualizaciones disponibles',
                  style: TextStyle(
                    color: Colors.white.withValues(
                      alpha: 0.55,
                    ),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  '${widget.manga.length} mangas disponibles',
                  style: TextStyle(
                    color: Colors.white.withValues(
                      alpha: 0.35,
                    ),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 9,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF1B0D2B),
              borderRadius:
                  BorderRadius.circular(14),
              border: Border.all(
                color: const Color(0xFF6D3A96),
              ),
            ),
            child: Text(
              widget.library.folder,
              style: const TextStyle(
                color: Color(0xFFD8B4FE),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 28,
      ),
      child: TextField(
        controller: _searchController,
        style: const TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          hintText:
              'Buscar por nombre, tipo, métrica, manga...',
          hintStyle: TextStyle(
            color: Colors.white.withValues(
              alpha: 0.4,
            ),
          ),
          prefixIcon: const Icon(
            Icons.search_rounded,
            color: Color(0xFFB967FF),
          ),
          suffixIcon: _query.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    _searchController.clear();
                  },
                  icon: const Icon(
                    Icons.close_rounded,
                    color: Colors.white54,
                  ),
                )
              : null,
          filled: true,
          fillColor: const Color(0xFF0D0A18),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(
              color: Color(0xFF42205C),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(
              color: Color(0xFF42205C),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(
              color: Color(0xFFB967FF),
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 28,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF0D0A18),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF42205C),
        ),
      ),
      child: TabBar(
        controller: _tabController,
        indicatorSize:
            TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          gradient: const LinearGradient(
            colors: [
              Color(0xFF6D28D9),
              Color(0xFF9333EA),
            ],
          ),
        ),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white54,
        tabs: [
          Tab(
            text:
                'BASICAS (${_charts(ChartLevel.basic).length})',
          ),
          Tab(
            text:
                'AVANZADAS (${_charts(ChartLevel.advanced).length})',
          ),
        ],
      ),
    );
  }

  Widget _buildChartGrid(
    List<ChartDefinition> charts,
  ) {
    if (charts.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.search_off_rounded,
              size: 60,
              color: Color(0xFF8B5CF6),
            ),
            const SizedBox(height: 16),
            Text(
              'No se encontraron charts',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white.withValues(
                  alpha: 0.85,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Prueba con otro término de búsqueda.',
              style: TextStyle(
                color: Colors.white.withValues(
                  alpha: 0.5,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final width =
            constraints.maxWidth;

        final columns = width >= 1300
            ? 4
            : width >= 900
                ? 3
                : width >= 600
                    ? 2
                    : 1;

        return GridView.builder(
          padding:
              const EdgeInsets.fromLTRB(
            28,
            0,
            28,
            30,
          ),
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: 18,
            mainAxisSpacing: 18,
            childAspectRatio: 1.35,
          ),
          itemCount: charts.length,
          itemBuilder: (context, index) {
            final chart = charts[index];

            return _ChartCard(
              chart: chart,
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/chart-detail',
                  arguments: {
                    'chart': chart,
                    'manga': widget.manga,
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}

class _ChartCard extends StatefulWidget {
  final ChartDefinition chart;
  final VoidCallback onTap;

  const _ChartCard({
    required this.chart,
    required this.onTap,
  });

  @override
  State<_ChartCard> createState() =>
      _ChartCardState();
}

class _ChartCardState
    extends State<_ChartCard> {
  bool hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        setState(() {
          hovering = true;
        });
      },
      onExit: (_) {
        setState(() {
          hovering = false;
        });
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration:
              const Duration(milliseconds: 180),
          transform: Matrix4.translationValues(
            0,
            hovering ? -4.0 : 0,
            0,
          ),
          padding:
              const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF0D0A18),
            borderRadius:
                BorderRadius.circular(20),
            border: Border.all(
              color: hovering
                  ? const Color(0xFFB967FF)
                  : const Color(0xFF42205C),
              width: hovering ? 1.5 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color:
                    const Color(0xFF8B5CF6)
                        .withValues(
                  alpha:
                      hovering ? 0.22 : 0.06,
                ),
                blurRadius:
                    hovering ? 24 : 10,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration:
                        const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient:
                          LinearGradient(
                        colors: [
                          Color(0xFF7C3AED),
                          Color(0xFFB967FF),
                        ],
                      ),
                    ),
                    child: const Icon(
                      Icons.bar_chart_rounded,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      widget.chart.id,
                      style:
                          const TextStyle(
                        color:
                            Color(0xFFC084FC),
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons
                        .arrow_forward_ios_rounded,
                    size: 14,
                    color: Colors.white38,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                widget.chart.title,
                maxLines: 2,
                overflow:
                    TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight:
                      FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.chart.description,
                maxLines: 2,
                overflow:
                    TextOverflow.ellipsis,
                style: TextStyle(
                  height: 1.35,
                  fontSize: 13,
                  color: Colors.white
                      .withValues(
                    alpha: 0.55,
                  ),
                ),
              ),
              const Spacer(),
              Wrap(
                spacing: 7,
                runSpacing: 7,
                children: [
                  _Tag(
                    text:
                        widget.chart.chartType,
                  ),
                  _Tag(
                    text:
                        widget.chart.level.name,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final String text;

  const _Tag({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF211331),
        borderRadius:
            BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 11,
          color: Color(0xFFD8B4FE),
        ),
      ),
    );
  }
}