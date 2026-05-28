import 'package:isar/isar.dart';

part 'isar_models.g.dart';

@collection
class PlaylistCollection {
  Id id = Isar.autoIncrement;

  late String name;
  late List<int> songIds;
  DateTime? createdAt;
  bool isSystem = false;
}

@collection
class FavoriteCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late int songId;
}

@collection
class PlayHistoryCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late int songId;

  late int playCount;
  DateTime? lastPlayedAt;
}

@collection
class AppSettingsCollection {
  Id id = 0;

  bool equalizerEnabled = false;
  String equalizerPreset = 'flat';
  List<double> customBandGains = [];
  bool loudnessBoostEnabled = false;
  double loudnessBoostDb = 0;
}
