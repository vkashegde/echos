import 'package:equatable/equatable.dart';

import '../../domain/entities/song_entity.dart';

class RecentlyPlayedState extends Equatable {
  const RecentlyPlayedState({
    this.recent = const [],
    this.mostPlayed = const [],
  });

  final List<SongEntity> recent;
  final List<SongEntity> mostPlayed;

  RecentlyPlayedState copyWith({
    List<SongEntity>? recent,
    List<SongEntity>? mostPlayed,
  }) {
    return RecentlyPlayedState(
      recent: recent ?? this.recent,
      mostPlayed: mostPlayed ?? this.mostPlayed,
    );
  }

  @override
  List<Object?> get props => [recent, mostPlayed];
}
