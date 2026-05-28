import 'package:isar/isar.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/services/database/isar_models.dart';
import '../../../core/services/database/isar_service.dart';
import '../domain/entities/playlist_entity.dart';

class PlaylistRepository {
  PlaylistRepository(this._isarService);

  final IsarService _isarService;

  Future<List<PlaylistEntity>> getPlaylists() async {
    final isar = await _isarService.instance;
    final items = await isar.playlistCollections.where().findAll();
    return items.map(_map).toList();
  }

  Future<PlaylistEntity?> getById(int id) async {
    final isar = await _isarService.instance;
    final item = await isar.playlistCollections.get(id);
    return item == null ? null : _map(item);
  }

  Future<PlaylistEntity> create(String name) async {
    final isar = await _isarService.instance;
    final collection = PlaylistCollection()
      ..name = name
      ..songIds = []
      ..createdAt = DateTime.now();
    await isar.writeTxn(() async {
      await isar.playlistCollections.put(collection);
    });
    return _map(collection);
  }

  Future<void> rename(int id, String name) async {
    final isar = await _isarService.instance;
    await isar.writeTxn(() async {
      final item = await isar.playlistCollections.get(id);
      if (item == null) return;
      item.name = name;
      await isar.playlistCollections.put(item);
    });
  }

  Future<void> delete(int id) async {
    final isar = await _isarService.instance;
    await isar.writeTxn(() async {
      await isar.playlistCollections.delete(id);
    });
  }

  Future<void> reorderSongs(int playlistId, List<int> songIds) async {
    final isar = await _isarService.instance;
    await isar.writeTxn(() async {
      final item = await isar.playlistCollections.get(playlistId);
      if (item == null) return;
      item.songIds = songIds;
      await isar.playlistCollections.put(item);
    });
  }

  /// Returns `true` if the song was added, `false` if already in the playlist.
  Future<bool> addSong(int playlistId, int songId) async {
    final isar = await _isarService.instance;
    var added = false;
    await isar.writeTxn(() async {
      final item = await isar.playlistCollections.get(playlistId);
      if (item == null || item.songIds.contains(songId)) return;
      item.songIds = [...item.songIds, songId];
      await isar.playlistCollections.put(item);
      added = true;
    });
    return added;
  }

  Future<PlaylistEntity> createAndAddSong(String name, int songId) async {
    final playlist = await create(name);
    await addSong(playlist.id, songId);
    return playlist;
  }

  Future<void> removeSong(int playlistId, int songId) async {
    final isar = await _isarService.instance;
    await isar.writeTxn(() async {
      final item = await isar.playlistCollections.get(playlistId);
      if (item == null) return;
      item.songIds = item.songIds.where((id) => id != songId).toList();
      await isar.playlistCollections.put(item);
    });
  }

  Future<void> ensureLikedPlaylist() async {
    final isar = await _isarService.instance;
    final existing = await isar.playlistCollections
        .filter()
        .isSystemEqualTo(true)
        .nameEqualTo(AppConstants.likedPlaylistName)
        .findFirst();
    if (existing != null) return;
    final collection = PlaylistCollection()
      ..name = AppConstants.likedPlaylistName
      ..songIds = []
      ..isSystem = true
      ..createdAt = DateTime.now();
    await isar.writeTxn(() async {
      await isar.playlistCollections.put(collection);
    });
  }

  PlaylistEntity _map(PlaylistCollection collection) {
    return PlaylistEntity(
      id: collection.id,
      name: collection.name,
      songIds: List<int>.from(collection.songIds),
      createdAt: collection.createdAt,
      isSystem: collection.isSystem,
    );
  }
}
