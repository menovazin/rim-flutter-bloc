import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pinch_to_zoom_scrollable/pinch_to_zoom_scrollable.dart';

import '../../../domain/entities/character.dart';
import '../../../themes/app_theme.dart';
import '../../../utils/extensions/character_status_x.dart';
import '../../views/detail/detail_widgets.dart';

/// Character detail screen.
///
/// Data is passed in from the list (no extra network requests). The whole
/// content is wrapped in `pinch_to_zoom_scrollable` for pinch-to-zoom.
@RoutePage()
class CharacterDetailPage extends StatelessWidget {
  final Character character;

  const CharacterDetailPage({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    final designs = context.designs;
    return Scaffold(
      backgroundColor: designs.background,
      appBar: AppBar(
        backgroundColor: designs.background,
        iconTheme: IconThemeData(color: designs.textPrimary),
        title: Text(
          character.name,
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
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: CachedNetworkImage(
                    imageUrl: character.image,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => ColoredBox(
                      color: designs.surface,
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                    errorWidget: (context, url, error) => ColoredBox(
                      color: designs.surface,
                      child: Icon(
                        Icons.broken_image,
                        color: designs.textSecondary,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: character.statusColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${character.status} • ${character.species}',
                    style: context.textTheme.titleMedium?.copyWith(
                      color: designs.textPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              DetailInfoRow(label: 'Вид', value: character.species),
              if (character.type.isNotEmpty)
                DetailInfoRow(label: 'Тип', value: character.type),
              DetailInfoRow(label: 'Пол', value: character.gender),
              DetailInfoRow(label: 'Происхождение', value: character.originName),
              DetailInfoRow(label: 'Локация', value: character.locationName),
              const SizedBox(height: 16),
              DetailSectionTitle(
                title: 'Эпизоды (${character.episodeIds.length})',
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final id in character.episodeIds)
                    DetailChip(label: 'EP $id'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
