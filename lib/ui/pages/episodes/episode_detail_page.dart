import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pinch_to_zoom_scrollable/pinch_to_zoom_scrollable.dart';

import '../../../domain/entities/episode.dart';
import '../../../l10n/localization_helper.dart';
import '../../../themes/app_theme.dart';
import '../../../utils/extensions/episode_code_x.dart';
import '../../views/avatars/character_avatar_circle.dart';

@RoutePage()
class EpisodeDetailPage extends StatelessWidget {
  final Episode episode;

  const EpisodeDetailPage({super.key, required this.episode});

  @override
  Widget build(BuildContext context) {
    final designs = context.designs;
    final s = episode.episodeCode.season;
    final e = episode.episodeCode.episodeNumber;

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
                  gradient: LinearGradient(
                    colors: [
                      designs.primary.withValues(alpha: 0.15),
                      designs.surface,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: designs.primary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'S${s.toString().padLeft(2, '0')}',
                            style: context.textTheme.labelLarge?.copyWith(
                              color: designs.onPrimary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: designs.primary.withValues(alpha: 0.4),
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'E${e.toString().padLeft(2, '0')}',
                            style: context.textTheme.labelLarge?.copyWith(
                              color: designs.primary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      episode.name,
                      style: context.textTheme.headlineSmall?.copyWith(
                        color: designs.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      episode.airDate,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: designs.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Text(
                context.strings.sectionCharactersCount(episode.characterIds.length),
                style: context.textTheme.titleMedium?.copyWith(
                  color: designs.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 72,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: episode.characterIds.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (_, i) => CharacterAvatarCircle(
                    characterId: episode.characterIds[i],
                    name: '#${episode.characterIds[i]}',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}