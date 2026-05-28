import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../library/presentation/cubit/library_cubit.dart';
import '../../../library/presentation/cubit/library_state.dart';

class RescanLibraryTile extends StatefulWidget {
  const RescanLibraryTile({super.key});

  @override
  State<RescanLibraryTile> createState() => _RescanLibraryTileState();
}

class _RescanLibraryTileState extends State<RescanLibraryTile>
    with SingleTickerProviderStateMixin {
  late final AnimationController _spinController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  );

  @override
  void dispose() {
    _spinController.dispose();
    super.dispose();
  }

  void _setSpinning(bool spinning) {
    if (spinning) {
      if (!_spinController.isAnimating) _spinController.repeat();
    } else {
      if (_spinController.isAnimating) {
        _spinController.stop();
        _spinController.reset();
      }
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: isError ? AppColors.error : AppColors.surfaceElevated,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LibraryCubit, LibraryState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        final isScanning = state.status == LibraryStatus.loading;
        _setSpinning(isScanning);

        if (state.status == LibraryStatus.loading) return;

        if (state.errorMessage != null) {
          _showSnackBar(state.errorMessage!, isError: true);
          return;
        }

        final count = state.songs.length;
        _showSnackBar(
          count > 0
              ? 'Sync finished · $count songs'
              : 'Sync finished · no songs found',
        );
      },
      buildWhen: (previous, current) =>
          previous.status != current.status ||
          previous.songs.length != current.songs.length,
      builder: (context, state) {
        final isScanning = state.status == LibraryStatus.loading;

        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: isScanning
                ? null
                : () => context.read<LibraryCubit>().scan(),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.horizontalPadding,
                vertical: AppSpacing.md,
              ),
              child: Row(
                children: [
                  RotationTransition(
                    turns: _spinController,
                    child: Icon(
                      CupertinoIcons.arrow_2_circlepath,
                      color: isScanning
                          ? AppColors.accent
                          : AppColors.textSecondary,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Rescan library',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          isScanning
                              ? 'Scanning your device…'
                              : 'Find new songs on your device',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: isScanning
                                    ? AppColors.accent
                                    : null,
                              ),
                        ),
                      ],
                    ),
                  ),
                  if (isScanning)
                    const CupertinoActivityIndicator(
                      color: AppColors.accent,
                      radius: 10,
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
