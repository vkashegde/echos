import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/duration_format.dart';
import '../../../../core/widgets/album_artwork.dart';
import '../../../../core/widgets/premium_seek_bar.dart';
import '../../../../core/widgets/waveform_visualizer.dart';
import '../../../../core/services/audio/echos_audio_handler.dart';
import '../../../favorites/presentation/cubit/favorites_cubit.dart';
import '../../../favorites/presentation/cubit/favorites_state.dart';
import '../../../library/domain/entities/song_entity.dart';
import '../../../playlists/presentation/widgets/add_to_playlist_sheet.dart';
import '../cubit/audio_player_cubit.dart';
import '../cubit/audio_player_state.dart';
import '../cubit/theme_cubit.dart';
import '../cubit/theme_state.dart';

class NowPlayingScreen extends StatefulWidget {
  const NowPlayingScreen({super.key});

  @override
  State<NowPlayingScreen> createState() => _NowPlayingScreenState();
}

class _NowPlayingScreenState extends State<NowPlayingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _rotationController;
  bool _isDragging = false;
  double _dragProgress = 0;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 24),
    );
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioPlayerCubit, AudioPlayerState>(
      builder: (context, player) {
        final song = player.currentSong;
        if (song == null) {
          return Scaffold(
            backgroundColor: AppColors.scaffold,
            appBar: AppBar(
              leading: IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(CupertinoIcons.chevron_down),
              ),
            ),
            body: const Center(
              child: CupertinoActivityIndicator(color: AppColors.accent),
            ),
          );
        }

        if (player.isPlaying) {
          _rotationController.repeat();
        } else {
          _rotationController.stop();
        }

        context.read<ThemeCubit>().extractFromSong(song.id);

        return BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, theme) {
            return Scaffold(
              backgroundColor: theme.background,
              body: Stack(
                fit: StackFit.expand,
                children: [
                  _DynamicBackground(theme: theme),
                  SafeArea(
                    child: Column(
                      children: [
                        _TopBar(
                          onClose: () => context.pop(),
                          song: song,
                        ),
                        const Spacer(),
                        _ArtworkSection(
                          songId: song.id,
                          rotation: _rotationController,
                          isPlaying: player.isPlaying,
                        ),
                        const SizedBox(height: AppSpacing.xl),
                        WaveformVisualizer(
                          isPlaying: player.isPlaying,
                          color: theme.primary,
                          height: 40,
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 28),
                          child: Column(
                            children: [
                              Text(
                                song.displayTitle,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineLarge,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 6),
                              Text(
                                song.displayArtist,
                                style: Theme.of(context).textTheme.bodyLarge
                                    ?.copyWith(color: AppColors.textSecondary),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xl),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            children: [
                              PremiumSeekBar(
                                progress: _isDragging
                                    ? _dragProgress
                                    : player.progress,
                                activeColor: theme.primary,
                                onChanged: (v) => setState(() {
                                  _isDragging = true;
                                  _dragProgress = v;
                                }),
                                onChangeEnd: (v) {
                                  final duration = player.duration;
                                  context.read<AudioPlayerCubit>().seek(
                                        Duration(
                                          milliseconds:
                                              (duration.inMilliseconds * v)
                                                  .round(),
                                        ),
                                      );
                                  setState(() => _isDragging = false);
                                },
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    formatDuration(
                                      _isDragging
                                          ? Duration(
                                              milliseconds: (player
                                                          .duration
                                                          .inMilliseconds *
                                                      _dragProgress)
                                                  .round(),
                                            )
                                          : player.position,
                                    ),
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                  Text(
                                    formatDuration(player.duration),
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        _Controls(
                          theme: theme,
                          player: player,
                          songId: song.id,
                        ),
                        const Spacer(flex: 2),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class _DynamicBackground extends StatelessWidget {
  const _DynamicBackground({required this.theme});

  final ThemeState theme;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 480),
      curve: Curves.easeOutCubic,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.lerp(theme.primary, theme.background, 0.35)!,
            theme.background,
            Colors.black,
          ],
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
        child: Container(color: Colors.black.withValues(alpha: 0.35)),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({
    required this.onClose,
    required this.song,
  });

  final VoidCallback onClose;
  final SongEntity song;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: [
          IconButton(
            onPressed: onClose,
            icon: const Icon(CupertinoIcons.chevron_down, size: 28),
          ),
          const Spacer(),
          IconButton(
            onPressed: () => AddToPlaylistSheet.show(
              context,
              songId: song.id,
              songTitle: song.displayTitle,
            ),
            icon: const Icon(CupertinoIcons.text_badge_plus, size: 24),
            tooltip: 'Add to playlist',
          ),
          const SizedBox(width: 4),
        ],
      ),
    );
  }
}

class _ArtworkSection extends StatelessWidget {
  const _ArtworkSection({
    required this.songId,
    required this.rotation,
    required this.isPlaying,
  });

  final int songId;
  final AnimationController rotation;
  final bool isPlaying;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context).width * 0.72;
    return AnimatedBuilder(
      animation: rotation,
      builder: (context, child) {
        return Transform.rotate(
          angle: isPlaying ? rotation.value * 2 * pi : 0,
          child: child,
        );
      },
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.5),
              blurRadius: 48,
              offset: const Offset(0, 24),
            ),
          ],
        ),
        child: AlbumArtwork(
          songId: songId,
          size: size,
          borderRadius: BorderRadius.circular(12),
          heroTag: 'now-playing-art',
        ),
      ),
    ).animate().scale(
          begin: const Offset(0.94, 0.94),
          end: const Offset(1, 1),
          duration: 400.ms,
          curve: Curves.easeOutCubic,
        );
  }
}

class _Controls extends StatelessWidget {
  const _Controls({
    required this.theme,
    required this.player,
    required this.songId,
  });

  final ThemeState theme;
  final AudioPlayerState player;
  final int songId;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AudioPlayerCubit>();
    return ClipRRect(
      borderRadius: BorderRadius.circular(999),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.surfaceGlass.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: AppColors.border.withValues(alpha: 0.3)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _ShuffleButton(enabled: player.shuffleEnabled, onTap: cubit.toggleShuffle),
              IconButton(
                iconSize: 36,
                onPressed: cubit.previous,
                icon: const Icon(CupertinoIcons.backward_fill),
              ),
              GestureDetector(
                onTap: cubit.togglePlayPause,
                child: Container(
                  width: 68,
                  height: 68,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: theme.primary,
                    boxShadow: [
                      BoxShadow(
                        color: theme.primary.withValues(alpha: 0.35),
                        blurRadius: 20,
                      ),
                    ],
                  ),
                  child: Icon(
                    player.isPlaying
                        ? CupertinoIcons.pause_fill
                        : CupertinoIcons.play_fill,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              ),
              IconButton(
                iconSize: 36,
                onPressed: cubit.next,
                icon: const Icon(CupertinoIcons.forward_fill),
              ),
              _RepeatButton(mode: player.repeatMode, onTap: cubit.cycleRepeat),
              BlocBuilder<FavoritesCubit, FavoritesState>(
                builder: (context, fav) {
                  final isFav = fav.isFavorite(songId);
                  return IconButton(
                    onPressed: () => context.read<FavoritesCubit>().toggle(songId),
                    icon: Icon(
                      isFav
                          ? CupertinoIcons.heart_fill
                          : CupertinoIcons.heart,
                      color: isFav ? theme.primary : AppColors.textSecondary,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ShuffleButton extends StatelessWidget {
  const _ShuffleButton({required this.enabled, required this.onTap});

  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(
        CupertinoIcons.shuffle,
        color: enabled ? AppColors.accent : AppColors.textTertiary,
        size: 22,
      ),
    );
  }
}

class _RepeatButton extends StatelessWidget {
  const _RepeatButton({required this.mode, required this.onTap});

  final RepeatMode mode;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(
        mode == RepeatMode.one
            ? CupertinoIcons.repeat_1
            : CupertinoIcons.repeat,
        color: mode != RepeatMode.off
            ? AppColors.accent
            : AppColors.textTertiary,
        size: 22,
      ),
    );
  }
}
