import '../../../core/services/database/isar_models.dart';
import '../../../core/services/database/isar_service.dart';

class SettingsRepository {
  SettingsRepository(this._isarService);

  final IsarService _isarService;

  Future<AppSettingsCollection> getSettings() async {
    final isar = await _isarService.instance;
    final existing = await isar.appSettingsCollections.get(0);
    if (existing != null) return existing;

    final defaults = AppSettingsCollection();
    await isar.writeTxn(() async {
      await isar.appSettingsCollections.put(defaults);
    });
    return defaults;
  }

  Future<void> saveSettings(AppSettingsCollection settings) async {
    final isar = await _isarService.instance;
    settings.id = 0;
    await isar.writeTxn(() async {
      await isar.appSettingsCollections.put(settings);
    });
  }
}
