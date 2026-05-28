import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../library/presentation/cubit/library_cubit.dart';
import '../../../library/presentation/cubit/library_state.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this._libraryCubit) : super(const SearchState());

  final LibraryCubit _libraryCubit;
  Timer? _debounce;

  void search(String query) {
    _debounce?.cancel();
    final trimmed = query.trim();
    if (trimmed.isEmpty) {
      emit(const SearchState());
      return;
    }
    emit(state.copyWith(query: trimmed, isSearching: true));
    _debounce = Timer(AppConstants.searchDebounce, () {
      _performSearch(trimmed);
    });
  }

  void clear() {
    _debounce?.cancel();
    emit(const SearchState());
  }

  void _performSearch(String query) {
    final library = _libraryCubit.state;
    if (library.status != LibraryStatus.loaded) {
      emit(state.copyWith(isSearching: false));
      return;
    }
    final lower = query.toLowerCase();

    final songs = library.songs
        .where((s) =>
            s.displayTitle.toLowerCase().contains(lower) ||
            s.displayArtist.toLowerCase().contains(lower) ||
            s.displayAlbum.toLowerCase().contains(lower))
        .take(30)
        .toList();

    final albums = library.albums
        .where((a) =>
            a.name.toLowerCase().contains(lower) ||
            a.artist.toLowerCase().contains(lower))
        .take(15)
        .toList();

    final artists = library.artists
        .where((a) => a.name.toLowerCase().contains(lower))
        .take(15)
        .toList();

    emit(SearchState(
      query: query,
      songs: songs,
      albums: albums,
      artists: artists,
      isSearching: false,
    ));
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
