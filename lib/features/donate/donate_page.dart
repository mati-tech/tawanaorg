import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_spacing.dart';
import '../../core/responsive/responsive.dart';
import '../../core/widgets/app_footer.dart';
import '../../core/widgets/app_header.dart';
import '../../core/widgets/responsive_container.dart';
import '../../core/widgets/section_header.dart';
import '../../l10n/app_localizations.dart';

class DonatePage extends StatelessWidget {
  const DonatePage({super.key});

  static const _bankName = 'Example Bank';
  static const _iban = 'XX00 0000 0000 0000 0000';
  static const _swift = 'XXXX XXXX';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
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
                    Text(l10n.donateTitle,
                        style: Theme.of(context).textTheme.displayLarge),
                    const SizedBox(height: AppSpacing.md),
                    Text(l10n.donateSubtitle,
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
                  _block(context, l10n.donateWhy, l10n.donateWhyText),
                  _block(context, l10n.donateWhere, l10n.donateWhereText),
                  _block(context, l10n.donateOptions, l10n.donateOptionsText),
                  _block(
                    context,
                    l10n.donateBank,
                    // TODO(product): placeholder bank details — replace with
                    // the foundation's real account before launch.
                    '${l10n.donateBankLabel}: $_bankName\n'
                    '${l10n.donateAccountLabel}: ${l10n.appName}\n'
                    'IBAN: $_iban\n'
                    'SWIFT: $_swift\n'
                    '${l10n.donateReferenceLabel}: ${l10n.donateReferenceValue}',
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF8E1),
                      borderRadius:
                      BorderRadius.circular(AppSpacing.radius),
                      border: Border.all(color: const Color(0xFFFFE082)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.info_outline,
                            color: AppColors.warning),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: Text(l10n.donateFutureNote,
                              style: Theme.of(context).textTheme.bodyMedium),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.section),
                  SectionHeader(title: l10n.donateFAQ),
                  _faq(context, l10n.donateFaq1Q, l10n.donateFaq1A),
                  _faq(context, l10n.donateFaq2Q, l10n.donateFaq2A),
                  _faq(context, l10n.donateFaq3Q, l10n.donateFaq3A),
                ],
              ),
            ),
            const AppFooter(),
          ],
        ),
      ),
    );
  }

  Widget _block(BuildContext context, String title, String body) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: AppSpacing.sm),
          Text(body, style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }

  Widget _faq(BuildContext context, String q, String a) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Card(
      child: ListTile(
        title: Text(q),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(a),
        ),
      ),
    ),
    );
  }
}