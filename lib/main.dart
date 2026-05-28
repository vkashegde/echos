import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app.dart';
import 'core/services/audio/audio_service_locator.dart';
import 'core/services/audio/equalizer_service.dart';
import 'core/services/database/isar_service.dart';
import 'features/settings/data/settings_repository.dart';
import 'features/settings/presentation/cubit/equalizer_cubit.dart';
import 'core/utils/permission_helper.dart';
import 'features/favorites/data/favorites_repository.dart';
import 'features/library/data/library_repository.dart';
import 'features/library/data/play_history_repository.dart';
import 'features/library/presentation/cubit/library_cubit.dart';
import 'features/player/presentation/cubit/audio_player_cubit.dart';
import 'features/playlists/data/playlist_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  final isarService = IsarService();
  await isarService.instance;

  await AudioServiceLocator.init();

  final settingsRepository = SettingsRepository(isarService);
  final equalizerService = EqualizerService(settingsRepository);
  await equalizerService.loadAndApply();

  final libraryRepository = LibraryRepository();
  final playlistRepository = PlaylistRepository(isarService);
  final favoritesRepository = FavoritesRepository(isarService);
  final playHistoryRepository = PlayHistoryRepository(isarService);
  final permissionHelper = PermissionHelper();

  final libraryCubit = LibraryCubit(libraryRepository, permissionHelper);
  final audioPlayerCubit = AudioPlayerCubit(playHistoryRepository);
  final equalizerCubit = EqualizerCubit(equalizerService);

  await libraryCubit.scan();

  runApp(
    EchosApp(
      libraryRepository: libraryRepository,
      playlistRepository: playlistRepository,
      favoritesRepository: favoritesRepository,
      playHistoryRepository: playHistoryRepository,
      settingsRepository: settingsRepository,
      libraryCubit: libraryCubit,
      audioPlayerCubit: audioPlayerCubit,
      equalizerCubit: equalizerCubit,
    ),
  );
}
