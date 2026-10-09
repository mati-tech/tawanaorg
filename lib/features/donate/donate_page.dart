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

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
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
                  _block(context, l10n.donateWhy,
                      'Your gift provides education, healthcare and emergency relief to families who need it most.'),
                  _block(context, l10n.donateWhere,
                      '87% of every donation goes directly to programs. 8% covers operations, 5% fundraising.'),
                  _block(context, l10n.donateOptions,
                      'One-time gifts · Monthly giving · In-kind donations · Corporate matching.'),
                  _block(context, l10n.donateBank,
                      'Bank: Example Bank\nAccount: Hope Foundation\nIBAN: XX00 0000 0000 0000 0000\nSWIFT: XXXX XXXX\nReference: Donation'),
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
                  _faq(context, 'Is my donation tax-deductible?',
                      'Yes, in jurisdictions where the foundation is registered. Contact us for details.'),
                  _faq(context, 'Can I cancel a monthly gift?',
                      'Yes, at any time. Just contact our office.'),
                  _faq(context, 'How do I know my donation is used well?',
                      'See our Transparency page for full financial reports.'),
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
    return Card(
      child: ListTile(
        title: Text(q),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(a),
        ),
      ),
    );
  }
}