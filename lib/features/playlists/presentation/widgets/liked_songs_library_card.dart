import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/media_card.dart';
import '../../../favorites/presentation/cubit/favorites_cubit.dart';
import '../../../favorites/presentation/cubit/favorites_state.dart';

class LikedSongsLibraryCard extends StatelessWidget {
  const LikedSongsLibraryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, state) {
        final count = state.likedSongs.length;
        return PlaylistCard(
          name: 'Liked Songs',
          songCount: count,
          onTap: () => context.push('/liked'),
          leading: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.accent.withValues(alpha: 0.85),
                  const Color(0xFF1A4D2E),
                ],
              ),
            ),
            child: const Icon(
              CupertinoIcons.heart_fill,
              color: Colors.white,
              size: 26,
            ),
          ),
        );
      },
    );
  }
}
