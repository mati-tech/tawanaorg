import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Locale-aware formatting so dates and numbers follow the selected language
/// (e.g. Persian/Pashto digits and month names in `fa` / `ps`).
extension LocaleFormatting on BuildContext {
  String get _localeTag => Localizations.localeOf(this).toLanguageTag();

  /// Medium date, e.g. "Feb 10, 2025" / "10 февр. 2025 г." / Persian digits.
  String formatDate(DateTime date) =>
      MaterialLocalizations.of(this).formatMediumDate(date);

  /// Parses an ISO `yyyy-MM-dd` string; returns it unchanged if unparsable.
  String formatIsoDate(String iso) {
    final parsed = DateTime.tryParse(iso);
    return parsed == null ? iso : formatDate(parsed);
  }

  /// Grouped integer, e.g. 1,200 / 1 200 / ۱٬۲۰۰.
  String formatNumber(num value) =>
      _withFallback((tag) => NumberFormat.decimalPattern(tag), value);

  /// Fraction 0..1 as a percentage, e.g. 65% / ۶۵٪.
  String formatPercent(double fraction) =>
      _withFallback((tag) => NumberFormat.percentPattern(tag), fraction);

  // Never let a missing intl symbol table break a page.
  String _withFallback(NumberFormat Function(String tag) build, num value) {
    try {
      return build(_localeTag).format(value);
    } catch (_) {
      return build('en').format(value);
    }
  }
}
