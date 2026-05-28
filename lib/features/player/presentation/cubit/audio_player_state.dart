import 'package:equatable/equatable.dart';

import '../../../library/domain/entities/song_entity.dart';
import '../../../../core/services/audio/echos_audio_handler.dart';

class AudioPlayerState extends Equatable {
  const AudioPlayerState({
    this.currentSong,
    this.queue = const [],
    this.currentIndex = 0,
    this.isPlaying = false,
    this.position = Duration.zero,
    this.duration = Duration.zero,
    this.bufferedPosition = Duration.zero,
    this.repeatMode = RepeatMode.off,
    this.shuffleEnabled = false,
    this.isLoading = false,
  });

  final SongEntity? currentSong;
  final List<SongEntity> queue;
  final int currentIndex;
  final bool isPlaying;
  final Duration position;
  final Duration duration;
  final Duration bufferedPosition;
  final RepeatMode repeatMode;
  final bool shuffleEnabled;
  final bool isLoading;

  bool get hasTrack => currentSong != null;

  double get progress {
    if (duration.inMilliseconds <= 0) return 0;
    return (position.inMilliseconds / duration.inMilliseconds).clamp(0.0, 1.0);
  }

  AudioPlayerState copyWith({
    SongEntity? currentSong,
    List<SongEntity>? queue,
    int? currentIndex,
    bool? isPlaying,
    Duration? position,
    Duration? duration,
    Duration? bufferedPosition,
    RepeatMode? repeatMode,
    bool? shuffleEnabled,
    bool? isLoading,
  }) {
    return AudioPlayerState(
      currentSong: currentSong ?? this.currentSong,
      queue: queue ?? this.queue,
      currentIndex: currentIndex ?? this.currentIndex,
      isPlaying: isPlaying ?? this.isPlaying,
      position: position ?? this.position,
      duration: duration ?? this.duration,
      bufferedPosition: bufferedPosition ?? this.bufferedPosition,
      repeatMode: repeatMode ?? this.repeatMode,
      shuffleEnabled: shuffleEnabled ?? this.shuffleEnabled,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
        currentSong,
        queue,
        currentIndex,
        isPlaying,
        position,
        duration,
        repeatMode,
        shuffleEnabled,
        isLoading,
      ];
}
