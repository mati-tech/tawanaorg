import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_spacing.dart';
import '../../core/responsive/responsive.dart';
import '../../core/widgets/app_footer.dart';
import '../../core/widgets/app_header.dart';
import '../../core/widgets/cards.dart';
import '../../core/widgets/responsive_container.dart';
import '../../data/providers.dart';
import '../../l10n/app_localizations.dart';

class ProjectsPage extends ConsumerStatefulWidget {
  const ProjectsPage({super.key});

  @override
  ConsumerState<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends ConsumerState<ProjectsPage> {
  String _status = 'all';
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final projects = ref.watch(projectsProvider);

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
                    Text(l10n.projectsTitle,
                        style: Theme.of(context).textTheme.displayLarge),
                    const SizedBox(height: AppSpacing.md),
                    Text(l10n.projectsSubtitle,
                        style: Theme.of(context).textTheme.bodyLarge),
                  ],
                ),
              ),
            ),
            ResponsiveContainer(
              padding: EdgeInsets.symmetric(
                horizontal: context.hPad,
                vertical: AppSpacing.xl,
              ),
              child: Column(
                children: [
                  TextField(
                    onChanged: (v) => setState(() => _query = v.toLowerCase()),
                    decoration: InputDecoration(
                      hintText: l10n.searchPlaceholder,
                      prefixIcon: const Icon(Icons.search),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Wrap(
                    spacing: 8,
                    children: [
                      _filterChip(l10n.filterAll, 'all'),
                      _filterChip(l10n.statusActive, 'active'),
                      _filterChip(l10n.statusCompleted, 'completed'),
                      _filterChip(l10n.statusUpcoming, 'upcoming'),
                    ],
                  ),
                ],
              ),
            ),
            ResponsiveContainer(
              padding: EdgeInsets.symmetric(
                horizontal: context.hPad,
                vertical: AppSpacing.lg,
              ),
              child: projects.when(
                data: (list) {
                  final filtered = list.where((p) {
                    final matchesStatus =
                        _status == 'all' || p.status == _status;
                    final matchesQuery = _query.isEmpty ||
                        p.title.toLowerCase().contains(_query) ||
                        p.description.toLowerCase().contains(_query);
                    return matchesStatus && matchesQuery;
                  }).toList();
                  if (filtered.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.all(AppSpacing.xxl),
                      child: Center(child: Text(l10n.error)),
                    );
                  }
                  final cols = context.gridCols(mobile: 1, tablet: 2, desktop: 3);
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filtered.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: cols,
                      crossAxisSpacing: AppSpacing.md,
                      mainAxisSpacing: AppSpacing.md,
                      childAspectRatio: 0.72,
                    ),
                    itemBuilder: (_, i) => ProjectCard(project: filtered[i]),
                  );
                },
                loading: () => const Center(
                    child: Padding(
                      padding: EdgeInsets.all(AppSpacing.xxl),
                      child: CircularProgressIndicator(),
                    )),
                error: (_, __) => Text(l10n.error),
              ),
            ),
            const AppFooter(),
          ],
        ),
      ),
    );
  }

  Widget _filterChip(String label, String value) {
    return ChoiceChip(
      label: Text(label),
      selected: _status == value,
      onSelected: (_) => setState(() => _status = value),
    );
  }
}