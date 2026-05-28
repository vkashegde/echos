import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/edge_fade.dart';
import '../../../../core/widgets/media_card.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../library/domain/entities/song_entity.dart';

class HorizontalSongSection extends StatelessWidget {
  const HorizontalSongSection({
    super.key,
    required this.title,
    required this.songs,
    this.onSongTap,
    this.onSeeAll,
  });

  final String title;
  final List<SongEntity> songs;
  final void Function(SongEntity song)? onSongTap;
  final VoidCallback? onSeeAll;

  @override
  Widget build(BuildContext context) {
    if (songs.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: title, onSeeAll: onSeeAll),
        const SizedBox(height: AppSpacing.md),
        SizedBox(
          height: 200,
          child: EdgeFade(
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.horizontalPadding,
              ),
              itemCount: songs.length,
              separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.md),
              itemBuilder: (context, index) {
                final song = songs[index];
                return MediaCard(
                  title: song.displayTitle,
                  subtitle: song.displayArtist,
                  songId: song.id,
                  heroTag: 'song-${song.id}',
                  onTap: () => onSongTap?.call(song),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
