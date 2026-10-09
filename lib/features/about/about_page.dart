import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_spacing.dart';
import '../../core/responsive/responsive.dart';
import '../../core/widgets/app_footer.dart';
import '../../core/widgets/app_header.dart';
import '../../core/widgets/responsive_container.dart';
import '../../core/widgets/section_header.dart';
import '../../data/providers.dart';
import '../../l10n/app_localizations.dart';

class AboutPage extends ConsumerWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final about = ref.watch(aboutProvider);

    return Scaffold(
      appBar: const AppHeader(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _PageHeader(title: l10n.aboutTitle, subtitle: l10n.aboutSubtitle),
            about.when(
              data: (a) => Column(
                children: [
                  _TextBlock(
                    title: l10n.aboutHistoryTitle,
                    text: a['history'] as String? ?? '',
                  ),
                  _TextBlock(
                    title: l10n.ourMission,
                    text: a['mission'] as String? ?? '',
                    shaded: true,
                  ),
                  _TextBlock(
                    title: l10n.ourVision,
                    text: a['vision'] as String? ?? '',
                  ),
                  _TextBlock(
                    title: l10n.ourValues,
                    text: a['values'] as String? ?? '',
                    shaded: true,
                  ),
                  _TextBlock(
                    title: l10n.aboutCountriesTitle,
                    text: a['countries'] as String? ?? '',
                  ),
                  _Timeline(items: (a['timeline'] as List).cast()),
                ],
              ),
              loading: () => const Padding(
                padding: EdgeInsets.all(AppSpacing.xxl),
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (_, __) => Padding(
                padding: const EdgeInsets.all(AppSpacing.xxl),
                child: Text(l10n.error),
              ),
            ),
            const AppFooter(),
          ],
        ),
      ),
    );
  }
}

class _PageHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  const _PageHeader({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryLight,
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxl),
      child: ResponsiveContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.displayLarge),
            const SizedBox(height: AppSpacing.md),
            Text(subtitle, style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }
}

class _TextBlock extends StatelessWidget {
  final String title;
  final String text;
  final bool shaded;
  const _TextBlock({required this.title, required this.text, this.shaded = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: shaded ? AppColors.surface : Colors.transparent,
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xl),
      child: ResponsiveContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(title: title),
            Text(text, style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }
}

class _Timeline extends StatelessWidget {
  final List items;
  const _Timeline({required this.items});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      color: AppColors.surface,
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.section),
      child: ResponsiveContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(title: l10n.ourTimeline),
            ...items.map((raw) {
              final item = (raw as Map).cast<String, dynamic>();
              return Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.lg),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 60,
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        item['year'] as String,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item['title'] as String,
                              style: Theme.of(context).textTheme.titleLarge),
                          const SizedBox(height: 4),
                          Text(item['text'] as String,
                              style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}