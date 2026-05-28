import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/favorites/presentation/screens/liked_songs_screen.dart';
import '../features/home/presentation/screens/home_screen.dart';
import '../features/library/presentation/screens/album_detail_screen.dart';
import '../features/player/presentation/screens/now_playing_screen.dart';
import '../features/playlists/presentation/screens/playlist_detail_screen.dart';
import '../features/playlists/presentation/screens/playlists_screen.dart';
import '../features/search/presentation/screens/search_screen.dart';
import '../features/settings/presentation/screens/equalizer_screen.dart';
import '../features/settings/presentation/screens/settings_screen.dart';
import '../features/shell/presentation/screens/app_shell_screen.dart';
import '../features/splash/presentation/screens/splash_screen.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

GoRouter createAppRouter() {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AppShellScreen(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: HomeScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/search',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: SearchScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/library',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: PlaylistsScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/settings',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: SettingsScreen(),
                ),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/player',
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (context, state) => CustomTransitionPage(
          child: const NowPlayingScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutCubic,
              )),
              child: child,
            );
          },
        ),
      ),
      GoRoute(
        path: '/equalizer',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const EqualizerScreen(),
      ),
      GoRoute(
        path: '/liked',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const LikedSongsScreen(),
      ),
      GoRoute(
        path: '/playlist/:id',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return PlaylistDetailScreen(playlistId: id);
        },
      ),
      GoRoute(
        path: '/album/:id',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return AlbumDetailScreen(albumId: id);
        },
      ),
    ],
  );
}
