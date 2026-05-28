import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ThemeState extends Equatable {
  const ThemeState({
    this.primary = const Color(0xFF1DB954),
    this.secondary = const Color(0xFF169C46),
    this.background = const Color(0xFF0A0A0B),
    this.surface = const Color(0xFF121214),
    this.onPrimary = Colors.white,
    this.artworkPath,
  });

  final Color primary;
  final Color secondary;
  final Color background;
  final Color surface;
  final Color onPrimary;
  final String? artworkPath;

  ThemeState copyWith({
    Color? primary,
    Color? secondary,
    Color? background,
    Color? surface,
    Color? onPrimary,
    String? artworkPath,
  }) {
    return ThemeState(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      background: background ?? this.background,
      surface: surface ?? this.surface,
      onPrimary: onPrimary ?? this.onPrimary,
      artworkPath: artworkPath ?? this.artworkPath,
    );
  }

  @override
  List<Object?> get props => [primary, secondary, background, surface, artworkPath];
}
