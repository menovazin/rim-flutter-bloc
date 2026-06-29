import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pinch_to_zoom_scrollable/pinch_to_zoom_scrollable.dart';

import '../../../domain/entities/location.dart';
import '../../../themes/app_theme.dart';
import '../../views/detail/detail_widgets.dart';

/// Location detail screen (data passed from the list, no extra requests).
/// Content is wrapped in `pinch_to_zoom_scrollable`.
@RoutePage()
class LocationDetailPage extends StatelessWidget {
  final Location location;

  const LocationDetailPage({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    final designs = context.designs;
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
                  color: designs.surface,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.public_outlined,
                        color: designs.secondary, size: 40),
                    const SizedBox(height: 12),
                    Text(
                      location.name,
                      style: context.textTheme.headlineSmall?.copyWith(
                        color: designs.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              DetailInfoRow(label: 'Тип', value: location.type),
              DetailInfoRow(label: 'Измерение', value: location.dimension),
              const SizedBox(height: 16),
              DetailSectionTitle(
                title: 'Резиденты (${location.residentIds.length})',
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final id in location.residentIds)
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
