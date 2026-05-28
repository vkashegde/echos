import 'package:equatable/equatable.dart';

import '../../../library/domain/entities/song_entity.dart';

class FavoritesState extends Equatable {
  const FavoritesState({
    this.favoriteIds = const {},
    this.likedSongs = const [],
    this.isLoading = false,
  });

  final Set<int> favoriteIds;
  final List<SongEntity> likedSongs;
  final bool isLoading;

  bool isFavorite(int songId) => favoriteIds.contains(songId);

  FavoritesState copyWith({
    Set<int>? favoriteIds,
    List<SongEntity>? likedSongs,
    bool? isLoading,
  }) {
    return FavoritesState(
      favoriteIds: favoriteIds ?? this.favoriteIds,
      likedSongs: likedSongs ?? this.likedSongs,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [favoriteIds, likedSongs, isLoading];
}
