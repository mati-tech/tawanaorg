import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_spacing.dart';
import '../../core/responsive/responsive.dart';
import '../../core/widgets/app_footer.dart';
import '../../core/widgets/app_header.dart';
import '../../core/widgets/responsive_container.dart';
import '../../l10n/app_localizations.dart';

class GetInvolvedPage extends StatelessWidget {
  const GetInvolvedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cards = [
      _Involved(l10n.involvedVolunteer, l10n.involvedVolunteerText,
          Icons.volunteer_activism),
      _Involved(l10n.involvedPartner, l10n.involvedPartnerText, Icons.handshake),
      _Involved(l10n.involvedFundraise, l10n.involvedFundraiseText,
          Icons.campaign),
      _Involved(l10n.involvedCorporate, l10n.involvedCorporateText,
          Icons.business_center),
      _Involved(l10n.involvedAmbassador, l10n.involvedAmbassadorText,
          Icons.public),
      _Involved(l10n.donate, l10n.homeCTA_Text, Icons.favorite),
    ];

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
                    Text(l10n.involvedTitle,
                        style: Theme.of(context).textTheme.displayLarge),
                    const SizedBox(height: AppSpacing.md),
                    Text(l10n.involvedSubtitle,
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
              child: LayoutBuilder(builder: (context, _) {
                final cols = context.gridCols(mobile: 1, tablet: 2, desktop: 3);
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: cards.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: cols,
                    crossAxisSpacing: AppSpacing.md,
                    mainAxisSpacing: AppSpacing.md,
                    childAspectRatio: 1.1,
                  ),
                  itemBuilder: (_, i) {
                    final c = cards[i];
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.lg),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(c.icon, color: AppColors.primary, size: 30),
                            const SizedBox(height: AppSpacing.md),
                            Text(c.title,
                                style:
                                Theme.of(context).textTheme.titleLarge),
                            const SizedBox(height: AppSpacing.sm),
                            Expanded(
                              child: Text(c.text,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium),
                            ),
                            const SizedBox(height: AppSpacing.md),
                            FilledButton(
                              onPressed: () => context.go('/contact'),
                              child: Text(l10n.navContact),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
            const AppFooter(),
          ],
        ),
      ),
    );
  }
}

class _Involved {
  final String title;
  final String text;
  final IconData icon;
  _Involved(this.title, this.text, this.icon);
}