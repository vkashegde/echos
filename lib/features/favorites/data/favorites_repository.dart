import 'package:isar/isar.dart';

import '../../../core/services/database/isar_models.dart';
import '../../../core/services/database/isar_service.dart';

class FavoritesRepository {
  FavoritesRepository(this._isarService);

  final IsarService _isarService;

  Future<Set<int>> getFavoriteIds() async {
    final isar = await _isarService.instance;
    final items = await isar.favoriteCollections.where().findAll();
    return items.map((e) => e.songId).toSet();
  }

  Future<bool> isFavorite(int songId) async {
    final isar = await _isarService.instance;
    final item = await isar.favoriteCollections.getBySongId(songId);
    return item != null;
  }

  Future<void> toggle(int songId) async {
    final isar = await _isarService.instance;
    await isar.writeTxn(() async {
      final existing = await isar.favoriteCollections.getBySongId(songId);
      if (existing != null) {
        await isar.favoriteCollections.delete(existing.id);
      } else {
        await isar.favoriteCollections.put(
          FavoriteCollection()..songId = songId,
        );
      }
    });
  }
}
