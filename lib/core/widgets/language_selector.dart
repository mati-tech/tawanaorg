import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../app/app.dart';
import '../../l10n/app_localizations.dart';

class LanguageSelector extends ConsumerWidget {
  const LanguageSelector({super.key});

  static const _languages = <String, String>{
    'en': 'English',
    'ru': 'Русский',
    'fa': 'دری',
    'ps': 'پښتو',
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final current = ref.watch(localeProvider).languageCode;
    return PopupMenuButton<String>(
      tooltip: AppLocalizations.of(context)!.language,
      icon: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.language, size: 20),
          const SizedBox(width: 6),
          Text(_languages[current] ?? 'English'),
        ],
      ),
      onSelected: (code) => ref.read(localeProvider.notifier).set(Locale(code)),
      itemBuilder: (context) => _languages.entries
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
              Text(e.value),
            ],
          ),
        ),
      )
          .toList(),
    );
  }
}