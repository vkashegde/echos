import 'package:equatable/equatable.dart';

import '../../../library/domain/entities/album_entity.dart';
import '../../../library/domain/entities/artist_entity.dart';
import '../../../library/domain/entities/song_entity.dart';

class SearchState extends Equatable {
  const SearchState({
    this.query = '',
    this.songs = const [],
    this.albums = const [],
    this.artists = const [],
    this.isSearching = false,
  });

  final String query;
  final List<SongEntity> songs;
  final List<AlbumEntity> albums;
  final List<ArtistEntity> artists;
  final bool isSearching;

  bool get isEmpty =>
      query.isEmpty && songs.isEmpty && albums.isEmpty && artists.isEmpty;

  bool get hasResults =>
      songs.isNotEmpty || albums.isNotEmpty || artists.isNotEmpty;

  SearchState copyWith({
    String? query,
    List<SongEntity>? songs,
    List<AlbumEntity>? albums,
    List<ArtistEntity>? artists,
    bool? isSearching,
  }) {
    return SearchState(
      query: query ?? this.query,
      songs: songs ?? this.songs,
      albums: albums ?? this.albums,
      artists: artists ?? this.artists,
      isSearching: isSearching ?? this.isSearching,
    );
  }

  @override
  List<Object?> get props => [query, songs, albums, artists, isSearching];
}
