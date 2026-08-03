import 'package:flutter/material.dart';

abstract final class AppColors {
  static const Color primary = Color(0xFF0052FF);
  static const Color secondary = Color(0xFF00E5FF);
  static const Color tertiary = Color(0xFFBF3003);
  static const Color neutral = Color(0xFF757682);

  static const Color primaryPressed = Color(0xFF003CBF);
  static const Color primarySoft = Color(0xFFEAF0FF);
  static const Color secondarySoft = Color(0xFFE6FBFF);
  static const Color tertiarySoft = Color(0xFFFFEEE8);
  static const Color neutralSoft = Color(0xFFEFF2FA);

  static const Color lightBackground = Color(0xFFF4F6FC);
  static const Color lightSurface = Color(0xFFFBFCFF);
  static const Color lightSurfaceAlt = Color(0xFFEFF2FB);
  static const Color lightCard = Color(0xFFF7F9FF);
  static const Color lightField = Color(0xFFF1F4FC);
  static const Color lightDivider = Color(0xFFE1E7F2);
  static const Color lightBorder = Color(0xFFD8E0EE);
  static const Color lightTextPrimary = Color(0xFF121827);
  static const Color lightTextSecondary = Color(0xFF5C6475);
  static const Color lightTextMuted = Color(0xFF7E8697);
  static const Color lightDisabled = Color(0xFFB9C0CD);

  static const Color darkBackground = Color(0xFF07111F);
  static const Color darkSurface = Color(0xFF101B2D);
  static const Color darkSurfaceAlt = Color(0xFF17243A);
  static const Color darkCard = Color(0xFF132036);
  static const Color darkField = Color(0xFF1B2A44);
  static const Color darkDivider = Color(0xFF263653);
  static const Color darkBorder = Color(0xFF2E3D5C);
  static const Color darkTextPrimary = Color(0xFFF2F6FF);
  static const Color darkTextSecondary = Color(0xFFAAB6CC);
  static const Color darkTextMuted = Color(0xFF8390A7);
  static const Color darkDisabled = Color(0xFF536076);
  static const Color darkPrimary = Color(0xFF6F96FF);
  static const Color darkSecondary = Color(0xFF42EAFF);
  static const Color darkTertiary = Color(0xFFFF744F);

  static const Color success = Color(0xFF0E9F6E);
  static const Color warning = Color(0xFFE6A700);
  static const Color error = Color(0xFFD92D20);
  static const Color info = primary;

  static const Color darkSuccess = Color(0xFF4ED7A4);
  static const Color darkWarning = Color(0xFFFFCF4A);
  static const Color darkError = Color(0xFFFF7B72);
  static const Color darkInfo = darkPrimary;

  static const Color roleAccent = primary;
  static const Color roleAccentSoft = primarySoft;

  static const Color background = lightBackground;
  static const Color surface = lightSurface;
  static const Color cardBackground = lightCard;
  static const Color accent = secondary;
  static const Color textPrimary = lightTextPrimary;
  static const Color textSecondary = lightTextSecondary;
  static const Color textMuted = lightTextMuted;
  static const Color textTertiary = lightTextMuted;
  static const Color iconPrimary = lightTextPrimary;
  static const Color disabled = lightDisabled;
  static const Color border = lightBorder;
  static const Color danger = error;
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color transparent = Color(0x00000000);
}
