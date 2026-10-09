import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTypography {
  static TextTheme textTheme({required bool rtl}) {
    final base = rtl ? GoogleFonts.notoSansArabicTextTheme() : GoogleFonts.interTextTheme();
    return base.copyWith(
      displayLarge: (base.displayLarge ?? const TextStyle()).copyWith(
        fontSize: 48,
        fontWeight: FontWeight.w700,
        height: 1.1,
        color: AppColors.textPrimary,
      ),
      headlineLarge: (base.headlineLarge ?? const TextStyle()).copyWith(
        fontSize: 36,
        fontWeight: FontWeight.w700,
        height: 1.2,
        color: AppColors.textPrimary,
      ),
      headlineMedium: (base.headlineMedium ?? const TextStyle()).copyWith(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        height: 1.3,
        color: AppColors.textPrimary,
      ),
      titleLarge: (base.titleLarge ?? const TextStyle()).copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      bodyLarge: (base.bodyLarge ?? const TextStyle()).copyWith(
        fontSize: 16,
        height: 1.6,
        color: AppColors.textPrimary,
      ),
      bodyMedium: (base.bodyMedium ?? const TextStyle()).copyWith(
        fontSize: 15,
        height: 1.6,
        color: AppColors.textSecondary,
      ),
      bodySmall: (base.bodySmall ?? const TextStyle()).copyWith(
        fontSize: 13,
        color: AppColors.textSecondary,
      ),
      labelLarge: (base.labelLarge ?? const TextStyle()).copyWith(
        fontSize: 15,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}