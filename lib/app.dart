import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/theme/app_theme.dart';
import 'features/favorites/data/favorites_repository.dart';
import 'features/favorites/presentation/cubit/favorites_cubit.dart';
import 'features/library/data/library_repository.dart';
import 'features/library/data/play_history_repository.dart';
import 'features/library/presentation/cubit/library_cubit.dart';
import 'features/library/presentation/cubit/recently_played_cubit.dart';
import 'features/player/presentation/cubit/audio_player_cubit.dart';
import 'features/player/presentation/cubit/theme_cubit.dart';
import 'features/playlists/data/playlist_repository.dart';
import 'features/playlists/presentation/cubit/playlist_cubit.dart';
import 'features/search/presentation/cubit/search_cubit.dart';
import 'features/settings/data/settings_repository.dart';
import 'features/settings/presentation/cubit/equalizer_cubit.dart';
import 'routes/app_router.dart';

class EchosApp extends StatelessWidget {
  const EchosApp({
    super.key,
    required this.libraryRepository,
    required this.playlistRepository,
    required this.favoritesRepository,
    required this.playHistoryRepository,
    required this.settingsRepository,
    required this.libraryCubit,
    required this.audioPlayerCubit,
    required this.equalizerCubit,
  });

  final LibraryRepository libraryRepository;
  final PlaylistRepository playlistRepository;
  final FavoritesRepository favoritesRepository;
  final PlayHistoryRepository playHistoryRepository;
  final SettingsRepository settingsRepository;
  final LibraryCubit libraryCubit;
  final AudioPlayerCubit audioPlayerCubit;
  final EqualizerCubit equalizerCubit;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: libraryRepository),
        RepositoryProvider.value(value: playlistRepository),
        RepositoryProvider.value(value: favoritesRepository),
        RepositoryProvider.value(value: playHistoryRepository),
        RepositoryProvider.value(value: settingsRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: libraryCubit),
          BlocProvider.value(value: audioPlayerCubit),
          BlocProvider.value(value: equalizerCubit),
          BlocProvider(create: (_) => ThemeCubit()),
          BlocProvider(
            create: (_) => RecentlyPlayedCubit(
              playHistoryRepository,
              libraryCubit,
            ),
          ),
          BlocProvider(
            create: (_) => FavoritesCubit(favoritesRepository, libraryCubit),
          ),
          BlocProvider(
            create: (_) => PlaylistCubit(playlistRepository),
          ),
          BlocProvider(
            create: (_) => SearchCubit(libraryCubit),
          ),
        ],
        child: MaterialApp.router(
          title: 'echos',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.dark,
          routerConfig: createAppRouter(),
          builder: (context, child) {
            return AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle.light.copyWith(
                statusBarColor: Colors.transparent,
              ),
              child: child ?? const SizedBox.shrink(),
            );
          },
        ),
      ),
    );
  }
}
