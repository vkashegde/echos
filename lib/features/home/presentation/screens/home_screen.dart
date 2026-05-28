import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/media_card.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../favorites/presentation/cubit/favorites_cubit.dart';
import '../../../favorites/presentation/cubit/favorites_state.dart';
import '../../../library/domain/entities/album_entity.dart';
import '../../../library/domain/entities/song_entity.dart';
import '../../../library/domain/entities/artist_entity.dart';
import '../../../library/presentation/cubit/library_cubit.dart';
import '../../../library/presentation/cubit/library_state.dart';
import '../../../library/presentation/cubit/recently_played_cubit.dart';
import '../../../library/presentation/cubit/recently_played_state.dart';
import '../../../player/presentation/cubit/audio_player_cubit.dart';
import '../widgets/horizontal_song_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LibraryCubit, LibraryState>(
      builder: (context, library) {
        if (library.status == LibraryStatus.loading) {
          return const Center(
            child: CupertinoActivityIndicator(color: AppColors.accent),
          );
        }
        if (library.status == LibraryStatus.error) {
          return EmptyState(
            icon: CupertinoIcons.exclamationmark_circle,
            title: 'Could not load library',
            subtitle: library.errorMessage,
            action: TextButton(
              onPressed: () => context.read<LibraryCubit>().scan(),
              child: const Text('Try again'),
            ),
          );
        }
        if (library.songs.isEmpty) {
          return EmptyState(
            icon: CupertinoIcons.music_note_2,
            title: 'No music found',
            subtitle: 'Pull down to scan your device for audio files.',
            action: TextButton(
              onPressed: () => context.read<LibraryCubit>().scan(),
              child: const Text('Scan library'),
            ),
          );
        }

        return RefreshIndicator(
          color: AppColors.accent,
          backgroundColor: AppColors.surface,
          onRefresh: () => context.read<LibraryCubit>().scan(),
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppConstants.horizontalPadding,
                    AppSpacing.lg,
                    AppConstants.horizontalPadding,
                    AppSpacing.md,
                  ),
                  child: Text(
                    'Listen',
                    style: Theme.of(context).textTheme.displayLarge,
                  ).animate().fadeIn().slideY(begin: 0.1, end: 0),
                ),
              ),
              SliverToBoxAdapter(
                child: BlocBuilder<RecentlyPlayedCubit, RecentlyPlayedState>(
                  builder: (context, recent) {
                    return HorizontalSongSection(
                      title: 'Recently played',
                      songs: recent.recent,
                      onSongTap: (song) => _play(context, song, recent.recent),
                    );
                  },
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: AppConstants.sectionSpacing)),
              SliverToBoxAdapter(
                child: BlocBuilder<RecentlyPlayedCubit, RecentlyPlayedState>(
                  builder: (context, recent) {
                    return HorizontalSongSection(
                      title: 'Most played',
                      songs: recent.mostPlayed,
                      onSongTap: (song) => _play(context, song, recent.mostPlayed),
                    );
                  },
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: AppConstants.sectionSpacing)),
              SliverToBoxAdapter(child: _AlbumsSection(albums: library.albums)),
              const SliverToBoxAdapter(child: SizedBox(height: AppConstants.sectionSpacing)),
              SliverToBoxAdapter(child: _ArtistsSection(artists: library.artists)),
              const SliverToBoxAdapter(child: SizedBox(height: AppConstants.sectionSpacing)),
              SliverToBoxAdapter(
                child: BlocBuilder<FavoritesCubit, FavoritesState>(
                  builder: (context, fav) {
                    if (fav.likedSongs.isEmpty) return const SizedBox.shrink();
                    return HorizontalSongSection(
                      title: 'Favorites',
                      songs: fav.likedSongs.take(12).toList(),
                      onSeeAll: () => context.push('/liked'),
                      onSongTap: (song) => _play(context, song, fav.likedSongs),
                    );
                  },
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 120)),
            ],
          ),
        );
      },
    );
  }

  void _play(BuildContext context, SongEntity song, List<SongEntity> queue) {
    context.read<AudioPlayerCubit>().playSong(song, queue: queue);
    context.read<RecentlyPlayedCubit>().onSongPlayed(song.id);
  }
}

class _AlbumsSection extends StatelessWidget {
  const _AlbumsSection({required this.albums});

  final List<AlbumEntity> albums;

  @override
  Widget build(BuildContext context) {
    if (albums.isEmpty) return const SizedBox.shrink();
    final display = albums.take(12).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'Albums'),
        const SizedBox(height: AppSpacing.md),
        SizedBox(
          height: 200,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.horizontalPadding,
            ),
            itemCount: display.length,
            separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.md),
            itemBuilder: (context, index) {
              final album = display[index];
              final library = context.read<LibraryCubit>().state;
              final firstSong = library.songs
                  .where((s) => s.albumId == album.id)
                  .cast<dynamic>()
                  .firstOrNull;
              final songId = firstSong?.id ?? library.songs.first.id;
              return MediaCard(
                title: album.name,
                subtitle: album.artist,
                songId: songId,
                onTap: () => context.push('/album/${album.id}'),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ArtistsSection extends StatelessWidget {
  const _ArtistsSection({required this.artists});

  final List<ArtistEntity> artists;

  @override
  Widget build(BuildContext context) {
    if (artists.isEmpty) return const SizedBox.shrink();
    final display = artists.take(12).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'Artists'),
        const SizedBox(height: AppSpacing.md),
        SizedBox(
          height: 120,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.horizontalPadding,
            ),
            itemCount: display.length,
            separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
            itemBuilder: (context, index) {
              final artist = display[index];
              return GestureDetector(
                onTap: () => context.push('/artist/${artist.id}'),
                child: Column(
                  children: [
                    Container(
                      width: 88,
                      height: 88,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.surfaceElevated,
                        border: Border.all(
                          color: AppColors.border.withValues(alpha: 0.5),
                        ),
                      ),
                      child: const Icon(
                        CupertinoIcons.person_fill,
                        color: AppColors.textTertiary,
                        size: 36,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    SizedBox(
                      width: 96,
                      child: Text(
                        artist.name,
                        style: Theme.of(context).textTheme.bodyMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

extension _FirstOrNull<E> on Iterable<E> {
  E? get firstOrNull {
    final iterator = this.iterator;
    if (!iterator.moveNext()) return null;
    return iterator.current;
  }
}
