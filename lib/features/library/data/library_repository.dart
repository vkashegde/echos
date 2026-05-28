import 'package:on_audio_query/on_audio_query.dart';

import '../domain/entities/album_entity.dart';
import '../domain/entities/artist_entity.dart';
import '../domain/entities/song_entity.dart';

class LibraryRepository {
  LibraryRepository({OnAudioQuery? audioQuery})
      : _audioQuery = audioQuery ?? OnAudioQuery();

  final OnAudioQuery _audioQuery;

  Future<List<SongEntity>> getSongs() async {
    final songs = await _audioQuery.querySongs(
      sortType: SongSortType.TITLE,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );
    return songs.map(_mapSong).toList();
  }

  Future<List<AlbumEntity>> getAlbums() async {
    final albums = await _audioQuery.queryAlbums(
      sortType: AlbumSortType.ALBUM,
      orderType: OrderType.ASC_OR_SMALLER,
      ignoreCase: true,
    );
    return albums.map(_mapAlbum).toList();
  }

  Future<List<ArtistEntity>> getArtists() async {
    final artists = await _audioQuery.queryArtists(
      sortType: ArtistSortType.ARTIST,
      orderType: OrderType.ASC_OR_SMALLER,
      ignoreCase: true,
    );
    return artists.map(_mapArtist).toList();
  }

  Future<List<SongEntity>> getSongsFromAlbum(int albumId) async {
    final songs = await _audioQuery.queryAudiosFrom(
      AudiosFromType.ALBUM_ID,
      albumId,
      sortType: SongSortType.TITLE,
      orderType: OrderType.ASC_OR_SMALLER,
    );
    return songs.map(_mapSong).toList();
  }

  Future<List<SongEntity>> getSongsFromArtist(int artistId) async {
    final songs = await _audioQuery.queryAudiosFrom(
      AudiosFromType.ARTIST_ID,
      artistId,
    );
    return songs.map(_mapSong).toList();
  }

  Future<List<SongEntity>> getSongsFromGenre(String genre) async {
    final songs = await _audioQuery.queryAudiosFrom(
      AudiosFromType.GENRE,
      genre,
    );
    return songs.map(_mapSong).toList();
  }

  Future<List<String>> getGenres() async {
    final genres = await _audioQuery.queryGenres();
    return genres.map((g) => g.genre).toList();
  }

  Future<List<String>> getFolders() async {
    final songs = await getSongs();
    final folders = <String>{};
    for (final song in songs) {
      if (song.folder != null && song.folder!.isNotEmpty) {
        folders.add(song.folder!);
      }
    }
    return folders.toList()..sort();
  }

  SongEntity _mapSong(SongModel song) {
    return SongEntity(
      id: song.id,
      title: song.title,
      artist: song.artist ?? '',
      album: song.album ?? '',
      albumId: song.albumId ?? 0,
      durationMs: song.duration ?? 0,
      data: song.data,
      artworkUri: song.uri,
      genre: song.genre,
      folder: _extractFolder(song.data),
      track: song.track,
    );
  }

  AlbumEntity _mapAlbum(AlbumModel album) {
    return AlbumEntity(
      id: album.id,
      name: album.album,
      artist: album.artist ?? '',
      songCount: album.numOfSongs,
      artworkUri: null,
    );
  }

  ArtistEntity _mapArtist(ArtistModel artist) {
    return ArtistEntity(
      id: artist.id,
      name: artist.artist,
      songCount: artist.numberOfTracks ?? 0,
      artworkUri: null,
    );
  }

  String? _extractFolder(String path) {
    final normalized = path.replaceAll('\\', '/');
    final lastSlash = normalized.lastIndexOf('/');
    if (lastSlash <= 0) return null;
    return normalized.substring(0, lastSlash);
  }
}
