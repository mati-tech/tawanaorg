import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_spacing.dart';
import '../../core/responsive/responsive.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/app_footer.dart';
import '../../core/widgets/app_header.dart';
import '../../core/widgets/app_image.dart';
import '../../core/widgets/cards.dart';
import '../../core/widgets/responsive_container.dart';
import '../../core/widgets/section_header.dart';
import '../../data/providers.dart';
import '../../l10n/app_localizations.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final stats = ref.watch(impactStatsProvider);
    final projects = ref.watch(projectsProvider);
    final news = ref.watch(newsProvider);
    final programs = ref.watch(programsProvider);
    final about = ref.watch(aboutProvider);

    return Scaffold(
      appBar: const AppHeader(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _Hero(),
            const SizedBox(height: AppSpacing.section),

            // Impact stats
            ResponsiveContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionHeader(
                    title: l10n.homeImpactTitle,
                    subtitle: l10n.homeImpactSubtitle,
                  ),
                  stats.when(
                    data: (list) => _StatGrid(items: list),
                    loading: () => const Center(
                        child: Padding(
                          padding: EdgeInsets.all(AppSpacing.xl),
                          child: CircularProgressIndicator(),
                        )),
                    error: (_, __) => Text(l10n.error),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.section),

            // Mission
            about.when(
              data: (a) => _MissionSection(
                title: l10n.homeMissionTitle,
                text: a['mission'] as String? ?? '',
              ),
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
            ),
            const SizedBox(height: AppSpacing.section),

            // Featured projects
            ResponsiveContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: SectionHeader(
                          title: l10n.homeProjectsTitle,
                          subtitle: l10n.homeProjectsSubtitle,
                        ),
                      ),
                      if (!context.isMobile)
                        TextButton(
                          onPressed: () => context.go('/projects'),
                          child: Text(l10n.viewAll),
                        ),
                    ],
                  ),
                  projects.when(
                    data: (list) => _ProjectGrid(
                        projects: list.take(3).toList()),
                    loading: () => const Center(
                        child: Padding(
                          padding: EdgeInsets.all(AppSpacing.xl),
                          child: CircularProgressIndicator(),
                        )),
                    error: (_, __) => Text(l10n.error),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.section),

            // Areas of work
            ResponsiveContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionHeader(title: l10n.homeAreasTitle),
                  programs.when(
                    data: (list) => _ProgramGrid(programs: list.take(6).toList()),
                    loading: () => const SizedBox.shrink(),
                    error: (_, __) => Text(l10n.error),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.section),

            // Latest news
            ResponsiveContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: SectionHeader(
                          title: l10n.homeNewsTitle,
                          subtitle: l10n.homeNewsSubtitle,
                        ),
                      ),
                      if (!context.isMobile)
                        TextButton(
                          onPressed: () => context.go('/news'),
                          child: Text(l10n.viewAll),
                        ),
                    ],
                  ),
                  news.when(
                    data: (list) => _NewsGrid(articles: list.take(3).toList()),
                    loading: () => const SizedBox.shrink(),
                    error: (_, __) => Text(l10n.error),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.section),

            _CallToAction(),
            const AppFooter(),
          ],
        ),
      ),
    );
  }
}

class _Hero extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isMobile = context.isMobile;
    return Container(
      color: AppColors.primaryLight,
      padding: EdgeInsets.symmetric(
        horizontal: context.hPad,
        vertical: isMobile ? AppSpacing.xxl : AppSpacing.section,
      ),
      child: ResponsiveContainer(
        padding: EdgeInsets.zero,
        child: isMobile
            ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _heroText(context, l10n),
            const SizedBox(height: AppSpacing.xl),
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
              child: AspectRatio(
                aspectRatio: 4 / 3,
                child: AppImage(path: 'assets/images/hero/hero-community.jpg'),
              ),
            ),
          ],
        )
            : Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: _heroText(context, l10n)),
            const SizedBox(width: AppSpacing.xxl),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                child: AspectRatio(
                  aspectRatio: 4 / 3,
                  child: AppImage(
                      path: 'assets/images/hero/hero-community.jpg'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _heroText(BuildContext context, AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.heroTitle,
            style: Theme.of(context).textTheme.displayLarge),
        const SizedBox(height: AppSpacing.md),
        Text(l10n.heroSubtitle,
            style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: AppSpacing.xl),
        Wrap(
          spacing: AppSpacing.md,
          runSpacing: AppSpacing.md,
          children: [
            PrimaryButton(
              label: l10n.heroCTA1,
              icon: Icons.arrow_forward,
              onPressed: () => context.go('/donate'),
            ),
            SecondaryButton(
              label: l10n.heroCTA2,
              onPressed: () => context.go('/projects'),
            ),
          ],
        ),
      ],
    );
  }
}

class _StatGrid extends StatelessWidget {
  final List items;
  const _StatGrid({required this.items});

  @override
  Widget build(BuildContext context) {
    final cols = context.gridCols(mobile: 2, tablet: 3, desktop: 5);
    return GridView.count(
      crossAxisCount: cols,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: AppSpacing.md,
      mainAxisSpacing: AppSpacing.md,
      childAspectRatio: 1.6,
      children: items
          .map((s) => StatCard(value: s.value as String, label: s.label as String))
          .toList(),
    );
  }
}

class _MissionSection extends StatelessWidget {
  final String title;
  final String text;
  const _MissionSection({required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surface,
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.section),
      child: ResponsiveContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(title: title),
            Text(text, style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }
}

class _ProjectGrid extends StatelessWidget {
  final List projects;
  const _ProjectGrid({required this.projects});

  @override
  Widget build(BuildContext context) {
    final cols = context.gridCols(mobile: 1, tablet: 2, desktop: 3);
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: projects.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: cols,
        crossAxisSpacing: AppSpacing.md,
        mainAxisSpacing: AppSpacing.md,
        childAspectRatio: 0.72,
      ),
      itemBuilder: (_, i) => ProjectCard(project: projects[i]),
    );
  }
}

class _NewsGrid extends StatelessWidget {
  final List articles;
  const _NewsGrid({required this.articles});

  @override
  Widget build(BuildContext context) {
    final cols = context.gridCols(mobile: 1, tablet: 2, desktop: 3);
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: articles.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: cols,
        crossAxisSpacing: AppSpacing.md,
        mainAxisSpacing: AppSpacing.md,
        childAspectRatio: 0.85,
      ),
      itemBuilder: (_, i) => NewsCard(article: articles[i]),
    );
  }
}

class _ProgramGrid extends StatelessWidget {
  final List programs;
  const _ProgramGrid({required this.programs});

  @override
  Widget build(BuildContext context) {
    final cols = context.gridCols(mobile: 1, tablet: 2, desktop: 3);
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: programs.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: cols,
        crossAxisSpacing: AppSpacing.md,
        mainAxisSpacing: AppSpacing.md,
        childAspectRatio: 1.6,
      ),
      itemBuilder: (_, i) {
        final p = programs[i];
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.volunteer_activism,
                    color: AppColors.primary, size: 28),
                const SizedBox(height: AppSpacing.sm),
                Text(p.title,
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: AppSpacing.xs),
                Expanded(
                  child: Text(
                    p.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _CallToAction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      color: AppColors.primary,
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.section),
      child: ResponsiveContainer(
        child: Column(
          children: [
            Text(
              l10n.homeCTA_Title,
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge
                  ?.copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              l10n.homeCTA_Text,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: Colors.white70),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xl),
            Wrap(
              spacing: AppSpacing.md,
              runSpacing: AppSpacing.md,
              children: [
                FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppColors.primary,
                  ),
                  onPressed: () => context.go('/donate'),
                  child: Text(l10n.homeCTA_Donate),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white),
                  ),
                  onPressed: () => context.go('/get-involved'),
                  child: Text(l10n.homeCTA_Volunteer),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}