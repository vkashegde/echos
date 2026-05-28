import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/album_artwork.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/song_list_tile.dart';
import '../../../player/presentation/cubit/audio_player_cubit.dart';
import '../../domain/entities/album_entity.dart';
import '../cubit/library_cubit.dart';
import '../cubit/library_state.dart';

class AlbumDetailScreen extends StatelessWidget {
  const AlbumDetailScreen({super.key, required this.albumId});

  final int albumId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LibraryCubit, LibraryState>(
      builder: (context, library) {
        AlbumEntity? album;
        for (final a in library.albums) {
          if (a.id == albumId) {
            album = a;
            break;
          }
        }
        final songs = library.songs.where((s) => s.albumId == albumId).toList();

        if (album == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final coverId = songs.isNotEmpty ? songs.first.id : 0;

        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 280,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(album.name),
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      if (coverId > 0)
                        AlbumArtwork(
                          songId: coverId,
                          size: 400,
                          borderRadius: BorderRadius.zero,
                        ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Theme.of(context).scaffoldBackgroundColor,
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (songs.isEmpty)
                const SliverFillRemaining(
                  child: EmptyState(
                    icon: Icons.album_outlined,
                    title: 'No tracks',
                  ),
                )
              else
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final song = songs[index];
                      return SongListTile(
                        song: song,
                        onTap: () => context
                            .read<AudioPlayerCubit>()
                            .playSong(song, queue: songs),
                      );
                    },
                    childCount: songs.length,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
