import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../themes/app_theme.dart';
import '../../../utils/avatar_url_utils.dart';

/// Circular character avatar (48×48) with optional name label below.
class CharacterAvatarCircle extends StatelessWidget {
  final int characterId;
  final String? name;

  const CharacterAvatarCircle({super.key, required this.characterId, this.name});

  @override
  Widget build(BuildContext context) {
    final designs = context.designs;
    final url = AvatarUrlUtils.avatarUrlFromId(characterId);

    final avatar = ClipOval(
      child: SizedBox(
        width: 48,
        height: 48,
        child: CachedNetworkImage(
          imageUrl: url,
          fit: BoxFit.cover,
          placeholder: (_, __) => ColoredBox(color: designs.surface),
          errorWidget: (_, __, ___) => ColoredBox(
            color: designs.surface,
            child: Icon(Icons.person, size: 24, color: designs.textSecondary),
          ),
        ),
      ),
    );

    if (name == null || name!.isEmpty) return avatar;

    return SizedBox(
      width: 64,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          avatar,
          const SizedBox(height: 4),
          Text(
            name!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: context.textTheme.bodySmall?.copyWith(
              color: designs.textSecondary,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
