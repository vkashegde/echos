import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/navigation/player_navigation.dart';
import '../../../../core/services/audio/audio_service_locator.dart';
import '../../../../core/services/audio/echos_audio_handler.dart';
import '../../../library/data/play_history_repository.dart';
import '../../../library/domain/entities/song_entity.dart';
import 'audio_player_state.dart';

class AudioPlayerCubit extends Cubit<AudioPlayerState> {
  AudioPlayerCubit(this._playHistoryRepository) : super(const AudioPlayerState()) {
    _subscribe();
  }

  final PlayHistoryRepository _playHistoryRepository;
  late final EchosAudioHandler _handler = AudioServiceLocator.handler;

  StreamSubscription<dynamic>? _positionSub;
  StreamSubscription<dynamic>? _durationSub;
  StreamSubscription<dynamic>? _playingSub;
  StreamSubscription<dynamic>? _queueSub;

  void _subscribe() {
    final player = _handler.player;
    _positionSub = player.positionStream.listen((position) {
      emit(state.copyWith(position: position));
    });
    _durationSub = player.durationStream.listen((duration) {
      if (duration != null) {
        emit(state.copyWith(duration: duration));
      }
    });
    _playingSub = player.playingStream.listen((playing) {
      emit(state.copyWith(isPlaying: playing));
    });
    _queueSub = _handler.queueStream.listen((queue) {
      emit(state.copyWith(
        queue: queue,
        currentSong: _handler.currentSong,
        currentIndex: _handler.currentIndex,
      ));
    });
  }

  Future<void> playQueue(
    List<SongEntity> songs, {
    int startIndex = 0,
    bool openPlayer = false,
  }) async {
    if (songs.isEmpty) return;

    final index = startIndex.clamp(0, songs.length - 1);
    final song = songs[index];

    emit(state.copyWith(
      isLoading: true,
      currentSong: song,
      queue: songs,
      currentIndex: index,
    ));

    await _handler.setQueue(songs, startIndex: index);
    final current = _handler.currentSong;
    if (current != null) {
      await _playHistoryRepository.recordPlay(current.id);
    }

    emit(state.copyWith(
      isLoading: false,
      queue: _handler.songQueue,
      currentSong: current ?? song,
      currentIndex: _handler.currentIndex,
      isPlaying: _handler.player.playing,
      duration: _handler.player.duration ?? Duration.zero,
      repeatMode: _handler.repeatMode,
      shuffleEnabled: _handler.shuffleEnabled,
    ));

    if (openPlayer) {
      PlayerNavigation.openNowPlaying();
    }
  }

  Future<void> playSong(
    SongEntity song, {
    List<SongEntity>? queue,
    bool openPlayer = true,
  }) async {
    final songs = queue ?? [song];
    var index = songs.indexWhere((s) => s.id == song.id);
    if (index < 0) index = 0;
    await playQueue(
      songs,
      startIndex: index,
      openPlayer: openPlayer,
    );
  }

  Future<void> togglePlayPause() async {
    if (_handler.player.playing) {
      await _handler.pause();
    } else {
      await _handler.play();
    }
  }

  Future<void> seek(Duration position) => _handler.seek(position);

  Future<void> next() => _handler.skipToNext();

  Future<void> previous() => _handler.skipToPrevious();

  Future<void> cycleRepeat() async {
    final next = switch (_handler.repeatMode) {
      RepeatMode.off => RepeatMode.all,
      RepeatMode.all => RepeatMode.one,
      RepeatMode.one => RepeatMode.off,
    };
    await _handler.setAppRepeatMode(next);
    emit(state.copyWith(repeatMode: next));
  }

  Future<void> toggleShuffle() async {
    final enabled = !_handler.shuffleEnabled;
    await _handler.setShuffle(enabled);
    emit(state.copyWith(shuffleEnabled: enabled));
  }

  @override
  Future<void> close() async {
    await _positionSub?.cancel();
    await _durationSub?.cancel();
    await _playingSub?.cancel();
    await _queueSub?.cancel();
    return super.close();
  }
}
