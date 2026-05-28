import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class PremiumSeekBar extends StatelessWidget {
  const PremiumSeekBar({
    super.key,
    required this.progress,
    required this.onChanged,
    required this.onChangeEnd,
    this.activeColor,
    this.bufferedProgress,
  });

  final double progress;
  final double? bufferedProgress;
  final ValueChanged<double> onChanged;
  final ValueChanged<double> onChangeEnd;
  final Color? activeColor;

  @override
  Widget build(BuildContext context) {
    final color = activeColor ?? AppColors.accent;
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        trackHeight: 3,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 14),
        activeTrackColor: color,
        inactiveTrackColor: AppColors.border,
        thumbColor: AppColors.textPrimary,
        overlayColor: color.withValues(alpha: 0.12),
      ),
      child: Slider(
        value: progress.clamp(0.0, 1.0),
        onChanged: onChanged,
        onChangeEnd: onChangeEnd,
      ),
    );
  }
}
