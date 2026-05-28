import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/playlist_repository.dart';
import 'playlist_state.dart';

class PlaylistCubit extends Cubit<PlaylistState> {
  PlaylistCubit(this._repository) : super(const PlaylistState()) {
    load();
  }

  final PlaylistRepository _repository;

  Future<void> load() async {
    emit(state.copyWith(isLoading: true));
    await _repository.ensureLikedPlaylist();
    final playlists = await _repository.getPlaylists();
    emit(state.copyWith(playlists: playlists, isLoading: false));
  }

  Future<void> create(String name) async {
    await _repository.create(name);
    await load();
  }

  Future<void> rename(int id, String name) async {
    await _repository.rename(id, name);
    await load();
  }

  Future<void> delete(int id) async {
    await _repository.delete(id);
    await load();
  }

  Future<void> reorderSongs(int playlistId, List<int> songIds) async {
    await _repository.reorderSongs(playlistId, songIds);
    await load();
  }

  /// Returns `true` if added, `false` if the song was already in the playlist.
  Future<bool> addSong(int playlistId, int songId) async {
    final added = await _repository.addSong(playlistId, songId);
    await load();
    return added;
  }

  Future<String> createAndAddSong(String name, int songId) async {
    final playlist = await _repository.createAndAddSong(name, songId);
    await load();
    return playlist.name;
  }

  Future<void> removeSong(int playlistId, int songId) async {
    await _repository.removeSong(playlistId, songId);
    await load();
  }
}
