import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/playlist_entity.dart';
import '../cubit/playlist_cubit.dart';
import '../cubit/playlist_state.dart';

/// Bottom sheet to add [songId] to an existing playlist or a new one.
class AddToPlaylistSheet extends StatefulWidget {
  const AddToPlaylistSheet({
    super.key,
    required this.songId,
    required this.songTitle,
  });

  final int songId;
  final String songTitle;

  static Future<void> show(
    BuildContext context, {
    required int songId,
    required String songTitle,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AddToPlaylistSheet(
        songId: songId,
        songTitle: songTitle,
      ),
    );
  }

  @override
  State<AddToPlaylistSheet> createState() => _AddToPlaylistSheetState();
}

class _AddToPlaylistSheetState extends State<AddToPlaylistSheet> {
  bool _isCreating = false;

  @override
  void initState() {
    super.initState();
    context.read<PlaylistCubit>().load();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height * 0.72,
        ),
        decoration: const BoxDecoration(
          color: AppColors.surfaceElevated,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          border: Border(
            top: BorderSide(color: AppColors.border),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: AppSpacing.sm),
            Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.lg,
                AppSpacing.lg,
                AppSpacing.sm,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Add to playlist',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.songTitle,
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Flexible(
              child: BlocBuilder<PlaylistCubit, PlaylistState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Padding(
                      padding: EdgeInsets.all(AppSpacing.xxl),
                      child: Center(
                        child: CupertinoActivityIndicator(
                          color: AppColors.accent,
                        ),
                      ),
                    );
                  }

                  final playlists = state.userPlaylists;

                  if (playlists.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.all(AppSpacing.xl),
                      child: Text(
                        'No playlists yet. Create one below.',
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                    );
                  }

                  return ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                    ),
                    itemCount: playlists.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final playlist = playlists[index];
                      final contains =
                          playlist.songIds.contains(widget.songId);
                      return _PlaylistRow(
                        playlist: playlist,
                        contains: contains,
                        onTap: contains
                            ? null
                            : () => _addToExisting(context, playlist),
                      );
                    },
                  );
                },
              ),
            ),
            const Divider(height: 1),
            if (_isCreating)
              _CreatePlaylistForm(
                onCancel: () => setState(() => _isCreating = false),
                onCreate: (name) => _createAndAdd(context, name),
              )
            else
              ListTile(
                leading: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                    border: Border.all(
                      color: AppColors.accent.withValues(alpha: 0.4),
                    ),
                  ),
                  child: const Icon(
                    CupertinoIcons.plus,
                    color: AppColors.accent,
                  ),
                ),
                title: const Text('New playlist'),
                subtitle: const Text('Create and add this song'),
                onTap: () => setState(() => _isCreating = true),
              ),
            SizedBox(height: MediaQuery.paddingOf(context).bottom + 8),
          ],
        ),
      ),
    );
  }

  Future<void> _addToExisting(
    BuildContext context,
    PlaylistEntity playlist,
  ) async {
    final added = await context.read<PlaylistCubit>().addSong(
          playlist.id,
          widget.songId,
        );
    if (!context.mounted) return;
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          added
              ? 'Added to ${playlist.name}'
              : 'Already in ${playlist.name}',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _createAndAdd(BuildContext context, String name) async {
    final playlistName = await context.read<PlaylistCubit>().createAndAddSong(
          name,
          widget.songId,
        );
    if (!context.mounted) return;
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Added to $playlistName'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

class _PlaylistRow extends StatelessWidget {
  const _PlaylistRow({
    required this.playlist,
    required this.contains,
    this.onTap,
  });

  final PlaylistEntity playlist;
  final bool contains;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      enabled: onTap != null,
      onTap: onTap,
      leading: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
        ),
        child: Icon(
          CupertinoIcons.music_albums,
          color: contains ? AppColors.accent : AppColors.textSecondary,
        ),
      ),
      title: Text(playlist.name),
      subtitle: Text('${playlist.songCount} songs'),
      trailing: contains
          ? const Icon(
              CupertinoIcons.checkmark_alt,
              color: AppColors.accent,
              size: 22,
            )
          : const Icon(
              CupertinoIcons.plus_circle,
              color: AppColors.textTertiary,
              size: 22,
            ),
    );
  }
}

class _CreatePlaylistForm extends StatefulWidget {
  const _CreatePlaylistForm({
    required this.onCancel,
    required this.onCreate,
  });

  final VoidCallback onCancel;
  final Future<void> Function(String name) onCreate;

  @override
  State<_CreatePlaylistForm> createState() => _CreatePlaylistFormState();
}

class _CreatePlaylistFormState extends State<_CreatePlaylistForm> {
  final _controller = TextEditingController();
  bool _submitting = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final name = _controller.text.trim();
    if (name.isEmpty || _submitting) return;
    setState(() => _submitting = true);
    await widget.onCreate(name);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.sm,
        AppSpacing.lg,
        AppSpacing.md,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              autofocus: true,
              enabled: !_submitting,
              style: Theme.of(context).textTheme.bodyLarge,
              decoration: InputDecoration(
                hintText: 'Playlist name',
                filled: true,
                fillColor: AppColors.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  borderSide: BorderSide.none,
                ),
              ),
              onSubmitted: (_) => _submit(),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          TextButton(onPressed: widget.onCancel, child: const Text('Cancel')),
          FilledButton(
            onPressed: _submitting ? null : _submit,
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.accent,
              foregroundColor: Colors.white,
            ),
            child: _submitting
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Text('Create'),
          ),
        ],
      ),
    );
  }
}
