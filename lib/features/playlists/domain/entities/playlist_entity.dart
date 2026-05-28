import 'package:equatable/equatable.dart';

class PlaylistEntity extends Equatable {
  const PlaylistEntity({
    required this.id,
    required this.name,
    required this.songIds,
    this.createdAt,
    this.isSystem = false,
  });

  final int id;
  final String name;
  final List<int> songIds;
  final DateTime? createdAt;
  final bool isSystem;

  int get songCount => songIds.length;

  @override
  List<Object?> get props => [id, name, songIds, isSystem];
}
