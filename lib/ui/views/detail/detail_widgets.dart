import 'package:flutter/material.dart';

import '../../../themes/app_theme.dart';

/// A label/value row used on detail screens.
class DetailInfoRow extends StatelessWidget {
  final String label;
  final String value;

  const DetailInfoRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final designs = context.designs;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: context.textTheme.bodyMedium?.copyWith(
                color: designs.textSecondary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value.isEmpty ? '—' : value,
              style: context.textTheme.bodyMedium?.copyWith(
                color: designs.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Section header used on detail screens.
class DetailSectionTitle extends StatelessWidget {
  final String title;

  const DetailSectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final designs = context.designs;
    return Text(
      title,
      style: context.textTheme.titleMedium?.copyWith(
        color: designs.primary,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

/// A small chip used to render related entity ids (episodes / residents).
class DetailChip extends StatelessWidget {
  final String label;

  const DetailChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    final designs = context.designs;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: designs.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: designs.secondary.withValues(alpha: 0.4),
        ),
      ),
      child: Text(
        label,
        style: context.textTheme.bodySmall?.copyWith(
          color: designs.textPrimary,
        ),
      ),
    );
  }
}
