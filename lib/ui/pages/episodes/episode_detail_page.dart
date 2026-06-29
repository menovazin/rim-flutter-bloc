import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pinch_to_zoom_scrollable/pinch_to_zoom_scrollable.dart';

import '../../../domain/entities/episode.dart';
import '../../../themes/app_theme.dart';
import '../../views/detail/detail_widgets.dart';

/// Episode detail screen (data passed from the list, no extra requests).
/// Content is wrapped in `pinch_to_zoom_scrollable`.
@RoutePage()
class EpisodeDetailPage extends StatelessWidget {
  final Episode episode;

  const EpisodeDetailPage({super.key, required this.episode});

  @override
  Widget build(BuildContext context) {
    final designs = context.designs;
    return Scaffold(
      backgroundColor: designs.background,
      appBar: AppBar(
        backgroundColor: designs.background,
        iconTheme: IconThemeData(color: designs.textPrimary),
        title: Text(
          episode.name,
          style: context.textTheme.titleLarge?.copyWith(
            color: designs.textPrimary,
          ),
        ),
      ),
      body: PinchToZoomScrollableWidget(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: designs.surface,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.movie_outlined, color: designs.primary, size: 40),
                    const SizedBox(height: 12),
                    Text(
                      episode.name,
                      style: context.textTheme.headlineSmall?.copyWith(
                        color: designs.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              DetailInfoRow(label: 'Код серии', value: episode.episodeCode),
              DetailInfoRow(label: 'Дата выхода', value: episode.airDate),
              const SizedBox(height: 16),
              DetailSectionTitle(
                title: 'Персонажи (${episode.characterIds.length})',
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final id in episode.characterIds)
                    DetailChip(label: '#$id'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
