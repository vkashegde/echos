import 'package:audio_service/audio_service.dart';

import 'echos_audio_handler.dart';

class AudioServiceLocator {
  static EchosAudioHandler? _handler;

  static Future<EchosAudioHandler> init() async {
    if (_handler != null) return _handler!;
    _handler = await AudioService.init(
      builder: EchosAudioHandler.new,
      config: AudioServiceConfig(
        androidNotificationChannelId: 'com.echos.audio',
        androidNotificationChannelName: 'echos playback',
        androidNotificationOngoing: true,
        androidStopForegroundOnPause: true,
      ),
    );
    return _handler!;
  }

  static EchosAudioHandler get handler {
    final h = _handler;
    if (h == null) {
      throw StateError('AudioService not initialized');
    }
    return h;
  }
}
