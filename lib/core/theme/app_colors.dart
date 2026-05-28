import 'package:flutter/material.dart';

abstract final class AppColors {
  static const Color scaffold = Color(0xFF0A0A0B);
  static const Color surface = Color(0xFF121214);
  static const Color surfaceElevated = Color(0xFF1A1A1E);
  static const Color surfaceGlass = Color(0xCC1A1A1E);
  static const Color border = Color(0xFF2A2A30);
  static const Color textPrimary = Color(0xFFF5F5F7);
  static const Color textSecondary = Color(0xFF9A9AA3);
  static const Color textTertiary = Color(0xFF6B6B73);
  static const Color accent = Color(0xFF1DB954);
  static const Color accentMuted = Color(0xFF169C46);
  static const Color error = Color(0xFFE91429);
  static const Color overlay = Color(0x99000000);

  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF1A1A22), Color(0xFF0A0A0B)],
  );

  static const LinearGradient edgeGlow = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0x33FFFFFF), Color(0x00FFFFFF)],
  );
}
