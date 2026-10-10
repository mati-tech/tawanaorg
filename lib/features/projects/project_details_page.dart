import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme/app_spacing.dart';
import '../../core/responsive/responsive.dart';
import '../../core/utils/formatters.dart';
import '../../core/widgets/app_footer.dart';
import '../../core/widgets/app_header.dart';
import '../../core/widgets/app_image.dart';
import '../../core/widgets/not_found_state.dart';
import '../../core/widgets/responsive_container.dart';
import '../../core/widgets/responsive_grid.dart';
import '../../core/widgets/status_badge.dart';
import '../../data/providers.dart';
import '../../l10n/app_localizations.dart';
import '../../models/project.dart';

class ProjectDetailsPage extends ConsumerWidget {
  final String id;
  const ProjectDetailsPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final project = ref.watch(projectProvider(id));

    return Scaffold(
      appBar: const AppHeader(),
      body: project.when(
        data: (p) => p == null
            ? NotFoundState(
                message: l10n.projectNotFound,
                backLabel: l10n.projectsTitle,
                backPath: '/projects',
              )
            : _ProjectBody(project: p),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => Center(child: Text(l10n.error)),
      ),
    );
  }
}

class _ProjectBody extends StatelessWidget {
  final Project project;
  const _ProjectBody({required this.project});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final p = project;
    final text = Theme.of(context).textTheme;
    final progress = p.progress.clamp(0.0, 1.0).toDouble();
    final percent = context.formatPercent(progress);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AspectRatio(
            aspectRatio: context.isMobile ? 4 / 3 : 21 / 9,
            child: AppImage(
              path: p.image,
              radius: BorderRadius.zero,
              semanticLabel: p.title,
            ),
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
                    Flexible(
                      child: Text(p.category, style: text.bodySmall),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                Semantics(
                  header: true,
                  child: Text(
                    p.title,
                    style: text.displayLarge,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Text(p.description, style: text.bodyLarge),
                const SizedBox(height: AppSpacing.xl),
                ResponsiveGrid(
                  columns: context.gridCols(mobile: 2, tablet: 4, desktop: 4),
                  children: [
                    _MetaCell(l10n.labelLocation, p.location),
                    _MetaCell(l10n.labelStartDate,
                        context.formatIsoDate(p.startDate)),
                    _MetaCell(l10n.labelBeneficiaries,
                        context.formatNumber(p.beneficiaries)),
                    _MetaCell(l10n.labelGoal, p.goal),
                  ],
                ),
                const SizedBox(height: AppSpacing.xl),
                if (progress > 0) ...[
                  Text('${l10n.labelProgress}: $percent'),
                  const SizedBox(height: AppSpacing.sm),
                  LinearProgressIndicator(
                    value: progress,
                    minHeight: 10,
                    borderRadius: BorderRadius.circular(5),
                    semanticsLabel: l10n.labelProgress,
                    semanticsValue: percent,
                  ),
                  const SizedBox(height: AppSpacing.xl),
                ],
                // Headings now describe the field they introduce (they
                // previously reused "Our story / Objectives / Our mission").
                _paragraph(context, l10n.projectOverview, p.longDescription),
                _paragraph(context, l10n.projectChallenge, p.challenge),
                _paragraph(context, l10n.projectApproach, p.approach),
                _paragraph(context, l10n.projectResults, p.results),
              ],
            ),
          ),
          const AppFooter(),
        ],
      ),
    );
  }

  Widget _paragraph(BuildContext context, String title, String body) {
    if (body.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Semantics(
            header: true,
            child: Text(title,
                style: Theme.of(context).textTheme.headlineMedium),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(body, style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }
}

class _MetaCell extends StatelessWidget {
  final String label;
  final String value;
  const _MetaCell(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 4),
            // Wraps instead of being cut off (long locations / goals).
            Text(value, style: Theme.of(context).textTheme.titleLarge),
          ],
        ),
      ),
    );
  }
}
