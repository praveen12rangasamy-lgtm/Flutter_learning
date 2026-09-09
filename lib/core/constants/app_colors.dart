import 'package:flutter/material.dart';

/// Brand color palette matching the Knotnex purple design system.
class AppColors {
  AppColors._();

  // Brand Primary
  /// Main vibrant purple
  static const Color primary = Color(0xFF6336EB);

  /// Deeper purple variant
  static const Color primaryVariant = Color(0xFF4F27C8);

  /// Light purple tint
  static const Color primaryLight = Color(0xFFEFEBFD);

  /// Medium purple
  static const Color primaryMuted = Color(0xFFCFC1F9);

  /// Soft primary surface background tint
  static const Color primarySurface = Color(0xFFF5F3FF);

  // Dark Theme Brand Palette
  static const Color darkPrimary = Color(0xFF9E7AFF);
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);

  // Neutrals
  static const Color white = Color(0xFFFCFCFC);
  static const Color pureWhite = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color background = Color(0xFFF8F7FC);
  static const Color surface = Color(0xFFFFFFFF);

  // Text
  static const Color textPrimary = Color(0xFF1A1A2E);
  static const Color textSecondary = Color(0xFF4B5563);
  static const Color textHint = Color(0xFF9CA3AF);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // Border & Divider
  static const Color border = Color(0xFFE5E7EB);
  static const Color divider = Color(0xFFE5E7EB);

  // Status
  static const Color success = Color(0xFF16A34A);
  static const Color successSurface = Color(0xFFDCFCE7);
  static const Color error = Color(0xFFDC2626);
  static const Color errorSurface = Color(0xFFFEE2E2);
  static const Color warning = Color(0xFFD97706);
  static const Color info = Color(0xFF2563EB);

  // Inputs
  static const Color inputFill = Color(0xFFF5F3FF);
  static const Color inputBorder = Color(0xFFCDC7E5);
  static const Color inputFocusBorder = Color(0xFF6336EB);
  static const Color inputIconColor = Color(0xFF8B6EF5);
}
