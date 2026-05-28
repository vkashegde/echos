import 'package:just_audio/just_audio.dart';

/// Named EQ curves (5-band reference, interpolated to device band count).
abstract final class EqualizerPresets {
  static const flat = 'flat';
  static const bass = 'bass';
  static const vocal = 'vocal';
  static const treble = 'treble';
  static const rock = 'rock';
  static const electronic = 'electronic';
  static const custom = 'custom';

  static const labels = {
    flat: 'Flat',
    bass: 'Bass',
    vocal: 'Vocal',
    treble: 'Treble',
    rock: 'Rock',
    electronic: 'Electronic',
    custom: 'Custom',
  };

  static const List<String> selectable = [
    flat,
    bass,
    vocal,
    treble,
    rock,
    electronic,
  ];

  /// Reference gains in dB for 5 bands: sub → treble.
  static List<double> referenceGains(String preset) {
    return switch (preset) {
      bass => [7, 5, 1, -1, -2],
      vocal => [-2, -1, 4, 3, 1],
      treble => [-2, -1, 0, 4, 6],
      rock => [5, 3, -1, 2, 4],
      electronic => [6, 4, 0, 2, 5],
      custom => [0, 0, 0, 0, 0],
      _ => [0, 0, 0, 0, 0],
    };
  }

  static List<double> interpolateGains(List<double> reference, int bandCount) {
    if (bandCount <= 0) return [];
    if (bandCount == 1) return [reference[reference.length ~/ 2]];
    if (reference.length == bandCount) return List<double>.from(reference);

    final result = <double>[];
    for (var i = 0; i < bandCount; i++) {
      final t = i / (bandCount - 1);
      final pos = t * (reference.length - 1);
      final lower = pos.floor();
      final upper = pos.ceil().clamp(0, reference.length - 1);
      final frac = pos - lower;
      result.add(
        reference[lower] * (1 - frac) + reference[upper] * frac,
      );
    }
    return result;
  }

  static Future<List<double>> applyPreset(
    AndroidEqualizer equalizer,
    String preset,
  ) async {
    final parameters = await equalizer.parameters;
    final gains = interpolateGains(referenceGains(preset), parameters.bands.length);
    await _setBandGains(parameters, gains);
    return gains;
  }

  static Future<void> applyCustomGains(
    AndroidEqualizer equalizer,
    List<double> gains,
  ) async {
    final parameters = await equalizer.parameters;
    final interpolated = interpolateGains(gains, parameters.bands.length);
    await _setBandGains(parameters, interpolated);
  }

  static Future<List<double>> readCurrentGains(AndroidEqualizer equalizer) async {
    final parameters = await equalizer.parameters;
    return parameters.bands.map((b) => b.gain).toList();
  }

  static Future<void> _setBandGains(
    AndroidEqualizerParameters parameters,
    List<double> gains,
  ) async {
    for (var i = 0; i < parameters.bands.length; i++) {
      final gain = gains[i].clamp(
        parameters.minDecibels,
        parameters.maxDecibels,
      );
      await parameters.bands[i].setGain(gain);
    }
  }
}
