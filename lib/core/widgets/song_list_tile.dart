import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/favorites/presentation/cubit/favorites_cubit.dart';
import '../../features/favorites/presentation/cubit/favorites_state.dart';
import '../../features/library/domain/entities/song_entity.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../utils/duration_format.dart';
import 'album_artwork.dart';

class SongListTile extends StatelessWidget {
  const SongListTile({
    super.key,
    required this.song,
    this.onTap,
    this.trailing,
    this.showFavorite = true,
  });

  final SongEntity song;
  final VoidCallback? onTap;
  final Widget? trailing;
  final bool showFavorite;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.sm,
          ),
          child: Row(
            children: [
              AlbumArtwork(songId: song.id, size: 52),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      song.displayTitle,
                      style: theme.textTheme.titleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      song.displayArtist,
                      style: theme.textTheme.bodyMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Text(
                formatDurationMs(song.durationMs),
                style: theme.textTheme.labelMedium,
              ),
              if (showFavorite) ...[
                const SizedBox(width: AppSpacing.sm),
                BlocBuilder<FavoritesCubit, FavoritesState>(
                  buildWhen: (prev, curr) =>
                      prev.favoriteIds != curr.favoriteIds,
                  builder: (context, state) {
                    final isFav = state.isFavorite(song.id);
                    return GestureDetector(
                      onTap: () =>
                          context.read<FavoritesCubit>().toggle(song.id),
                      child: Icon(
                        isFav
                            ? CupertinoIcons.heart_fill
                            : CupertinoIcons.heart,
                        size: 20,
                        color: isFav ? AppColors.accent : AppColors.textTertiary,
                      ),
                    );
                  },
                ),
              ],
              if (trailing != null) trailing!,
            ],
          ),
        ),
      ),
    );
  }
}
