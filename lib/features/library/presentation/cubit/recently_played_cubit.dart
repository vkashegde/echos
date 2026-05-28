import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/play_history_repository.dart';
import 'library_cubit.dart';
import 'library_state.dart';
import 'recently_played_state.dart';

class RecentlyPlayedCubit extends Cubit<RecentlyPlayedState> {
  RecentlyPlayedCubit(this._historyRepository, this._libraryCubit)
      : super(const RecentlyPlayedState()) {
    _libraryCubit.stream.listen((library) {
      if (library.status == LibraryStatus.loaded) {
        refresh(library);
      }
    });
  }

  final PlayHistoryRepository _historyRepository;
  final LibraryCubit _libraryCubit;

  Future<void> refresh([LibraryState? libraryState]) async {
    final library = libraryState ?? _libraryCubit.state;
    if (library.songs.isEmpty) return;

    final recentIds = await _historyRepository.getRecentlyPlayedIds();
    final mostIds = await _historyRepository.getMostPlayedIds();

    emit(RecentlyPlayedState(
      recent: library.songsByIds(recentIds),
      mostPlayed: library.songsByIds(mostIds),
    ));
  }

  Future<void> onSongPlayed(int songId) async {
    await refresh();
  }
}
