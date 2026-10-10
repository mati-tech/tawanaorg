import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_spacing.dart';
import '../../core/responsive/responsive.dart';
import '../../core/widgets/app_footer.dart';
import '../../core/widgets/app_header.dart';
import '../../core/widgets/cards.dart';
import '../../core/widgets/responsive_container.dart';
import '../../core/widgets/responsive_grid.dart';
import '../../core/widgets/section_header.dart';
import '../../data/providers.dart';
import '../../l10n/app_localizations.dart';

class TeamPage extends ConsumerWidget {
  const TeamPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final team = ref.watch(teamProvider);

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
                    Text(l10n.teamTitle,
                        style: Theme.of(context).textTheme.displayLarge),
                    const SizedBox(height: AppSpacing.md),
                    Text(l10n.teamSubtitle,
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
              child: team.when(
                data: (list) {
                  final groups = {
                    'leadership': l10n.teamLeadership,
                    'staff': l10n.teamStaff,
                    'advisors': l10n.teamAdvisors,
                  };
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: groups.entries.map((entry) {
                      final members =
                      list.where((m) => m.group == entry.key).toList();
                      if (members.isEmpty) return const SizedBox.shrink();
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SectionHeader(title: entry.value),
                          ResponsiveGrid(
                            columns: context.gridCols(
                                mobile: 1, tablet: 2, desktop: 3),
                            children: members
                                .map((m) => TeamCard(member: m))
                                .toList(),
                          ),
                          const SizedBox(height: AppSpacing.xl),
                        ],
                      );
                    }).toList(),
                  );
                },
                loading: () => const SizedBox.shrink(),
                error: (_, __) => Text(l10n.error),
              ),
            ),
            const AppFooter(),
          ],
        ),
      ),
    );
  }
}