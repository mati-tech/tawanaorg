import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // K3: preload the Latin/Cyrillic (Inter) and Perso-Arabic (Noto Sans Arabic)
  // families before the first frame so neither the page nor the language menu
  // flashes fallback glyphs. A slow or offline font CDN must never block start-up.
  try {
    await GoogleFonts.pendingFonts([
      GoogleFonts.inter(),
      GoogleFonts.inter(fontWeight: FontWeight.w600),
      GoogleFonts.inter(fontWeight: FontWeight.w700),
      GoogleFonts.notoSansArabic(),
      GoogleFonts.notoSansArabic(fontWeight: FontWeight.w600),
      GoogleFonts.notoSansArabic(fontWeight: FontWeight.w700),
    ]).timeout(const Duration(seconds: 4));
  } catch (_) {
    // Fall through: the app still renders with fallback fonts.
  }

  // Restore the saved language before the first frame (no English flash on reload).
  String? savedLocale;
  try {
    final prefs = await SharedPreferences.getInstance();
    savedLocale = prefs.getString(LocaleNotifier.prefsKey);
  } catch (_) {
    savedLocale = null;
  }

  runApp(
    ProviderScope(
      overrides: [
        initialLocaleCodeProvider.overrideWithValue(savedLocale),
      ],
      child: const FoundationApp(),
    ),
  );
}
