import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/services/audio/equalizer_presets.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../cubit/equalizer_cubit.dart';
import '../cubit/equalizer_state.dart';
import '../widgets/eq_band_slider.dart';

class EqualizerScreen extends StatefulWidget {
  const EqualizerScreen({super.key});

  @override
  State<EqualizerScreen> createState() => _EqualizerScreenState();
}

class _EqualizerScreenState extends State<EqualizerScreen> {
  @override
  void initState() {
    super.initState();
    context.read<EqualizerCubit>().load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: AppBar(
        title: const Text('Equalizer'),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(CupertinoIcons.chevron_back),
        ),
        actions: [
          BlocBuilder<EqualizerCubit, EqualizerState>(
            builder: (context, state) {
              if (!state.isSupported || state.isLoading) {
                return const SizedBox.shrink();
              }
              return TextButton(
                onPressed: () => context.read<EqualizerCubit>().reset(),
                child: const Text('Reset'),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<EqualizerCubit, EqualizerState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CupertinoActivityIndicator(color: AppColors.accent),
            );
          }

          if (!state.isSupported) {
            return _UnsupportedPlatform();
          }

          return ListView(
            padding: const EdgeInsets.fromLTRB(
              AppConstants.horizontalPadding,
              AppSpacing.md,
              AppConstants.horizontalPadding,
              120,
            ),
            children: [
              _ToggleCard(
                title: 'Equalizer',
                subtitle: 'Adjust frequency bands while music plays',
                value: state.equalizerEnabled,
                onChanged: context.read<EqualizerCubit>().setEqualizerEnabled,
              ),
              const SizedBox(height: AppSpacing.lg),
              Text('Presets', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: AppSpacing.sm),
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: EqualizerPresets.selectable.map((preset) {
                  final selected = state.preset == preset && !state.isCustom;
                  return FilterChip(
                    label: Text(EqualizerPresets.labels[preset]!),
                    selected: selected,
                    onSelected: (_) =>
                        context.read<EqualizerCubit>().applyPreset(preset),
                    selectedColor: AppColors.accent.withValues(alpha: 0.25),
                    checkmarkColor: AppColors.accent,
                    labelStyle: TextStyle(
                      color: selected
                          ? AppColors.accent
                          : AppColors.textSecondary,
                    ),
                    side: BorderSide(
                      color: selected
                          ? AppColors.accent.withValues(alpha: 0.5)
                          : AppColors.border,
                    ),
                  );
                }).toList(),
              ),
              if (state.equalizerEnabled && state.bands.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.xl),
                SizedBox(
                  height: 220,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: state.bands
                        .map(
                          (band) => EqBandSlider(
                            band: band,
                            onChanged: (gain) => context
                                .read<EqualizerCubit>()
                                .setBandGain(band.index, gain),
                          ),
                        )
                        .toList(),
                  ),
                ),
                if (state.isCustom)
                  Padding(
                    padding: const EdgeInsets.only(top: AppSpacing.sm),
                    child: Text(
                      'Custom — drag bands to fine-tune',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
              ],
              const SizedBox(height: AppSpacing.xxl),
              Text('Volume boost', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: AppSpacing.sm),
              _ToggleCard(
                title: 'Loudness boost',
                subtitle: 'Raise quiet passages (Android DSP)',
                value: state.loudnessBoostEnabled,
                onChanged: context.read<EqualizerCubit>().setLoudnessEnabled,
              ),
              if (state.loudnessBoostEnabled) ...[
                const SizedBox(height: AppSpacing.md),
                Row(
                  children: [
                    Text(
                      '0 dB',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    Expanded(
                      child: Slider(
                        value: state.loudnessBoostDb,
                        min: 0,
                        max: 12,
                        divisions: 12,
                        label: '${state.loudnessBoostDb.round()} dB',
                        activeColor: AppColors.accent,
                        onChanged: context.read<EqualizerCubit>().setLoudnessDb,
                      ),
                    ),
                    Text(
                      '${state.loudnessBoostDb.round()} dB',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: AppColors.accent,
                          ),
                    ),
                  ],
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}

class _ToggleCard extends StatelessWidget {
  const _ToggleCard({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceElevated,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.4)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleMedium),
                Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
          CupertinoSwitch(
            value: value,
            activeTrackColor: AppColors.accent,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

class _UnsupportedPlatform extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              CupertinoIcons.graph_circle,
              size: 56,
              color: AppColors.textTertiary,
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'Equalizer on Android',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Frequency EQ and loudness boost use Android’s built-in audio '
              'effects during playback. This feature is not available on iOS yet.',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
