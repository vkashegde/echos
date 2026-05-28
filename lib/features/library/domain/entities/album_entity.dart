import 'package:equatable/equatable.dart';

class AlbumEntity extends Equatable {
  const AlbumEntity({
    required this.id,
    required this.name,
    required this.artist,
    required this.songCount,
    this.artworkUri,
  });

  final int id;
  final String name;
  final String artist;
  final int songCount;
  final String? artworkUri;

  @override
  List<Object?> get props => [id, name, artist];
}
