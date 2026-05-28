import 'package:equatable/equatable.dart';

import '../../domain/entities/album_entity.dart';
import '../../domain/entities/artist_entity.dart';
import '../../domain/entities/song_entity.dart';

enum LibraryStatus { initial, loading, loaded, error }

class LibraryState extends Equatable {
  const LibraryState({
    this.status = LibraryStatus.initial,
    this.songs = const [],
    this.albums = const [],
    this.artists = const [],
    this.genres = const [],
    this.folders = const [],
    this.errorMessage,
  });

  final LibraryStatus status;
  final List<SongEntity> songs;
  final List<AlbumEntity> albums;
  final List<ArtistEntity> artists;
  final List<String> genres;
  final List<String> folders;
  final String? errorMessage;

  SongEntity? songById(int id) {
    try {
      return songs.firstWhere((s) => s.id == id);
    } catch (_) {
      return null;
    }
  }

  List<SongEntity> songsByIds(List<int> ids) {
    final map = {for (final s in songs) s.id: s};
    return ids.map((id) => map[id]).whereType<SongEntity>().toList();
  }

  LibraryState copyWith({
    LibraryStatus? status,
    List<SongEntity>? songs,
    List<AlbumEntity>? albums,
    List<ArtistEntity>? artists,
    List<String>? genres,
    List<String>? folders,
    String? errorMessage,
  }) {
    return LibraryState(
      status: status ?? this.status,
      songs: songs ?? this.songs,
      albums: albums ?? this.albums,
      artists: artists ?? this.artists,
      genres: genres ?? this.genres,
      folders: folders ?? this.folders,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, songs, albums, artists, genres, folders];
}
