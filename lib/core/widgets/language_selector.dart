import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../app/app.dart';
import '../../app/theme/app_colors.dart';
import '../../l10n/app_localizations.dart';

class LanguageSelector extends ConsumerWidget {
  /// K2: when true, renders the languages as a tappable list (used inside the
  /// mobile language sheet) instead of a popup menu button.
  final bool forceList;

  /// Called after a language is picked from the list (e.g. to close a sheet).
  final VoidCallback? onSelected;

  const LanguageSelector({super.key, this.forceList = false, this.onSelected});

  static const languages = <String, String>{
    'en': 'English',
    'ru': 'Русский',
    'fa': 'دری',
    'ps': 'پښتو',
  };

  /// Each language name is rendered in its own script direction so that
  /// "English" stays LTR inside an RTL menu and vice versa.
  static TextDirection _directionOf(String code) =>
      rtlLanguageCodes.contains(code) ? TextDirection.rtl : TextDirection.ltr;

  /// K3: each name uses the (preloaded) font that covers its script, so
  /// "دری"/"پښتو" never fall back to a late-loading system font in LTR UIs.
  static TextStyle _styleOf(String code) => rtlLanguageCodes.contains(code)
      ? GoogleFonts.notoSansArabic()
      : GoogleFonts.inter();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final current = ref.watch(localeProvider).languageCode;

    void select(String code) {
      ref.read(localeProvider.notifier).set(Locale(code));
      onSelected?.call();
    }

    if (forceList) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: languages.entries
            .map(
              (e) => ListTile(
                selected: e.key == current,
                selectedColor: AppColors.primary,
                leading: Icon(
                  e.key == current ? Icons.check : Icons.language,
                  size: 20,
                ),
                title: Text(
                  e.value,
                  textDirection: _directionOf(e.key),
                  locale: Locale(e.key),
                  style: _styleOf(e.key),
                ),
                onTap: () => select(e.key),
              ),
            )
            .toList(),
      );
    }

    return PopupMenuButton<String>(
      tooltip: l10n.language,
      // K3: no open animation, so the menu never paints with fallback glyphs.
      popUpAnimationStyle: AnimationStyle.noAnimation,
      initialValue: current,
      onSelected: select,
      itemBuilder: (context) => languages.entries
          .map(
            (e) => PopupMenuItem<String>(
              value: e.key,
              child: Row(
                children: [
                  if (e.key == current)
                    const Icon(Icons.check, size: 16)
                  else
                    const SizedBox(width: 16),
                  const SizedBox(width: 8),
                  Text(
                    e.value,
                    textDirection: _directionOf(e.key),
                    locale: Locale(e.key),
                    style: _styleOf(e.key),
                  ),
                ],
              ),
            ),
          )
          .toList(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.language, size: 20),
            const SizedBox(width: 6),
            Text(
              languages[current] ?? languages['en']!,
              style: _styleOf(current),
            ),
            const Icon(Icons.arrow_drop_down, size: 20),
          ],
        ),
      ),
    );
  }
}
