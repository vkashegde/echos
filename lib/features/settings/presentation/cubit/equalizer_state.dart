import 'package:equatable/equatable.dart';

class EqualizerBandInfo extends Equatable {
  const EqualizerBandInfo({
    required this.index,
    required this.centerFrequency,
    required this.gain,
    required this.minGain,
    required this.maxGain,
  });

  final int index;
  final double centerFrequency;
  final double gain;
  final double minGain;
  final double maxGain;

  @override
  List<Object?> get props => [index, centerFrequency, gain];
}

class EqualizerState extends Equatable {
  const EqualizerState({
    this.isSupported = false,
    this.isLoading = true,
    this.equalizerEnabled = false,
    this.loudnessBoostEnabled = false,
    this.loudnessBoostDb = 0,
    this.preset = 'flat',
    this.bands = const [],
    this.minDecibels = -12,
    this.maxDecibels = 12,
  });

  final bool isSupported;
  final bool isLoading;
  final bool equalizerEnabled;
  final bool loudnessBoostEnabled;
  final double loudnessBoostDb;
  final String preset;
  final List<EqualizerBandInfo> bands;
  final double minDecibels;
  final double maxDecibels;

  bool get isCustom => preset == 'custom';

  EqualizerState copyWith({
    bool? isSupported,
    bool? isLoading,
    bool? equalizerEnabled,
    bool? loudnessBoostEnabled,
    double? loudnessBoostDb,
    String? preset,
    List<EqualizerBandInfo>? bands,
    double? minDecibels,
    double? maxDecibels,
  }) {
    return EqualizerState(
      isSupported: isSupported ?? this.isSupported,
      isLoading: isLoading ?? this.isLoading,
      equalizerEnabled: equalizerEnabled ?? this.equalizerEnabled,
      loudnessBoostEnabled: loudnessBoostEnabled ?? this.loudnessBoostEnabled,
      loudnessBoostDb: loudnessBoostDb ?? this.loudnessBoostDb,
      preset: preset ?? this.preset,
      bands: bands ?? this.bands,
      minDecibels: minDecibels ?? this.minDecibels,
      maxDecibels: maxDecibels ?? this.maxDecibels,
    );
  }

  @override
  List<Object?> get props => [
        isSupported,
        isLoading,
        equalizerEnabled,
        loudnessBoostEnabled,
        loudnessBoostDb,
        preset,
        bands,
      ];
}
