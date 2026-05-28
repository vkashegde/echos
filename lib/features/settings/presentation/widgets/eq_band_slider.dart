import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../cubit/equalizer_state.dart';

class EqBandSlider extends StatelessWidget {
  const EqBandSlider({
    super.key,
    required this.band,
    required this.onChanged,
  });

  final EqualizerBandInfo band;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    final label = band.centerFrequency >= 1000
        ? '${(band.centerFrequency / 1000).toStringAsFixed(1)}k'
        : '${band.centerFrequency.round()}';

    return Expanded(
      child: Column(
        children: [
          Text(
            band.gain >= 0
                ? '+${band.gain.toStringAsFixed(0)}'
                : band.gain.toStringAsFixed(0),
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppColors.textTertiary,
                  fontSize: 10,
                ),
          ),
          const SizedBox(height: 4),
          Expanded(
            child: RotatedBox(
              quarterTurns: 3,
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 3,
                  thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 7),
                  overlayShape: const RoundSliderOverlayShape(overlayRadius: 14),
                  activeTrackColor: AppColors.accent,
                  inactiveTrackColor: AppColors.border,
                  thumbColor: AppColors.textPrimary,
                ),
                child: Slider(
                  value: band.gain.clamp(band.minGain, band.maxGain),
                  min: band.minGain,
                  max: band.maxGain,
                  onChanged: onChanged,
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontSize: 10,
                ),
          ),
        ],
      ),
    );
  }
}
