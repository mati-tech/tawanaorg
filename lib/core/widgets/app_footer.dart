import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_spacing.dart';
import '../../l10n/app_localizations.dart';
import '../responsive/responsive.dart';
import 'responsive_container.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isMobile = context.isMobile;

    final columns = <_FooterColumn>[
      _FooterColumn(l10n.footerAbout, [
        _FooterLink(l10n.navAbout, '/about'),
        _FooterLink(l10n.ourMission, '/about'),
        _FooterLink(l10n.navTeam, '/team'),
      ]),
      _FooterColumn(l10n.footerOurWork, [
        _FooterLink(l10n.navPrograms, '/programs'),
        _FooterLink(l10n.navProjects, '/projects'),
        _FooterLink(l10n.navImpact, '/impact'),
      ]),
      _FooterColumn(l10n.footerGetInvolved, [
        _FooterLink(l10n.donate, '/donate'),
        _FooterLink(l10n.involvedVolunteer, '/get-involved'),
        _FooterLink(l10n.involvedPartner, '/get-involved'),
      ]),
      _FooterColumn(l10n.footerTransparency, [
        _FooterLink(l10n.transparencyReports, '/transparency'),
        _FooterLink(l10n.transparencyFinancial, '/transparency'),
        _FooterLink(l10n.transparencyGovernance, '/transparency'),
      ]),
      _FooterColumn(l10n.footerContact, [
        _FooterLink(l10n.navContact, '/contact'),
      ]),
    ];

    return Container(
      color: const Color(0xFF0F1F14),
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxl),
      child: ResponsiveContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isMobile)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: columns
                    .map((c) => Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.lg),
                  child: _buildColumn(context, c),
                ))
                    .toList(),
              )
            else
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: columns
                    .map((c) => Expanded(child: _buildColumn(context, c)))
                    .toList(),
              ),
            const SizedBox(height: AppSpacing.xl),
            const Divider(color: Colors.white24),
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                Expanded(
                  child: Text(
                    '© ${DateTime.now().year} ${l10n.appName}. ${l10n.footerRights}',
                    style: const TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(l10n.footerPrivacy,
                      style: const TextStyle(color: Colors.white70)),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(l10n.footerTerms,
                      style: const TextStyle(color: Colors.white70)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColumn(BuildContext context, _FooterColumn col) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          col.title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        ...col.links.map(
              (l) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: InkWell(
              onTap: () => context.go(l.path),
              child: Text(
                l.label,
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _FooterColumn {
  final String title;
  final List<_FooterLink> links;
  _FooterColumn(this.title, this.links);
}

class _FooterLink {
  final String label;
  final String path;
  _FooterLink(this.label, this.path);
}