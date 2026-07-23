import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';

abstract final class AppTheme {
  static ThemeData get lightTheme => _buildTheme(Brightness.light);

  static ThemeData get darkTheme => _buildTheme(Brightness.dark);

  static ThemeData _buildTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final colorScheme = isDark ? _darkColorScheme : _lightColorScheme;
    final textTheme = AppTextStyles.textTheme(brightness);
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final card = isDark ? AppColors.darkCard : AppColors.lightCard;
    final field = isDark ? AppColors.darkField : AppColors.lightField;
    final border = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final divider = isDark ? AppColors.darkDivider : AppColors.lightDivider;
    final mutedText = isDark
        ? AppColors.darkTextSecondary
        : AppColors.lightTextSecondary;

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      textTheme: textTheme,
      scaffoldBackgroundColor: isDark
          ? AppColors.darkBackground
          : AppColors.lightBackground,

      actionIconTheme: ActionIconThemeData(
        backButtonIconBuilder: (BuildContext context) {
          return Icon(Icons.arrow_back_ios_new);
        },
      ),

      appBarTheme: AppBarTheme(
        centerTitle: false,
        elevation: 0,
        backgroundColor: surface,
        foregroundColor: colorScheme.onSurface,
        titleTextStyle: textTheme.titleMedium,
        iconTheme: IconThemeData(color: colorScheme.onSurface),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.r),
            bottomRight: Radius.circular(20.r),
          ),
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: surface,
        modalBackgroundColor: surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(18.r)),
        ),
      ),
      cardTheme: CardThemeData(
        color: card,
        elevation: isDark ? 0 : 1,
        margin: EdgeInsets.zero,
        shadowColor: AppColors.primary.withValues(alpha: 0.08),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
          side: BorderSide(color: border),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: field,
        selectedColor: AppColors.roleAccentSoft,
        disabledColor: isDark
            ? AppColors.darkDisabled
            : AppColors.lightDisabled,
        labelStyle: textTheme.labelMedium,
        secondaryLabelStyle: textTheme.labelMedium?.copyWith(
          color: AppColors.primary,
        ),
        side: BorderSide(color: border),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: surface,
        titleTextStyle: textTheme.titleLarge,
        contentTextStyle: textTheme.bodyMedium?.copyWith(color: mutedText),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      ),
      dividerTheme: DividerThemeData(color: divider, thickness: 1),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: Size(44.w, 44.h),
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.darkTextPrimary,
          disabledBackgroundColor: isDark
              ? AppColors.darkDisabled
              : AppColors.lightDisabled,
          disabledForegroundColor: isDark
              ? AppColors.darkTextMuted
              : AppColors.lightTextMuted,
          textStyle: textTheme.labelLarge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.roleAccent,
        foregroundColor: isDark
            ? AppColors.darkBackground
            : AppColors.lightSurface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      ),
      iconTheme: IconThemeData(color: colorScheme.onSurfaceVariant, size: 22.r),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: field,
        hintStyle: textTheme.bodyMedium?.copyWith(color: mutedText),
        labelStyle: textTheme.labelLarge?.copyWith(color: mutedText),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        border: _inputBorder(border),
        enabledBorder: _inputBorder(border),
        focusedBorder: _inputBorder(AppColors.primary),
        errorBorder: _inputBorder(colorScheme.error),
        focusedErrorBorder: _inputBorder(colorScheme.error),
        disabledBorder: _inputBorder(
          isDark ? AppColors.darkDisabled : AppColors.lightDisabled,
        ),
      ),
      listTileTheme: ListTileThemeData(
        iconColor: colorScheme.onSurfaceVariant,
        textColor: colorScheme.onSurface,
        titleTextStyle: textTheme.titleSmall,
        subtitleTextStyle: textTheme.bodySmall,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: surface,
        elevation: 0,
        indicatorColor: AppColors.roleAccentSoft,
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) => textTheme.labelMedium?.copyWith(
            color: states.contains(WidgetState.selected)
                ? AppColors.primary
                : mutedText,
          ),
        ),
        iconTheme: WidgetStateProperty.resolveWith(
          (states) => IconThemeData(
            color: states.contains(WidgetState.selected)
                ? AppColors.primary
                : mutedText,
            size: 22.r,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: Size(44.w, 44.h),
          foregroundColor: colorScheme.primary,
          textStyle: textTheme.labelLarge,
          side: BorderSide(color: border),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: isDark
            ? AppColors.lightSurfaceAlt
            : AppColors.darkSurface,
        contentTextStyle: textTheme.bodyMedium?.copyWith(
          color: isDark
              ? AppColors.lightTextPrimary
              : AppColors.darkTextPrimary,
        ),
        actionTextColor: AppColors.secondary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          minimumSize: Size(44.w, 44.h),
          foregroundColor: colorScheme.primary,
          textStyle: textTheme.labelLarge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
      ),
    );
  }

  static OutlineInputBorder _inputBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: BorderSide(color: color),
    );
  }

  static const ColorScheme _lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primary,
    onPrimary: AppColors.darkTextPrimary,
    primaryContainer: AppColors.primarySoft,
    onPrimaryContainer: AppColors.lightTextPrimary,
    secondary: AppColors.secondary,
    onSecondary: AppColors.lightTextPrimary,
    secondaryContainer: AppColors.secondarySoft,
    onSecondaryContainer: AppColors.lightTextPrimary,
    tertiary: AppColors.tertiary,
    onTertiary: AppColors.darkTextPrimary,
    tertiaryContainer: AppColors.tertiarySoft,
    onTertiaryContainer: AppColors.lightTextPrimary,
    error: AppColors.error,
    onError: AppColors.darkTextPrimary,
    errorContainer: AppColors.tertiarySoft,
    onErrorContainer: AppColors.lightTextPrimary,
    surface: AppColors.lightSurface,
    onSurface: AppColors.lightTextPrimary,
    surfaceContainerHighest: AppColors.lightSurfaceAlt,
    onSurfaceVariant: AppColors.lightTextSecondary,
    outline: AppColors.lightBorder,
    outlineVariant: AppColors.lightDivider,
    shadow: Color(0x1A0052FF),
    scrim: Color(0x9907111F),
    inverseSurface: AppColors.darkSurface,
    onInverseSurface: AppColors.darkTextPrimary,
    inversePrimary: AppColors.darkPrimary,
  );

  static const ColorScheme _darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.darkPrimary,
    onPrimary: AppColors.darkBackground,
    primaryContainer: Color(0xFF123B91),
    onPrimaryContainer: AppColors.darkTextPrimary,
    secondary: AppColors.darkSecondary,
    onSecondary: AppColors.darkBackground,
    secondaryContainer: Color(0xFF074B5E),
    onSecondaryContainer: AppColors.darkTextPrimary,
    tertiary: AppColors.darkTertiary,
    onTertiary: AppColors.darkBackground,
    tertiaryContainer: Color(0xFF5F1B0B),
    onTertiaryContainer: AppColors.darkTextPrimary,
    error: AppColors.darkError,
    onError: AppColors.darkBackground,
    errorContainer: Color(0xFF5F1712),
    onErrorContainer: AppColors.darkTextPrimary,
    surface: AppColors.darkSurface,
    onSurface: AppColors.darkTextPrimary,
    surfaceContainerHighest: AppColors.darkSurfaceAlt,
    onSurfaceVariant: AppColors.darkTextSecondary,
    outline: AppColors.darkBorder,
    outlineVariant: AppColors.darkDivider,
    shadow: Color(0x6607111F),
    scrim: Color(0xCC07111F),
    inverseSurface: AppColors.lightSurface,
    onInverseSurface: AppColors.lightTextPrimary,
    inversePrimary: AppColors.primary,
  );
}
