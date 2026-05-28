import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/permission_helper.dart';
import '../../data/library_repository.dart';
import 'library_state.dart';

class LibraryCubit extends Cubit<LibraryState> {
  LibraryCubit(this._repository, this._permissionHelper)
      : super(const LibraryState());

  final LibraryRepository _repository;
  final PermissionHelper _permissionHelper;

  /// Rescans device media. Returns `true` on success.
  Future<bool> scan() async {
    if (state.status == LibraryStatus.loading) return false;

    emit(state.copyWith(status: LibraryStatus.loading, errorMessage: null));
    try {
      final granted = await _permissionHelper.ensurePermissions();
      if (!granted) {
        emit(state.copyWith(
          status: LibraryStatus.loaded,
          errorMessage: 'Storage permission required to scan music.',
        ));
        return false;
      }

      final songs = await _repository.getSongs();
      final albums = await _repository.getAlbums();
      final artists = await _repository.getArtists();
      final genres = await _repository.getGenres();
      final folders = await _repository.getFolders();

      emit(state.copyWith(
        status: LibraryStatus.loaded,
        songs: songs,
        albums: albums,
        artists: artists,
        genres: genres,
        folders: folders,
        errorMessage: null,
      ));
      return true;
    } catch (e) {
      emit(state.copyWith(
        status: LibraryStatus.loaded,
        errorMessage: e.toString(),
      ));
      return false;
    }
  }
}
