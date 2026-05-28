import 'package:go_router/go_router.dart';

import '../../routes/app_router.dart';

/// Opens the full-screen now playing UI on the root navigator.
abstract final class PlayerNavigation {
  static void openNowPlaying() {
    final context = rootNavigatorKey.currentContext;
    if (context == null || !context.mounted) return;

    final router = GoRouter.of(context);
    final path = router.state.uri.path;
    if (path == '/player') return;

    router.push('/player');
  }
}
