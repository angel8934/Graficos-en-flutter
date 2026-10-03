import 'package:flutter/material.dart';

import '../models/chart_case.dart';
import '../models/chart_definition.dart';

class ChartCard extends StatefulWidget {
  final ChartDefinition chart;
  final VoidCallback onTap;

  const ChartCard({
    super.key,
    required this.chart,
    required this.onTap,
  });

  @override
  State<ChartCard> createState() => _ChartCardState();
}

class _ChartCardState extends State<ChartCard> {
  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          hovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          hovered = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(
          milliseconds: 180,
        ),
        transform: Matrix4.identity()
          ..translateByDouble(
            0.0,
            hovered ? -4.0 : 0.0,
            0.0,
            1.0,
          ),
        child: Card(
          color: const Color(0xFF121021),
          child: InkWell(
            onTap: widget.onTap,
            borderRadius: BorderRadius.circular(18),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.chart.id,
                          style: const TextStyle(
                            color: Color(0xFFC77DFF),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Chip(
                        label: Text(
                          widget.chart.level ==
                                  ChartLevel.basic
                              ? 'BÁSICA'
                              : 'AVANZADA',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.chart.title,
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: Text(
                      widget.chart.description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${widget.chart.library.name} • ${widget.chart.chartType}',
                    style: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}