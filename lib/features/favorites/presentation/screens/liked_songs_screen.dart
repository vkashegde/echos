import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/song_list_tile.dart';
import '../../../player/presentation/cubit/audio_player_cubit.dart';
import '../cubit/favorites_cubit.dart';
import '../cubit/favorites_state.dart';

class LikedSongsScreen extends StatelessWidget {
  const LikedSongsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<FavoritesCubit, FavoritesState>(
          builder: (context, state) {
            final count = state.likedSongs.length;
            return Text(count > 0 ? 'Liked Songs · $count' : 'Liked Songs');
          },
        ),
      ),
      body: BlocBuilder<FavoritesCubit, FavoritesState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CupertinoActivityIndicator(color: AppColors.accent),
            );
          }
          if (state.likedSongs.isEmpty) {
            return const EmptyState(
              icon: CupertinoIcons.heart,
              title: 'No liked songs',
              subtitle: 'Tap the heart on any track to save it here.',
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.only(bottom: 120),
            itemCount: state.likedSongs.length,
            itemBuilder: (context, index) {
              final song = state.likedSongs[index];
              return SongListTile(
                song: song,
                onTap: () => context.read<AudioPlayerCubit>().playSong(
                      song,
                      queue: state.likedSongs,
                    ),
              );
            },
          );
        },
      ),
    );
  }
}
