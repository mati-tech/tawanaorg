import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_spacing.dart';
import '../../core/responsive/responsive.dart';
import '../../core/widgets/app_footer.dart';
import '../../core/widgets/app_header.dart';
import '../../core/widgets/app_image.dart';
import '../../core/widgets/responsive_container.dart';
import '../../core/widgets/status_badge.dart';
import '../../data/providers.dart';
import '../../l10n/app_localizations.dart';

class ProjectDetailsPage extends ConsumerWidget {
  final String id;
  const ProjectDetailsPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final project = ref.watch(projectProvider(id));

    return Scaffold(
      appBar: const AppHeader(),
      body: project.when(
        data: (p) {
          if (p == null) {
            return Center(child: Text(l10n.error));
          }
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AspectRatio(
                  aspectRatio: context.isMobile ? 4 / 3 : 21 / 9,
                  child: AppImage(path: p.image, radius: BorderRadius.zero),
                ),
                ResponsiveContainer(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.hPad,
                    vertical: AppSpacing.xl,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextButton.icon(
                        onPressed: () => context.go('/projects'),
                        icon: const Icon(Icons.arrow_back, size: 16),
                        label: Text(l10n.projectsTitle),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Row(
                        children: [
                          StatusBadge(status: p.status),
                          const SizedBox(width: AppSpacing.sm),
                          Text(p.category,
                              style: Theme.of(context).textTheme.bodySmall),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Text(p.title,
                          style: Theme.of(context).textTheme.displayLarge),
                      const SizedBox(height: AppSpacing.md),
                      Text(p.description,
                          style: Theme.of(context).textTheme.bodyLarge),
                      const SizedBox(height: AppSpacing.xl),
                      _metaGrid(context, l10n, p.location, p.startDate,
                          p.beneficiaries, p.goal),
                      const SizedBox(height: AppSpacing.xl),
                      if (p.progress > 0) ...[
                        Text('${l10n.labelProgress}: '
                            '${(p.progress * 100).round()}%'),
                        const SizedBox(height: AppSpacing.sm),
                        LinearProgressIndicator(value: p.progress, minHeight: 10),
                        const SizedBox(height: AppSpacing.xl),
                      ],
                      _paragraph(context, l10n.ourStory, p.longDescription),
                      _paragraph(context, l10n.programObjectives, p.challenge),
                      _paragraph(context, l10n.ourMission, p.approach),
                      _paragraph(context, l10n.programImpact, p.results),
                    ],
                  ),
                ),
                const AppFooter(),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => Center(child: Text(l10n.error)),
      ),
    );
  }

  Widget _metaGrid(BuildContext context, AppLocalizations l10n, String location,
      String startDate, int beneficiaries, String goal) {
    final cells = [
      _MetaCell(l10n.labelLocation, location),
      _MetaCell(l10n.labelStartDate, startDate),
      _MetaCell(l10n.labelBeneficiaries, beneficiaries.toString()),
      _MetaCell(l10n.labelGoal, goal),
    ];
    final cols = context.gridCols(mobile: 2, tablet: 4, desktop: 4);
    return GridView.count(
      crossAxisCount: cols,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: AppSpacing.md,
      mainAxisSpacing: AppSpacing.md,
      childAspectRatio: 2.4,
      children: cells
          .map((c) => Card(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(c.label,
                  style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: 4),
              Text(c.value,
                  style: Theme.of(context).textTheme.titleLarge,
                  overflow: TextOverflow.ellipsis),
            ],
          ),
        ),
      ))
          .toList(),
    );
  }

  Widget _paragraph(BuildContext context, String title, String body) {
    if (body.isEmpty) return const SizedBox.shrink();
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
}

class _MetaCell {
  final String label;
  final String value;
  _MetaCell(this.label, this.value);
}