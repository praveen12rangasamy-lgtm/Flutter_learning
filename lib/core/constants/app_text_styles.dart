import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static const String primaryFont = 'Google Sans';
  static const String displayFont = 'Scaver';

  static const TextStyle displayLarge = TextStyle(
    fontFamily: primaryFont,
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: -0.3,
  );

  /// Serif display style matching the onboarding headline "Empowering Every Ability"
  static const TextStyle brandDisplay = TextStyle(
    fontFamily: displayFont,
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: Colors.white,
    letterSpacing: -0.5,
  );

  static const TextStyle heading1 = TextStyle(
    fontFamily: primaryFont,
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: -0.2,
  );

  static const TextStyle heading2 = TextStyle(
    fontFamily: primaryFont,
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static const TextStyle titleMedium = TextStyle(
    fontFamily: primaryFont,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle body = TextStyle(
    fontFamily: primaryFont,
    fontSize: 16,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: primaryFont,
    fontSize: 14,
    color: AppColors.textSecondary,
    height: 1.4,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: primaryFont,
    fontSize: 12,
    color: AppColors.textSecondary,
  );

  static const TextStyle button = TextStyle(
    fontFamily: primaryFont,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
    letterSpacing: 0.2,
  );

  static const TextStyle badge = TextStyle(
    fontFamily: primaryFont,
    fontSize: 13,
    fontWeight: FontWeight.w700,
    color: AppColors.primary,
  );
}
