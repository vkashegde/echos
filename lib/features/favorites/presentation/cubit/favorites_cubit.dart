import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/favorites_repository.dart';
import '../../../library/presentation/cubit/library_cubit.dart';
import '../../../library/presentation/cubit/library_state.dart';
import 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit(this._repository, this._libraryCubit)
      : super(const FavoritesState()) {
    _libraryCubit.stream.listen((library) {
      if (library.status == LibraryStatus.loaded) {
        _syncLikedSongs(library, state.favoriteIds);
      }
    });
    load();
  }

  final FavoritesRepository _repository;
  final LibraryCubit _libraryCubit;

  Future<void> load() async {
    emit(state.copyWith(isLoading: true));
    final ids = await _repository.getFavoriteIds();
    _syncLikedSongs(_libraryCubit.state, ids);
    emit(state.copyWith(favoriteIds: ids, isLoading: false));
  }

  Future<void> toggle(int songId) async {
    await _repository.toggle(songId);
    final ids = await _repository.getFavoriteIds();
    _syncLikedSongs(_libraryCubit.state, ids);
    emit(state.copyWith(favoriteIds: ids));
  }

  void _syncLikedSongs(LibraryState library, Set<int> ids) {
    final songs = library.songsByIds(ids.toList());
    emit(state.copyWith(likedSongs: songs, favoriteIds: ids));
  }
}
