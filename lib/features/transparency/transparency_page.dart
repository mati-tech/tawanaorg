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

class TransparencyPage extends ConsumerWidget {
  const TransparencyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final reports = ref.watch(reportsProvider);

    return Scaffold(
      appBar: const AppHeader(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: AppColors.primaryLight,
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxl),
              child: ResponsiveContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l10n.transparencyTitle,
                        style: Theme.of(context).textTheme.displayLarge),
                    const SizedBox(height: AppSpacing.md),
                    Text(l10n.transparencySubtitle,
                        style: Theme.of(context).textTheme.bodyLarge),
                  ],
                ),
              ),
            ),
            ResponsiveContainer(
              padding: EdgeInsets.symmetric(
                horizontal: context.hPad,
                vertical: AppSpacing.section,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionHeader(title: l10n.transparencyFinancial),
                  Text(
                    l10n.transparencyFinancialText,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: AppSpacing.section),
                  SectionHeader(title: l10n.transparencyReports),
                  reports.when(
                    data: (list) => Column(
                      children: list.map((r) {
                        final title = r['title'] as String? ?? '';
                        final size = r['size'] as String? ?? '';
                        final download = TextButton.icon(
                          // The PDFs are not in assets/reports yet and the
                          // app has no URL-opening package, so tell the user
                          // instead of silently doing nothing.
                          onPressed: () => ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                              SnackBar(content: Text(l10n.reportUnavailable)),
                            ),
                          icon: const Icon(Icons.download, size: 18),
                          label: Text(l10n.downloadPdf),
                        );
                        return Padding(
                          padding:
                              const EdgeInsets.only(bottom: AppSpacing.sm),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: AppSpacing.md,
                                  vertical: AppSpacing.sm),
                              // Wrap: the button drops below the title on
                              // narrow phones instead of squeezing it.
                              child: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                alignment: WrapAlignment.spaceBetween,
                                spacing: AppSpacing.md,
                                runSpacing: AppSpacing.xs,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.picture_as_pdf,
                                          color: AppColors.primary),
                                      const SizedBox(width: AppSpacing.md),
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(title,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium),
                                            if (size.isNotEmpty)
                                              Text(size,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  download,
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    loading: () => const SizedBox.shrink(),
                    error: (_, __) => Text(l10n.error),
                  ),
                  const SizedBox(height: AppSpacing.section),
                  SectionHeader(title: l10n.transparencyGovernance),
                  Text(
                    l10n.transparencyGovernanceText,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
            const AppFooter(),
          ],
        ),
      ),
    );
  }
}