import 'package:equatable/equatable.dart';

class SongEntity extends Equatable {
  const SongEntity({
    required this.id,
    required this.title,
    required this.artist,
    required this.album,
    required this.albumId,
    required this.durationMs,
    required this.data,
    this.artworkUri,
    this.genre,
    this.folder,
    this.track,
  });

  final int id;
  final String title;
  final String artist;
  final String album;
  final int albumId;
  final int durationMs;
  final String data;
  final String? artworkUri;
  final String? genre;
  final String? folder;
  final int? track;

  String get displayArtist => artist.isEmpty ? 'Unknown Artist' : artist;
  String get displayAlbum => album.isEmpty ? 'Unknown Album' : album;
  String get displayTitle => title.isEmpty ? 'Unknown Title' : title;

  @override
  List<Object?> get props => [id, title, artist, album, data];
}
