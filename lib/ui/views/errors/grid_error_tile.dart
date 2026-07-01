import 'package:flutter/material.dart';

import '../../../l10n/localization_helper.dart';
import '../../../themes/app_theme.dart';

/// Network-error placeholder rendered *inside* the catalog grid (as the last
/// element) instead of replacing the whole screen. Offers a "Retry" action.
class GridErrorTile extends StatelessWidget {
  final VoidCallback onRetry;
  final String? message;

  const GridErrorTile({
    super.key,
    required this.onRetry,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    final designs = context.designs;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: designs.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: designs.error.withValues(alpha: 0.6)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.wifi_off_rounded, color: designs.error, size: 36),
          const SizedBox(height: 12),
          Text(
            message ?? context.strings.errorLoadDataMessage,
            textAlign: TextAlign.center,
            style: context.textTheme.bodyMedium?.copyWith(
              color: designs.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: onRetry,
            style: ElevatedButton.styleFrom(
              backgroundColor: designs.primary,
              foregroundColor: designs.onPrimary,
              // React: button rounded-md (8px).
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),

            icon: const Icon(Icons.refresh_rounded, size: 18),
            label: Text(context.strings.retryButton),
          ),
        ],
      ),
    );
  }
}
