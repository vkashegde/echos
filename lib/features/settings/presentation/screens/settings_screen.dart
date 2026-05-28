import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../widgets/rescan_library_tile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppConstants.horizontalPadding,
              AppSpacing.lg,
              AppConstants.horizontalPadding,
              AppSpacing.md,
            ),
            child: Text(
              'Settings',
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: _SettingsGroup(
            title: 'Library',
            children: const [
              RescanLibraryTile(),
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: _SettingsGroup(
            title: 'Playback',
            children: [
              _SettingsTile(
                icon: CupertinoIcons.slider_horizontal_3,
                title: 'Equalizer',
                subtitle: 'Presets, bands & volume boost',
                onTap: () => context.push('/equalizer'),
              ),
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: _SettingsGroup(
            title: 'Appearance',
            children: [
              _SettingsTile(
                icon: CupertinoIcons.moon_fill,
                title: 'Dark theme',
                subtitle: 'Always on for echos',
                trailing: CupertinoSwitch(
                  value: true,
                  activeTrackColor: AppColors.accent,
                  onChanged: null,
                ),
              ),
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: _SettingsGroup(
            title: 'About',
            children: [
              _SettingsTile(
                icon: CupertinoIcons.info_circle,
                title: AppConstants.appName,
                subtitle: 'Version 1.0.0 · Offline music player',
              ),
            ],
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 120)),
      ],
    );
  }
}

class _SettingsGroup extends StatelessWidget {
  const _SettingsGroup({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.horizontalPadding,
              vertical: AppSpacing.sm,
            ),
            child: Text(
              title.toUpperCase(),
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
          ...children,
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.horizontalPadding,
            vertical: AppSpacing.md,
          ),
          child: Row(
            children: [
              Icon(icon, color: AppColors.textSecondary, size: 22),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: Theme.of(context).textTheme.titleMedium),
                    if (subtitle != null)
                      Text(subtitle!, style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
        ),
      ),
    );
  }
}
