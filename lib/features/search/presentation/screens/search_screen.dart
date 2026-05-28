import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/song_list_tile.dart';
import '../../../library/domain/entities/album_entity.dart';
import '../../../library/domain/entities/artist_entity.dart';
import '../../../library/domain/entities/song_entity.dart';
import '../../../player/presentation/cubit/audio_player_cubit.dart';
import '../cubit/search_cubit.dart';
import '../cubit/search_state.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();
  final _focus = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppConstants.horizontalPadding,
                  AppSpacing.lg,
                  AppConstants.horizontalPadding,
                  AppSpacing.md,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Search',
                      style: Theme.of(context).textTheme.displayMedium,
                    ).animate().fadeIn().slideY(begin: 0.08, end: 0),
                    const SizedBox(height: AppSpacing.lg),
                    _SearchField(
                      controller: _controller,
                      focusNode: _focus,
                      onChanged: context.read<SearchCubit>().search,
                      onClear: () {
                        _controller.clear();
                        context.read<SearchCubit>().clear();
                      },
                    ),
                  ],
                ),
              ),
            ),
            if (state.isSearching)
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(AppSpacing.xl),
                  child: Center(
                    child: CupertinoActivityIndicator(color: AppColors.accent),
                  ),
                ),
              )
            else if (state.query.isNotEmpty && !state.hasResults)
              SliverFillRemaining(
                child: EmptyState(
                  icon: CupertinoIcons.search,
                  title: 'No results',
                  subtitle: 'Try a different song, album, or artist.',
                ),
              )
            else ...[
              if (state.songs.isNotEmpty)
                _ResultSection<SongEntity>(
                  title: 'Songs',
                  items: state.songs,
                  builder: (song) => SongListTile(
                    song: song,
                    onTap: () {
                      context.read<AudioPlayerCubit>().playSong(
                            song,
                            queue: state.songs,
                          );
                    },
                  ),
                ),
              if (state.albums.isNotEmpty)
                _ResultSection<AlbumEntity>(
                  title: 'Albums',
                  items: state.albums,
                  builder: (album) => ListTile(
                    title: Text(album.name),
                    subtitle: Text(album.artist),
                    trailing: Text('${album.songCount} tracks'),
                  ),
                ),
              if (state.artists.isNotEmpty)
                _ResultSection<ArtistEntity>(
                  title: 'Artists',
                  items: state.artists,
                  builder: (artist) => ListTile(
                    title: Text(artist.name),
                    subtitle: Text('${artist.songCount} songs'),
                  ),
                ),
            ],
            const SliverToBoxAdapter(child: SizedBox(height: 120)),
          ],
        );
      },
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    required this.onClear,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceElevated,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.45)),
      ),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        onChanged: onChanged,
        style: Theme.of(context).textTheme.bodyLarge,
        decoration: InputDecoration(
          hintText: 'Songs, albums, artists…',
          hintStyle: Theme.of(context).textTheme.bodyMedium,
          prefixIcon: const Icon(
            CupertinoIcons.search,
            color: AppColors.textTertiary,
          ),
          suffixIcon: IconButton(
            onPressed: onClear,
            icon: const Icon(
              CupertinoIcons.xmark_circle_fill,
              color: AppColors.textTertiary,
            ),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    ).animate().fadeIn(delay: 60.ms);
  }
}

class _ResultSection<T> extends StatelessWidget {
  const _ResultSection({
    required this.title,
    required this.items,
    required this.builder,
  });

  final String title;
  final List<T> items;
  final Widget Function(T item) builder;

  @override
  Widget build(BuildContext context) {
    return SliverMainAxisGroup(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppConstants.horizontalPadding,
              AppSpacing.lg,
              AppConstants.horizontalPadding,
              AppSpacing.sm,
            ),
            child: Text(title, style: Theme.of(context).textTheme.titleLarge),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => builder(items[index]),
            childCount: items.length,
          ),
        ),
      ],
    );
  }
}
