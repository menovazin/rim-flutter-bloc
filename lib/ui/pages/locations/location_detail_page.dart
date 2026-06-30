import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pinch_to_zoom_scrollable/pinch_to_zoom_scrollable.dart';

import '../../../domain/entities/location.dart';
import '../../../themes/app_theme.dart';
import '../../../utils/extensions/location_type_x.dart';
import '../../views/avatars/character_avatar_circle.dart';

@RoutePage()
class LocationDetailPage extends StatelessWidget {
  final Location location;

  const LocationDetailPage({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    final designs = context.designs;
    final dim = location.dimension.isEmpty ? 'Unknown' : location.dimension;
    final locType = location.type.isEmpty ? 'Unknown' : location.type;

    return Scaffold(
      backgroundColor: designs.background,
      appBar: AppBar(
        backgroundColor: designs.background,
        iconTheme: IconThemeData(color: designs.textPrimary),
        title: Text(
          location.name,
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
                      designs.secondary.withValues(alpha: 0.15),
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
                    Icon(locType.locationIcon, color: designs.secondary, size: 40),
                    const SizedBox(height: 12),
                    Text(
                      location.name,
                      style: context.textTheme.headlineSmall?.copyWith(
                        color: designs.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _Badge(
                          label: locType,
                          color: designs.secondary,
                          textColor: designs.onSecondary,
                        ),
                        const SizedBox(width: 8),
                        _Badge(
                          label: dim,
                          color: Colors.transparent,
                          textColor: designs.secondary,
                          border: Border.all(
                            color: designs.secondary.withValues(alpha: 0.4),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Резиденты (${location.residentIds.length})',
                style: context.textTheme.titleMedium?.copyWith(
                  color: designs.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              if (location.residentIds.isEmpty)
                Text(
                  'Нет резидентов',
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: designs.textSecondary,
                  ),
                )
              else
                SizedBox(
                  height: 72,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: location.residentIds.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (_, i) => CharacterAvatarCircle(
                      characterId: location.residentIds[i],
                      name: '#${location.residentIds[i]}',
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

class _Badge extends StatelessWidget {
  final String label;
  final Color color;
  final Color textColor;
  final BoxBorder? border;

  const _Badge({
    required this.label,
    required this.color,
    required this.textColor,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        border: border,
      ),
      child: Text(
        label,
        style: context.textTheme.labelMedium?.copyWith(
          color: textColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}