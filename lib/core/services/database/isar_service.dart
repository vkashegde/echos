import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'isar_models.dart';

class IsarService {
  Isar? _isar;

  Future<Isar> get instance async {
    if (_isar != null) return _isar!;
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [
        PlaylistCollectionSchema,
        FavoriteCollectionSchema,
        PlayHistoryCollectionSchema,
        AppSettingsCollectionSchema,
      ],
      directory: dir.path,
      name: 'echos',
    );
    return _isar!;
  }

  Future<void> close() async {
    await _isar?.close();
    _isar = null;
  }
}
