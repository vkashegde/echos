import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/album_artwork.dart';
import '../cubit/audio_player_cubit.dart';
import '../cubit/audio_player_state.dart';
import '../cubit/theme_cubit.dart';
import '../cubit/theme_state.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AudioPlayerCubit, AudioPlayerState, bool>(
      selector: (s) => s.hasTrack,
      builder: (context, hasTrack) {
        if (!hasTrack) return const SizedBox.shrink();

        return BlocBuilder<AudioPlayerCubit, AudioPlayerState>(
          builder: (context, player) {
            final song = player.currentSong!;
            context.read<ThemeCubit>().extractFromSong(song.id);

            return Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
              child: GestureDetector(
                onTap: () => context.push('/player'),
                onVerticalDragEnd: (details) {
                  if (details.primaryVelocity != null &&
                      details.primaryVelocity! < -200) {
                    context.push('/player');
                  }
                },
                child: BlocBuilder<ThemeCubit, ThemeState>(
                  builder: (context, theme) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 28, sigmaY: 28),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                theme.surface.withValues(alpha: 0.92),
                                AppColors.surfaceElevated.withValues(alpha: 0.88),
                              ],
                            ),
                            borderRadius:
                                BorderRadius.circular(AppSpacing.radiusLg),
                            border: Border.all(
                              color: theme.primary.withValues(alpha: 0.25),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: theme.primary.withValues(alpha: 0.12),
                                blurRadius: 24,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height: AppConstants.miniPlayerHeight,
                                child: Row(
                                  children: [
                                    const SizedBox(width: AppSpacing.sm),
                                    AlbumArtwork(
                                      songId: song.id,
                                      size: 48,
                                      borderRadius: BorderRadius.circular(8),
                                      heroTag: 'now-playing-art',
                                    ),
                                    const SizedBox(width: AppSpacing.md),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            song.displayTitle,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            song.displayArtist,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () => context
                                          .read<AudioPlayerCubit>()
                                          .togglePlayPause(),
                                      icon: Icon(
                                        player.isPlaying
                                            ? CupertinoIcons.pause_fill
                                            : CupertinoIcons.play_fill,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                  ],
                                ),
                              ),
                              LinearProgressIndicator(
                                value: player.progress.clamp(0.0, 1.0),
                                minHeight: 2,
                                backgroundColor: AppColors.border,
                                color: theme.primary,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ).animate().fadeIn(duration: 280.ms).slideY(
                          begin: 0.2,
                          end: 0,
                          curve: Curves.easeOutCubic,
                        );
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
