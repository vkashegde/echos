import 'package:equatable/equatable.dart';

import '../../domain/entities/playlist_entity.dart';

class PlaylistState extends Equatable {
  const PlaylistState({
    this.playlists = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  final List<PlaylistEntity> playlists;
  final bool isLoading;
  final String? errorMessage;

  List<PlaylistEntity> get userPlaylists =>
      playlists.where((p) => !p.isSystem).toList();

  PlaylistState copyWith({
    List<PlaylistEntity>? playlists,
    bool? isLoading,
    String? errorMessage,
  }) {
    return PlaylistState(
      playlists: playlists ?? this.playlists,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [playlists, isLoading];
}
