import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/responsive/responsive.dart';
import '../l10n/app_localizations.dart';
import 'router.dart';
import 'theme/app_theme.dart';

/// Language code restored from storage in `main()` before the first frame.
/// Overridden in the root [ProviderScope]; `null` means "use the default".
final initialLocaleCodeProvider = Provider<String?>((ref) => null);

final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>(
  (ref) => LocaleNotifier(ref.watch(initialLocaleCodeProvider)),
);

/// Languages rendered right-to-left.
const rtlLanguageCodes = {'fa', 'ps'};

class LocaleNotifier extends StateNotifier<Locale> {
  LocaleNotifier(String? initialCode) : super(_resolve(initialCode));

  static const prefsKey = 'locale';

  static Locale _resolve(String? code) {
    final supported = AppLocalizations.supportedLocales
        .any((l) => l.languageCode == code);
    return supported ? Locale(code!) : const Locale('en');
  }

  Future<void> set(Locale locale) async {
    if (locale == state) return;
    state = _resolve(locale.languageCode);
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(prefsKey, state.languageCode);
    } catch (_) {
      // Persistence is best-effort (e.g. storage blocked in private mode).
    }
  }
}

class FoundationApp extends ConsumerWidget {
  const FoundationApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);
    final isRtl = rtlLanguageCodes.contains(locale.languageCode);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (ctx) => AppLocalizations.of(ctx).appName,
      theme: AppTheme.light(rtl: isRtl),
      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: ref.watch(routerProvider),
      // K7: make all page text selectable. SelectionArea needs an Overlay
      // ancestor for its handles/context menu, and the builder sits above the
      // router's Navigator, so it gets its own Overlay.
      builder: (context, child) {
        // 48 px page titles break single words mid-word on 280–599 px
        // phones (e.g. "Прозрачность"); scale the two largest styles down
        // there only. Tablet/desktop typography is unchanged. The Theme is
        // always present so resizing across 600 px keeps the same tree.
        final theme = Theme.of(context);
        final t = theme.textTheme;
        final phone = MediaQuery.sizeOf(context).width < Breakpoints.mobile;
        return Theme(
          data: phone
              ? theme.copyWith(
                  textTheme: t.copyWith(
                    displayLarge: t.displayLarge?.copyWith(fontSize: 34),
                    headlineLarge: t.headlineLarge?.copyWith(fontSize: 28),
                  ),
                )
              : theme,
          child: _SelectableShell(child: child ?? const SizedBox.shrink()),
        );
      },
    );
  }
}

class _SelectableShell extends StatefulWidget {
  final Widget child;
  const _SelectableShell({required this.child});

  @override
  State<_SelectableShell> createState() => _SelectableShellState();
}

class _SelectableShellState extends State<_SelectableShell> {
  late final OverlayEntry _entry = OverlayEntry(
    builder: (_) => SelectionArea(child: widget.child),
  );

  @override
  void didUpdateWidget(covariant _SelectableShell oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Overlay only reads initialEntries once; rebuild the entry so the latest
    // child (e.g. after a locale change) is used.
    if (oldWidget.child != widget.child) _entry.markNeedsBuild();
  }

  @override
  Widget build(BuildContext context) {
    return Overlay(initialEntries: [_entry]);
  }
}
