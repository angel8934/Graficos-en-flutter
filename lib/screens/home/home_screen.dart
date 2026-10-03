import 'package:flutter/material.dart';

import '../../data/chart_catalog.dart';
import '../../data/manga_analytics.dart';
import '../../models/chart_definition.dart';
import '../../models/chart_library.dart';
import '../../models/manga.dart';
import '../../search/chart_search_engine.dart';
import '../../search/search_result.dart';
import '../../services/manga_repository.dart';
import '../../widgets/library_orb.dart';
import '../../widgets/magical_background.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MangaRepository _repository = MangaRepository();

  final TextEditingController _mangaSearchController =
      TextEditingController();

  final TextEditingController _chartSearchController =
      TextEditingController();

  List<Manga> _manga = [];

  List<SearchResult> _chartResults = [];

  bool _loading = true;

  String? _error;

  @override
  void initState() {
    super.initState();

    _chartSearchController.addListener(
      _searchChartsLive,
    );

    _loadManga();
  }

  @override
  void dispose() {
    _mangaSearchController.dispose();
    _chartSearchController.dispose();
    _repository.dispose();

    super.dispose();
  }

  Future<void> _loadManga() async {
    try {
      final manga = await _repository.getTopManga();

      if (!mounted) {
        return;
      }

      setState(() {
        _manga = manga;
        _loading = false;
        _error = null;
      });
    } catch (error) {
      if (!mounted) {
        return;
      }

      setState(() {
        _loading = false;
        _error = error.toString();
      });
    }
  }

  Future<void> _searchManga() async {
    final query =
        _mangaSearchController.text.trim();

    if (query.isEmpty) {
      await _loadManga();
      return;
    }

    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final manga =
          await _repository.search(query);

      if (!mounted) {
        return;
      }

      setState(() {
        _manga = manga;
        _loading = false;
        _error = null;
      });
    } catch (error) {
      if (!mounted) {
        return;
      }

      setState(() {
        _loading = false;
        _error = error.toString();
      });
    }
  }

  void _searchChartsLive() {
    final query =
        _chartSearchController.text.trim();

    final results = ChartSearchEngine.search(
      ChartCatalog.all(),
      query,
    );

    if (!mounted) {
      return;
    }

    setState(() {
      _chartResults = results;
    });
  }

  void _openChart(ChartDefinition chart) {
    Navigator.pushNamed(
      context,
      '/chart-detail',
      arguments: {
        'chart': chart,
        'manga': _manga,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MagicalBackground(
        child: SafeArea(
          child: RefreshIndicator(
            onRefresh: _loadManga,
            child: SingleChildScrollView(
              physics:
                  const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(
                horizontal: 28,
                vertical: 32,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 1400,
                  ),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      _buildHero(),
                      const SizedBox(height: 32),
                      _buildMangaSearch(),
                      const SizedBox(height: 28),
                      _buildApiHeader(),
                      const SizedBox(height: 16),
                      _buildAnalytics(),
                      const SizedBox(height: 28),
                      _buildMangaSection(),
                      const SizedBox(height: 45),
                      _buildChartIntelligence(),
                      const SizedBox(height: 45),
                      _buildLibraryHeader(),
                      const SizedBox(height: 24),
                      _buildLibraries(),
                      const SizedBox(height: 35),
                      _buildCatalogSummary(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHero() {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 15),
          const Text(
            'MANGA GRAPH NEXUS',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 46,
              fontWeight: FontWeight.w900,
              letterSpacing: 5,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'THE CHART LIBRARY BATTLEFIELD',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              letterSpacing: 3,
              color: Color(0xFFB967FF),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            'Datos reales de manga + visualizacion academica '
            '+ comparacion de librerias Flutter.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              color: Colors.white.withValues(
                alpha: 0.62,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMangaSearch() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _mangaSearchController,
            onSubmitted: (_) => _searchManga(),
            style: const TextStyle(
              color: Colors.white,
            ),
            decoration: InputDecoration(
              hintText:
                  'Buscar manga en AniList...',
              hintStyle: TextStyle(
                color: Colors.white.withValues(
                  alpha: 0.4,
                ),
              ),
              prefixIcon: const Icon(
                Icons.search_rounded,
                color: Color(0xFFB967FF),
              ),
              filled: true,
              fillColor:
                  const Color(0xFF0D0A18),
              border: _inputBorder(),
              enabledBorder: _inputBorder(),
              focusedBorder: _focusedBorder(),
            ),
          ),
        ),
        const SizedBox(width: 12),
        SizedBox(
          height: 56,
          child: ElevatedButton.icon(
            onPressed:
                _loading ? null : _searchManga,
            icon:
                const Icon(Icons.search),
            label:
                const Text('BUSCAR'),
          ),
        ),
      ],
    );
  }

  Widget _buildChartIntelligence() {
    final hasQuery =
        _chartSearchController.text
            .trim()
            .isNotEmpty;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF0A0712),
        borderRadius:
            BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFF6D3A96),
        ),
        boxShadow: [
          BoxShadow(
            color:
                const Color(0xFF8B5CF6)
                    .withValues(
              alpha: 0.10,
            ),
            blurRadius: 30,
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
                width: 44,
                height: 44,
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
                  Icons.auto_awesome,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CHART INTELLIGENCE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                        fontWeight:
                            FontWeight.w900,
                        letterSpacing: 1.4,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Busca visualizaciones por intencion.',
                      style: TextStyle(
                        color: Colors.white54,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '${ChartCatalog.total} CHARTS',
                style: const TextStyle(
                  color: Color(0xFFC084FC),
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          TextField(
            controller:
                _chartSearchController,
            style: const TextStyle(
              color: Colors.white,
            ),
            decoration: InputDecoration(
              hintText:
                  'Ej: comparar score y popularidad...',
              hintStyle: TextStyle(
                color: Colors.white.withValues(
                  alpha: 0.38,
                ),
              ),
              prefixIcon: const Icon(
                Icons.psychology_outlined,
                color: Color(0xFFB967FF),
              ),
              suffixIcon: hasQuery
                  ? IconButton(
                      onPressed: () {
                        _chartSearchController
                            .clear();
                      },
                      icon: const Icon(
                        Icons.close_rounded,
                        color: Colors.white54,
                      ),
                    )
                  : null,
              filled: true,
              fillColor:
                  const Color(0xFF0D0A18),
              border: _inputBorder(),
              enabledBorder:
                  _inputBorder(),
              focusedBorder:
                  _focusedBorder(),
            ),
          ),
          if (!hasQuery) ...[
            const SizedBox(height: 16),
            _buildSearchSuggestions(),
          ],
          if (hasQuery) ...[
            const SizedBox(height: 20),
            _buildChartResults(),
          ],
        ],
      ),
    );
  }

  Widget _buildSearchSuggestions() {
    const suggestions = [
      'score',
      'popularidad',
      'capitulos',
      'scatter',
      'multiserie',
      'avanzado',
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final suggestion
            in suggestions)
          ActionChip(
            label: Text(suggestion),
            onPressed: () {
              _chartSearchController.text =
                  suggestion;

              _chartSearchController
                  .selection =
                  TextSelection.collapsed(
                offset:
                    suggestion.length,
              );
            },
          ),
      ],
    );
  }

  Widget _buildChartResults() {
    if (_chartResults.isEmpty) {
      return Container(
        width: double.infinity,
        padding:
            const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color:
              const Color(0xFF120B1B),
          borderRadius:
              BorderRadius.circular(16),
          border: Border.all(
            color:
                const Color(0xFF42205C),
          ),
        ),
        child: const Row(
          children: [
            Icon(
              Icons.search_off_rounded,
              color:
                  Color(0xFFB967FF),
            ),
            SizedBox(width: 12),
            Text(
              'No se encontraron visualizaciones.',
              style: TextStyle(
                color: Colors.white70,
              ),
            ),
          ],
        ),
      );
    }

    final results =
        _chartResults.take(12).toList();

    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Text(
          '${_chartResults.length} resultados encontrados',
          style: const TextStyle(
            color: Color(0xFFC084FC),
            fontWeight:
                FontWeight.bold,
          ),
        ),
        const SizedBox(height: 14),
        LayoutBuilder(
          builder:
              (context, constraints) {
            final columns =
                constraints.maxWidth >=
                        1000
                    ? 3
                    : constraints.maxWidth >=
                            650
                        ? 2
                        : 1;

            return GridView.builder(
              shrinkWrap: true,
              physics:
                  const NeverScrollableScrollPhysics(),
              itemCount:
                  results.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:
                    columns,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 2.4,
              ),
              itemBuilder:
                  (context, index) {
                final result =
                    results[index];

                return _SearchResultCard(
                  result: result,
                  onTap: () {
                    _openChart(
                      result.chart,
                    );
                  },
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildApiHeader() {
    return Row(
      children: [
        const Icon(
          Icons.public,
          color: Color(0xFFB967FF),
        ),
        const SizedBox(width: 10),
        const Text(
          'MANGA DATA CORE',
          style: TextStyle(
            fontSize: 20,
            fontWeight:
                FontWeight.w900,
            color: Colors.white,
            letterSpacing: 1.5,
          ),
        ),
        const Spacer(),
        if (_loading)
          const SizedBox(
            width: 18,
            height: 18,
            child:
                CircularProgressIndicator(
              strokeWidth: 2,
            ),
          ),
      ],
    );
  }

  Widget _buildAnalytics() {
    final average =
        MangaAnalytics.averageScore(
      _manga,
    );

    final totalMembers =
        MangaAnalytics.totalMembers(
      _manga,
    );

    final totalChapters =
        MangaAnalytics.totalChapters(
      _manga,
    );

    final highest =
        MangaAnalytics.highestScored(
      _manga,
    );

    return Wrap(
      spacing: 14,
      runSpacing: 14,
      children: [
        _Metric(
          value: '${_manga.length}',
          label: 'MANGA',
        ),
        _Metric(
          value:
              average.toStringAsFixed(1),
          label: 'SCORE MEDIO',
        ),
        _Metric(
          value: '$totalMembers',
          label: 'POPULARIDAD',
        ),
        _Metric(
          value: '$totalChapters',
          label: 'CAPITULOS',
        ),
        _Metric(
          value:
              highest?.title ?? '-',
          label: 'MAYOR SCORE',
          wide: true,
        ),
      ],
    );
  }

  Widget _buildMangaSection() {
    if (_error != null) {
      return Container(
        width: double.infinity,
        padding:
            const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color:
              const Color(0xFF170A12),
          borderRadius:
              BorderRadius.circular(18),
          border: Border.all(
            color:
                const Color(0xFF7F1D3A),
          ),
        ),
        child: Row(
          children: [
            const Icon(
              Icons
                  .warning_amber_rounded,
              color: Colors.orange,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'No se pudieron cargar los datos de AniList.',
                style: TextStyle(
                  color:
                      Colors.white.withValues(
                    alpha: 0.8,
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: _loadManga,
              child:
                  const Text('REINTENTAR'),
            ),
          ],
        ),
      );
    }

    if (_loading && _manga.isEmpty) {
      return const SizedBox(
        height: 160,
        child: Center(
          child:
              CircularProgressIndicator(),
        ),
      );
    }

    if (_manga.isEmpty) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: 220,
      child: ListView.separated(
        scrollDirection:
            Axis.horizontal,
        itemCount: _manga.length,
        separatorBuilder: (_, _) =>
            const SizedBox(width: 14),
        itemBuilder:
            (context, index) {
          return _MangaCard(
            manga: _manga[index],
          );
        },
      ),
    );
  }

  Widget _buildLibraryHeader() {
    return const Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Text(
          'CHART LIBRARY BATTLEFIELD',
          style: TextStyle(
            fontSize: 26,
            fontWeight:
                FontWeight.w900,
            color: Colors.white,
            letterSpacing: 2,
          ),
        ),
        SizedBox(height: 7),
        Text(
          'Selecciona una libreria para explorar sus visualizaciones basicas y avanzadas.',
          style: TextStyle(
            color: Colors.white54,
          ),
        ),
      ],
    );
  }

  Widget _buildLibraries() {
    return Wrap(
      alignment:
          WrapAlignment.center,
      spacing: 28,
      runSpacing: 28,
      children: [
        for (final library
            in ChartLibrary.values)
          LibraryOrb(
            library: library,
            chartCount:
                ChartCatalog
                    .forLibrary(
              library,
            )
                    .length,
            onTap: () {
              Navigator.pushNamed(
                context,
                '/library',
                arguments: {
                  'library':
                      library,
                  'manga': _manga,
                },
              );
            },
          ),
      ],
    );
  }

  Widget _buildCatalogSummary() {
    return Container(
      width: double.infinity,
      padding:
          const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color:
            const Color(0xFF0D0A18),
        borderRadius:
            BorderRadius.circular(22),
        border: Border.all(
          color:
              const Color(0xFF42205C),
        ),
      ),
      child: Wrap(
        alignment:
            WrapAlignment.spaceAround,
        spacing: 30,
        runSpacing: 20,
        children: [
          _Metric(
            value:
                '${ChartCatalog.total}',
            label: 'CHARTS',
          ),
          const _Metric(
            value: '6',
            label: 'LIBRERIAS',
          ),
          const _Metric(
            value: '300',
            label: 'BASICOS',
          ),
          const _Metric(
            value: '210',
            label: 'AVANZADOS',
          ),
        ],
      ),
    );
  }

  InputBorder _inputBorder() {
    return OutlineInputBorder(
      borderRadius:
          BorderRadius.circular(18),
      borderSide:
          const BorderSide(
        color: Color(0xFF42205C),
      ),
    );
  }

  InputBorder _focusedBorder() {
    return OutlineInputBorder(
      borderRadius:
          BorderRadius.circular(18),
      borderSide:
          const BorderSide(
        color: Color(0xFFB967FF),
        width: 1.5,
      ),
    );
  }
}

class _SearchResultCard
    extends StatefulWidget {
  final SearchResult result;
  final VoidCallback onTap;

  const _SearchResultCard({
    required this.result,
    required this.onTap,
  });

  @override
  State<_SearchResultCard> createState() =>
      _SearchResultCardState();
}

class _SearchResultCardState
    extends State<_SearchResultCard> {
  bool hovering = false;

  @override
  Widget build(BuildContext context) {
    final chart =
        widget.result.chart;

    return MouseRegion(
      cursor:
          SystemMouseCursors.click,
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
              const Duration(
            milliseconds: 160,
          ),
          padding:
              const EdgeInsets.all(14),
          decoration:
              BoxDecoration(
            color:
                const Color(0xFF0D0A18),
            borderRadius:
                BorderRadius.circular(
              16,
            ),
            border: Border.all(
              color: hovering
                  ? const Color(
                      0xFFB967FF,
                    )
                  : const Color(
                      0xFF42205C,
                    ),
            ),
          ),
          child: Row(
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
                      Color(0xFF6D28D9),
                      Color(0xFFB967FF),
                    ],
                  ),
                ),
                child: const Icon(
                  Icons
                      .bar_chart_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                  mainAxisAlignment:
                      MainAxisAlignment
                          .center,
                  children: [
                    Text(
                      chart.id,
                      style:
                          const TextStyle(
                        color:
                            Color(0xFFC084FC),
                        fontSize: 11,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      chart.title,
                      maxLines: 1,
                      overflow:
                          TextOverflow.ellipsis,
                      style:
                          const TextStyle(
                        color: Colors.white,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      '${chart.library.name} · ${chart.level.name}',
                      style:
                          const TextStyle(
                        color:
                            Colors.white54,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons
                    .arrow_forward_ios_rounded,
                size: 13,
                color:
                    Colors.white38,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Metric
    extends StatelessWidget {
  final String value;
  final String label;
  final bool wide;

  const _Metric({
    required this.value,
    required this.label,
    this.wide = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: wide ? 230 : 150,
      padding:
          const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      decoration:
          BoxDecoration(
        color:
            const Color(0xFF0D0A18),
        borderRadius:
            BorderRadius.circular(
          16,
        ),
        border: Border.all(
          color:
              const Color(0xFF42205C),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            value,
            maxLines: 1,
            overflow:
                TextOverflow.ellipsis,
            style:
                const TextStyle(
              color:
                  Color(0xFFC084FC),
              fontSize: 22,
              fontWeight:
                  FontWeight.w900,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style:
                const TextStyle(
              color:
                  Colors.white54,
              fontSize: 10,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

class _MangaCard
    extends StatelessWidget {
  final Manga manga;

  const _MangaCard({
    required this.manga,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 190,
      padding:
          const EdgeInsets.all(12),
      decoration:
          BoxDecoration(
        color:
            const Color(0xFF0D0A18),
        borderRadius:
            BorderRadius.circular(
          18,
        ),
        border: Border.all(
          color:
              const Color(0xFF42205C),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius:
                  BorderRadius.circular(
                12,
              ),
              child: manga.imageUrl != null
                  ? Image.network(
                      manga.imageUrl!,
                      width:
                          double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder:
                          (_, _, _) =>
                              _placeholder(),
                    )
                  : _placeholder(),
            ),
          ),
          const SizedBox(height: 9),
          Text(
            manga.title,
            maxLines: 1,
            overflow:
                TextOverflow.ellipsis,
            style:
                const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Score: ${manga.score?.toStringAsFixed(1) ?? '-'}',
            style:
                const TextStyle(
              color:
                  Color(0xFFB967FF),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      color:
          const Color(0xFF1B1028),
      child: const Center(
        child: Icon(
          Icons
              .menu_book_rounded,
          size: 42,
          color:
              Color(0xFF8B5CF6),
        ),
      ),
    );
  }
}