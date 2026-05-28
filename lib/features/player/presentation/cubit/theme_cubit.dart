import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:palette_generator/palette_generator.dart';

import '../../../../core/theme/app_colors.dart';
import 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeState());

  final OnAudioQuery _audioQuery = OnAudioQuery();
  String? _lastArtworkKey;

  Future<void> extractFromSong(int songId, {String? artworkPath}) async {
    final key = '$songId-$artworkPath';
    if (key == _lastArtworkKey) return;
    _lastArtworkKey = key;

    try {
      PaletteGenerator? palette;
      if (artworkPath != null && File(artworkPath).existsSync()) {
        palette = await PaletteGenerator.fromImageProvider(
          FileImage(File(artworkPath)),
          maximumColorCount: 8,
        );
      } else {
        final bytes = await _audioQuery.queryArtwork(
          songId,
          ArtworkType.AUDIO,
          format: ArtworkFormat.JPEG,
          size: 200,
        );
        if (bytes != null) {
          palette = await PaletteGenerator.fromImageProvider(
            MemoryImage(Uint8List.fromList(bytes)),
            maximumColorCount: 8,
          );
        }
      }

      if (palette == null || isClosed) return;

      final dominant = palette.dominantColor?.color ?? AppColors.accent;
      final vibrant = palette.vibrantColor?.color ?? dominant;
      final dark = palette.darkMutedColor?.color ?? AppColors.scaffold;
      final muted = palette.mutedColor?.color ?? AppColors.surface;

      emit(ThemeState(
        primary: dominant,
        secondary: vibrant,
        background: Color.lerp(dark, Colors.black, 0.65)!,
        surface: Color.lerp(muted, Colors.black, 0.5)!,
        artworkPath: artworkPath,
      ));
    } catch (_) {
      if (!isClosed) emit(const ThemeState());
    }
  }

  void reset() {
    _lastArtworkKey = null;
    emit(const ThemeState());
  }
}
