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
    final l10n = AppLocalizations.of(context)!;
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
                    '${l10n.transparencyFinancial}: 87% of funds go directly to programs, 8% to operations, 5% to fundraising. '
                        'Full details are available in the annual reports below.',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: AppSpacing.section),
                  SectionHeader(title: l10n.transparencyReports),
                  reports.when(
                    data: (list) => Column(
                      children: list.map((r) {
                        return Card(
                          child: ListTile(
                            leading: const Icon(Icons.picture_as_pdf,
                                color: AppColors.primary),
                            title: Text(r['title'] as String),
                            subtitle: Text(r['size'] as String? ?? ''),
                            trailing: TextButton(
                              onPressed: () {},
                              child: Text(l10n.downloadPdf),
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
                    'Registered as a non-profit organization. Governance is provided '
                        'by an independent board. Policies available on request.',
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