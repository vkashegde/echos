import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:just_audio/just_audio.dart';

import '../../../features/library/domain/entities/song_entity.dart';

enum RepeatMode { off, all, one }

class EchosAudioHandler extends BaseAudioHandler
    with QueueHandler, SeekHandler {
  EchosAudioHandler() {
    _init();
  }

  final AndroidEqualizer equalizer = AndroidEqualizer();
  final AndroidLoudnessEnhancer loudnessEnhancer = AndroidLoudnessEnhancer();

  late final AudioPlayer _player = AudioPlayer(
    audioPipeline: AudioPipeline(
      androidAudioEffects: [loudnessEnhancer, equalizer],
    ),
  );
  final List<SongEntity> _songQueue = [];
  int _currentIndex = 0;
  RepeatMode _repeatMode = RepeatMode.off;
  bool _shuffleEnabled = false;

  final _queueController = StreamController<List<SongEntity>>.broadcast();
  Stream<List<SongEntity>> get queueStream => _queueController.stream;

  List<SongEntity> get songQueue => List.unmodifiable(_songQueue);
  int get currentIndex => _currentIndex;
  RepeatMode get repeatMode => _repeatMode;
  bool get shuffleEnabled => _shuffleEnabled;
  SongEntity? get currentSong => _songQueue.isEmpty
      ? null
      : _songQueue[_currentIndex.clamp(0, _songQueue.length - 1)];

  AudioPlayer get player => _player;

  Future<void> _init() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.music());

    _player.playbackEventStream.listen(_broadcastState);
    _player.positionStream.listen((_) => _broadcastState(null));
    _player.durationStream.listen((_) => _broadcastState(null));

    _player.processingStateStream.listen((state) async {
      if (state == ProcessingState.completed) {
        await skipToNext();
      }
    });
  }

  Future<void> setQueue(
    List<SongEntity> songs, {
    int startIndex = 0,
    bool autoPlay = true,
  }) async {
    _songQueue
      ..clear()
      ..addAll(songs);
    _currentIndex = startIndex.clamp(0, songs.isEmpty ? 0 : songs.length - 1);
    await _loadCurrent(autoPlay: autoPlay);
    _queueController.add(List.unmodifiable(_songQueue));
  }

  Future<void> playSong(SongEntity song, {List<SongEntity>? queue}) async {
    final playQueue = queue ?? [song];
    final index = playQueue.indexWhere((s) => s.id == song.id);
    await setQueue(playQueue, startIndex: index < 0 ? 0 : index);
  }

  Future<void> _loadCurrent({bool autoPlay = true}) async {
    if (_songQueue.isEmpty) {
      await _player.stop();
      mediaItem.add(null);
      return;
    }
    final song = _songQueue[_currentIndex];
    final item = _mediaItemFromSong(song);
    mediaItem.add(item);
    queue.add(_songQueue.map(_mediaItemFromSong).toList());

    await _player.setAudioSource(
      AudioSource.uri(Uri.file(song.data)),
      preload: true,
    );
    if (autoPlay) {
      await _player.play();
    }
    _broadcastState(null);
  }

  MediaItem _mediaItemFromSong(SongEntity song) {
    return MediaItem(
      id: song.id.toString(),
      title: song.displayTitle,
      artist: song.displayArtist,
      album: song.displayAlbum,
      duration: Duration(milliseconds: song.durationMs),
      artUri: song.artworkUri != null ? Uri.parse(song.artworkUri!) : null,
      extras: {'data': song.data},
    );
  }

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> stop() async {
    await _player.stop();
    await super.stop();
  }

  @override
  Future<void> seek(Duration position) => _player.seek(position);

  @override
  Future<void> skipToNext() async {
    if (_songQueue.isEmpty) return;
    if (_repeatMode == RepeatMode.one) {
      await _player.seek(Duration.zero);
      await _player.play();
      return;
    }
    if (_currentIndex < _songQueue.length - 1) {
      _currentIndex++;
    } else if (_repeatMode == RepeatMode.all) {
      _currentIndex = 0;
    } else {
      await pause();
      return;
    }
    await _loadCurrent();
  }

  @override
  Future<void> skipToPrevious() async {
    if (_songQueue.isEmpty) return;
    if (_player.position.inSeconds > 3) {
      await _player.seek(Duration.zero);
      return;
    }
    if (_currentIndex > 0) {
      _currentIndex--;
    } else if (_repeatMode == RepeatMode.all) {
      _currentIndex = _songQueue.length - 1;
    } else {
      await _player.seek(Duration.zero);
      return;
    }
    await _loadCurrent();
  }

  @override
  Future<void> skipToQueueItem(int index) async {
    if (index < 0 || index >= _songQueue.length) return;
    _currentIndex = index;
    await _loadCurrent();
  }

  Future<void> setAppRepeatMode(RepeatMode mode) async {
    _repeatMode = mode;
    _broadcastState(null);
  }

  Future<void> setShuffle(bool enabled) async {
    _shuffleEnabled = enabled;
    _broadcastState(null);
  }

  void _broadcastState(PlaybackEvent? event) {
    final playing = _player.playing;
    final processingState = const {
      ProcessingState.idle: AudioProcessingState.idle,
      ProcessingState.loading: AudioProcessingState.loading,
      ProcessingState.buffering: AudioProcessingState.buffering,
      ProcessingState.ready: AudioProcessingState.ready,
      ProcessingState.completed: AudioProcessingState.completed,
    }[_player.processingState]!;

    playbackState.add(
      playbackState.value.copyWith(
        controls: [
          MediaControl.skipToPrevious,
          if (playing) MediaControl.pause else MediaControl.play,
          MediaControl.skipToNext,
        ],
        systemActions: const {
          MediaAction.seek,
          MediaAction.seekForward,
          MediaAction.seekBackward,
        },
        androidCompactActionIndices: const [0, 1, 2],
        processingState: processingState,
        playing: playing,
        updatePosition: _player.position,
        bufferedPosition: _player.bufferedPosition,
        speed: _player.speed,
        queueIndex: _currentIndex,
        repeatMode: switch (_repeatMode) {
          RepeatMode.off => AudioServiceRepeatMode.none,
          RepeatMode.all => AudioServiceRepeatMode.all,
          RepeatMode.one => AudioServiceRepeatMode.one,
        },
        shuffleMode: _shuffleEnabled
            ? AudioServiceShuffleMode.all
            : AudioServiceShuffleMode.none,
      ),
    );
  }

  Future<void> dispose() async {
    await _player.dispose();
    await _queueController.close();
  }
}
