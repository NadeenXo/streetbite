import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme => _build(Brightness.light);
  static ThemeData get darkTheme => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final dark = brightness == Brightness.dark;

    final background = dark ? AppColors.darkBackground : AppColors.cream;

    final foreground = dark ? AppColors.white : AppColors.charcoal;

    final surface = dark ? AppColors.darkSurface : AppColors.white;

    final scheme =
        ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: brightness,
          surface: background,
        ).copyWith(
          primary: AppColors.primary,
          onPrimary: AppColors.charcoal,
          surface: background,
          onSurface: foreground,
        );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: background,

      appBarTheme: AppBarTheme(
        backgroundColor: background,
        foregroundColor: foreground,
        centerTitle: false,
        elevation: 0,
        iconTheme: IconThemeData(color: foreground),
      ),

      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          minimumSize: const Size.fromHeight(48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          minimumSize: const Size.fromHeight(48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),

      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          return states.contains(WidgetState.selected) ? AppColors.white : null;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          return states.contains(WidgetState.selected)
              ? AppColors.primary
              : null;
        }),
      ),

      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(foregroundColor: foreground),
      ),

      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.charcoal,
      ),

      snackBarTheme: SnackBarThemeData(
        backgroundColor: dark ? AppColors.primary : AppColors.charcoal,
        contentTextStyle: TextStyle(
          color: dark ? AppColors.charcoal : AppColors.white,
        ),
        behavior: SnackBarBehavior.floating,
      ),

      dividerColor: dark ? AppColors.darkSurface : AppColors.lightGray,
    );
  }
}
