import 'dart:io';

import 'package:just_audio/just_audio.dart';

import '../../services/database/isar_models.dart';
import '../../../features/settings/data/settings_repository.dart';
import 'audio_service_locator.dart';
import 'equalizer_presets.dart';
import 'echos_audio_handler.dart';

class EqualizerService {
  EqualizerService(this._settingsRepository);

  final SettingsRepository _settingsRepository;

  bool get isSupported => Platform.isAndroid;

  EchosAudioHandler get _handler => AudioServiceLocator.handler;
  AndroidEqualizer get equalizer => _handler.equalizer;
  AndroidLoudnessEnhancer get loudnessEnhancer => _handler.loudnessEnhancer;

  Future<AndroidEqualizerParameters?> getParameters() async {
    if (!isSupported) return null;
    return equalizer.parameters;
  }

  Future<AppSettingsCollection> loadAndApply() async {
    final settings = await _settingsRepository.getSettings();
    await applySettings(settings);
    return settings;
  }

  Future<void> applySettings(AppSettingsCollection settings) async {
    if (!isSupported) return;

    await loudnessEnhancer.setEnabled(settings.loudnessBoostEnabled);
    await loudnessEnhancer.setTargetGain(
      settings.loudnessBoostDb.clamp(0, 12),
    );

    await equalizer.setEnabled(settings.equalizerEnabled);
    if (!settings.equalizerEnabled) return;

    if (settings.equalizerPreset == EqualizerPresets.custom &&
        settings.customBandGains.isNotEmpty) {
      await EqualizerPresets.applyCustomGains(
        equalizer,
        settings.customBandGains,
      );
    } else {
      await EqualizerPresets.applyPreset(
        equalizer,
        settings.equalizerPreset,
      );
    }
  }

  Future<AppSettingsCollection> save(AppSettingsCollection settings) async {
    await _settingsRepository.saveSettings(settings);
    await applySettings(settings);
    return settings;
  }
}
