import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/audio/equalizer_presets.dart';
import '../../../../core/services/audio/equalizer_service.dart';
import '../../../../core/services/database/isar_models.dart';
import 'equalizer_state.dart';

class EqualizerCubit extends Cubit<EqualizerState> {
  EqualizerCubit(this._service) : super(const EqualizerState());

  final EqualizerService _service;
  AppSettingsCollection? _settings;

  Future<void> load() async {
    emit(state.copyWith(isLoading: true, isSupported: _service.isSupported));
    if (!_service.isSupported) {
      emit(state.copyWith(isLoading: false, isSupported: false));
      return;
    }

    _settings = await _service.loadAndApply();
    await _syncBandsFromDevice();
    emit(state.copyWith(
      isLoading: false,
      equalizerEnabled: _settings!.equalizerEnabled,
      loudnessBoostEnabled: _settings!.loudnessBoostEnabled,
      loudnessBoostDb: _settings!.loudnessBoostDb,
      preset: _settings!.equalizerPreset,
    ));
  }

  Future<void> setEqualizerEnabled(bool enabled) async {
    await _updateSettings(
      (s) => s..equalizerEnabled = enabled,
    );
    emit(state.copyWith(equalizerEnabled: enabled));
    if (enabled) await _syncBandsFromDevice();
  }

  Future<void> setLoudnessEnabled(bool enabled) async {
    await _updateSettings((s) => s..loudnessBoostEnabled = enabled);
    emit(state.copyWith(loudnessBoostEnabled: enabled));
  }

  Future<void> setLoudnessDb(double db) async {
    final clamped = db.clamp(0.0, 12.0);
    await _updateSettings((s) => s..loudnessBoostDb = clamped);
    emit(state.copyWith(loudnessBoostDb: clamped));
  }

  Future<void> applyPreset(String preset) async {
    if (!_service.isSupported) return;
    final gains = await EqualizerPresets.applyPreset(
      _service.equalizer,
      preset,
    );
    await _updateSettings((s) {
      s.equalizerPreset = preset;
      s.customBandGains = gains;
      s.equalizerEnabled = true;
    });
    await _syncBandsFromDevice();
    emit(state.copyWith(
      preset: preset,
      equalizerEnabled: true,
    ));
  }

  Future<void> setBandGain(int index, double gain) async {
    if (!_service.isSupported) return;
    final parameters = await _service.getParameters();
    if (parameters == null || index >= parameters.bands.length) return;

    final clamped = gain.clamp(parameters.minDecibels, parameters.maxDecibels);
    await parameters.bands[index].setGain(clamped);

    final gains = await EqualizerPresets.readCurrentGains(_service.equalizer);
    await _updateSettings((s) {
      s.equalizerPreset = EqualizerPresets.custom;
      s.customBandGains = gains;
      s.equalizerEnabled = true;
    });
    await _syncBandsFromDevice();
    emit(state.copyWith(preset: EqualizerPresets.custom, equalizerEnabled: true));
  }

  Future<void> reset() => applyPreset(EqualizerPresets.flat);

  Future<void> _updateSettings(
    void Function(AppSettingsCollection settings) mutate,
  ) async {
    _settings ??= await _service.loadAndApply();
    mutate(_settings!);
    _settings = await _service.save(_settings!);
  }

  Future<void> _syncBandsFromDevice() async {
    final parameters = await _service.getParameters();
    if (parameters == null) return;

    final bands = <EqualizerBandInfo>[];
    for (final band in parameters.bands) {
      bands.add(EqualizerBandInfo(
        index: band.index,
        centerFrequency: band.centerFrequency,
        gain: band.gain,
        minGain: parameters.minDecibels,
        maxGain: parameters.maxDecibels,
      ));
    }

    emit(state.copyWith(
      bands: bands,
      minDecibels: parameters.minDecibels,
      maxDecibels: parameters.maxDecibels,
    ));
  }
}
