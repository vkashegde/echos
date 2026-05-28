import 'package:isar/isar.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/services/database/isar_models.dart';
import '../../../core/services/database/isar_service.dart';

class PlayHistoryRepository {
  PlayHistoryRepository(this._isarService);

  final IsarService _isarService;

  Future<void> recordPlay(int songId) async {
    final isar = await _isarService.instance;
    await isar.writeTxn(() async {
      final existing = await isar.playHistoryCollections.getBySongId(songId);
      if (existing != null) {
        existing.playCount += 1;
        existing.lastPlayedAt = DateTime.now();
        await isar.playHistoryCollections.put(existing);
      } else {
        await isar.playHistoryCollections.put(
          PlayHistoryCollection()
            ..songId = songId
            ..playCount = 1
            ..lastPlayedAt = DateTime.now(),
        );
      }
    });
  }

  Future<List<int>> getRecentlyPlayedIds({
    int limit = AppConstants.recentLimit,
  }) async {
    final isar = await _isarService.instance;
    final items = await isar.playHistoryCollections.where().findAll();
    items.sort((a, b) {
      final aTime = a.lastPlayedAt ?? DateTime.fromMillisecondsSinceEpoch(0);
      final bTime = b.lastPlayedAt ?? DateTime.fromMillisecondsSinceEpoch(0);
      return bTime.compareTo(aTime);
    });
    return items.take(limit).map((e) => e.songId).toList();
  }

  Future<List<int>> getMostPlayedIds({
    int limit = AppConstants.mostPlayedLimit,
  }) async {
    final isar = await _isarService.instance;
    final items = await isar.playHistoryCollections.where().findAll();
    items.sort((a, b) => b.playCount.compareTo(a.playCount));
    return items.take(limit).map((e) => e.songId).toList();
  }
}
