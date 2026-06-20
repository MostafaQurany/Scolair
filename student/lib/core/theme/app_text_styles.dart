import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

abstract final class AppTextStyles {
  static TextTheme textTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final textColor = isDark
        ? AppColors.darkTextPrimary
        : AppColors.lightTextPrimary;
    final mutedColor = isDark
        ? AppColors.darkTextSecondary
        : AppColors.lightTextSecondary;
    final baseTheme = isDark ? ThemeData.dark() : ThemeData.light();
    final hankenTheme = GoogleFonts.dmSansTextTheme(baseTheme.textTheme);

    return hankenTheme.copyWith(
      displaySmall: _style(
        size: 34,
        weight: FontWeight.w800,
        color: textColor,
        height: 1.08,
      ),
      headlineSmall: _style(
        size: 26,
        weight: FontWeight.w800,
        color: textColor,
        height: 1.12,
      ),
      titleLarge: _style(
        size: 22,
        weight: FontWeight.w700,
        color: textColor,
        height: 1.16,
      ),
      titleMedium: _style(
        size: 18,
        weight: FontWeight.w700,
        color: textColor,
        height: 1.22,
      ),
      titleSmall: _style(
        size: 16,
        weight: FontWeight.w700,
        color: textColor,
        height: 1.25,
      ),
      bodyLarge: _style(
        size: 16,
        weight: FontWeight.w500,
        color: textColor,
        height: 1.45,
      ),
      bodyMedium: _style(
        size: 14,
        weight: FontWeight.w500,
        color: textColor,
        height: 1.42,
      ),
      bodySmall: _style(
        size: 12,
        weight: FontWeight.w500,
        color: mutedColor,
        height: 1.35,
      ),
      labelLarge: _style(
        size: 14,
        weight: FontWeight.w700,
        color: textColor,
        height: 1.2,
      ),
      labelMedium: _style(
        size: 12,
        weight: FontWeight.w700,
        color: mutedColor,
        height: 1.2,
      ),
      labelSmall: _style(
        size: 11,
        weight: FontWeight.w700,
        color: mutedColor,
        height: 1.18,
      ),
    );
  }

  static TextStyle get titleLarge => _style(
    size: 22,
    weight: FontWeight.w700,
    color: AppColors.lightTextPrimary,
    height: 1.16,
  );

  static TextStyle get titleMedium => _style(
    size: 18,
    weight: FontWeight.w700,
    color: AppColors.lightTextPrimary,
    height: 1.22,
  );

  static TextStyle get body => _style(
    size: 14,
    weight: FontWeight.w500,
    color: AppColors.lightTextPrimary,
    height: 1.42,
  );

  static TextStyle get caption => _style(
    size: 12,
    weight: FontWeight.w500,
    color: AppColors.lightTextSecondary,
    height: 1.35,
  );

  static TextStyle _style({
    required double size,
    required FontWeight weight,
    required Color color,
    required double height,
  }) {
    return GoogleFonts.dmSans(
      fontSize: size.sp,
      fontWeight: weight,
      color: color,
      height: height,
    );
  }
}
