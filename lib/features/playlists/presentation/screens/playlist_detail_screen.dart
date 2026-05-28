import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/song_list_tile.dart';
import '../../../library/presentation/cubit/library_cubit.dart';
import '../../../library/presentation/cubit/library_state.dart';
import '../../../player/presentation/cubit/audio_player_cubit.dart';
import '../../domain/entities/playlist_entity.dart';
import '../cubit/playlist_cubit.dart';
import '../cubit/playlist_state.dart';

class PlaylistDetailScreen extends StatelessWidget {
  const PlaylistDetailScreen({super.key, required this.playlistId});

  final int playlistId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlaylistCubit, PlaylistState>(
      builder: (context, playlistState) {
        PlaylistEntity? playlist;
        for (final p in playlistState.playlists) {
          if (p.id == playlistId) {
            playlist = p;
            break;
          }
        }

        if (playlist == null) {
          return const Scaffold(
            body: Center(child: CupertinoActivityIndicator()),
          );
        }

        final currentPlaylist = playlist;

        return BlocBuilder<LibraryCubit, LibraryState>(
          builder: (context, library) {
            final songs = library.songsByIds(currentPlaylist.songIds);

            return Scaffold(
              appBar: AppBar(
                title: Text(currentPlaylist.name),
                actions: [
                  if (!currentPlaylist.isSystem)
                    PopupMenuButton<String>(
                      onSelected: (value) async {
                        if (value == 'rename') {
                          await _rename(context, currentPlaylist);
                        } else if (value == 'delete') {
                          await context
                              .read<PlaylistCubit>()
                              .delete(currentPlaylist.id);
                          if (context.mounted) Navigator.pop(context);
                        }
                      },
                      itemBuilder: (_) => const [
                        PopupMenuItem(value: 'rename', child: Text('Rename')),
                        PopupMenuItem(value: 'delete', child: Text('Delete')),
                      ],
                    ),
                ],
              ),
              body: songs.isEmpty
                  ? const EmptyState(
                      icon: CupertinoIcons.music_note,
                      title: 'Playlist is empty',
                      subtitle: 'Add songs from your library.',
                    )
                  : ReorderableListView.builder(
                      padding: const EdgeInsets.only(bottom: 120),
                      itemCount: songs.length,
                      onReorder: (oldIndex, newIndex) async {
                        if (newIndex > oldIndex) newIndex--;
                        final ids = List<int>.from(currentPlaylist.songIds);
                        final id = ids.removeAt(oldIndex);
                        ids.insert(newIndex, id);
                        await context
                            .read<PlaylistCubit>()
                            .reorderSongs(currentPlaylist.id, ids);
                      },
                      itemBuilder: (context, index) {
                        final song = songs[index];
                        return SongListTile(
                          key: ValueKey(song.id),
                          song: song,
                          onTap: () => context
                              .read<AudioPlayerCubit>()
                              .playSong(song, queue: songs),
                        );
                      },
                    ),
            );
          },
        );
      },
    );
  }

  Future<void> _rename(BuildContext context, PlaylistEntity playlist) async {
    final controller = TextEditingController(text: playlist.name);
    final name = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Rename playlist'),
        content: TextField(controller: controller, autofocus: true),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          TextButton(
            onPressed: () => Navigator.pop(ctx, controller.text.trim()),
            child: const Text('Save'),
          ),
        ],
      ),
    );
    if (name != null && name.isNotEmpty && context.mounted) {
      await context.read<PlaylistCubit>().rename(playlist.id, name);
    }
  }
}
