import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_spacing.dart';
import '../../core/responsive/responsive.dart';
import '../../core/widgets/app_footer.dart';
import '../../core/widgets/app_header.dart';
import '../../core/widgets/responsive_container.dart';
import '../../core/widgets/responsive_grid.dart';
import '../../l10n/app_localizations.dart';

class GetInvolvedPage extends StatelessWidget {
  const GetInvolvedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final cards = [
      _Involved(l10n.involvedVolunteer, l10n.involvedVolunteerText,
          Icons.volunteer_activism, l10n.navContact, '/contact'),
      _Involved(l10n.involvedPartner, l10n.involvedPartnerText,
          Icons.handshake, l10n.navContact, '/contact'),
      _Involved(l10n.involvedFundraise, l10n.involvedFundraiseText,
          Icons.campaign, l10n.navContact, '/contact'),
      _Involved(l10n.involvedCorporate, l10n.involvedCorporateText,
          Icons.business_center, l10n.navContact, '/contact'),
      _Involved(l10n.involvedAmbassador, l10n.involvedAmbassadorText,
          Icons.public, l10n.navContact, '/contact'),
      // The Donate card previously sent people to the contact form.
      _Involved(l10n.donate, l10n.homeCTA_Text, Icons.favorite, l10n.donate,
          '/donate'),
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
              child: ResponsiveGrid(
                columns: context.gridCols(mobile: 1, tablet: 2, desktop: 3),
                children: cards.map((c) {
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
                            Text(c.text,
                                style:
                                    Theme.of(context).textTheme.bodyMedium),
                            const SizedBox(height: AppSpacing.md),
                            // Pushes the button to the card bottom so buttons
                            // line up across a row.
                            const Spacer(),
                            FilledButton(
                              onPressed: () => context.go(c.route),
                              child: Text(c.action),
                            ),
                          ],
                        ),
                      ),
                    );
                }).toList(),
              ),
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
  final String action;
  final String route;
  const _Involved(this.title, this.text, this.icon, this.action, this.route);
}