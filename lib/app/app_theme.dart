import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';

/// Complete theme configuration matching the Knotnex purple brand design system.
class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.background,
      fontFamily: 'Google Sans',
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.primary,
        onPrimary: AppColors.textOnPrimary,
        primaryContainer: AppColors.primaryLight,
        onPrimaryContainer: AppColors.primary,
        secondary: AppColors.primaryVariant,
        onSecondary: AppColors.textOnPrimary,
        secondaryContainer: AppColors.primarySurface,
        onSecondaryContainer: AppColors.primary,
        tertiary: AppColors.info,
        onTertiary: AppColors.textOnPrimary,
        error: AppColors.error,
        onError: AppColors.textOnPrimary,
        errorContainer: AppColors.errorSurface,
        onErrorContainer: AppColors.error,
        surface: AppColors.surface,
        onSurface: AppColors.textPrimary,
        outline: AppColors.border,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 0,
        centerTitle: false,
        titleSpacing: 0,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.white,
          letterSpacing: 0.2,
        ),
        iconTheme: IconThemeData(
          color: AppColors.white,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 1.5,
        shadowColor: AppColors.primary.withValues(alpha: 0.08),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(
            color: Color(0xFFECE7FF),
            width: 1,
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: AppColors.white,
          backgroundColor: AppColors.primary,
          disabledForegroundColor: AppColors.textHint,
          disabledBackgroundColor: AppColors.primaryLight,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          textStyle: AppTextStyles.button,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          textStyle: AppTextStyles.button.copyWith(color: AppColors.primary),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          textStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: AppColors.inputFill,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        hintStyle: const TextStyle(
          color: AppColors.textHint,
          fontSize: 15,
        ),
        prefixIconColor: AppColors.inputIconColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.inputBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.inputBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.error,
            width: 2,
          ),
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary;
          }
          return null;
        }),
        checkColor: WidgetStateProperty.all(AppColors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        side: const BorderSide(color: AppColors.inputBorder, width: 1.5),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primary,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.textPrimary,
        contentTextStyle: const TextStyle(color: AppColors.white),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.primaryLight,
        labelStyle: AppTextStyles.badge,
        side: BorderSide.none,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      ),
    );
  }
}
