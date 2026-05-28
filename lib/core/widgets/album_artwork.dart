import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

class AlbumArtwork extends StatelessWidget {
  const AlbumArtwork({
    super.key,
    required this.songId,
    this.size = 120,
    this.borderRadius,
    this.heroTag,
  });

  final int songId;
  final double size;
  final BorderRadius? borderRadius;
  final String? heroTag;

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? BorderRadius.circular(AppSpacing.radiusMd);
    final artwork = QueryArtworkWidget(
      id: songId,
      type: ArtworkType.AUDIO,
      artworkBorder: BorderRadius.zero,
      artworkHeight: size * 2,
      artworkWidth: size * 2,
      nullArtworkWidget: _placeholder(radius),
      errorBuilder: (_, __, ___) => _placeholder(radius),
    );

    final child = ClipRRect(
      borderRadius: radius,
      child: SizedBox(width: size, height: size, child: artwork),
    );

    if (heroTag != null) {
      return Hero(tag: heroTag!, child: child);
    }
    return child;
  }

  Widget _placeholder(BorderRadius radius) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: radius,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.surfaceElevated,
            AppColors.surface.withValues(alpha: 0.8),
          ],
        ),
      ),
      child: Icon(
        Icons.music_note_rounded,
        color: AppColors.textTertiary,
        size: size * 0.32,
      ),
    );
  }
}
