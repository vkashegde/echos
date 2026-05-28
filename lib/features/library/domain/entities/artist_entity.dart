import 'package:equatable/equatable.dart';

class ArtistEntity extends Equatable {
  const ArtistEntity({
    required this.id,
    required this.name,
    required this.songCount,
    this.artworkUri,
  });

  final int id;
  final String name;
  final int songCount;
  final String? artworkUri;

  @override
  List<Object?> get props => [id, name];
}
