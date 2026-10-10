import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme/app_spacing.dart';
import '../../core/responsive/responsive.dart';
import '../../core/utils/formatters.dart';
import '../../core/widgets/app_footer.dart';
import '../../core/widgets/app_header.dart';
import '../../core/widgets/app_image.dart';
import '../../core/widgets/cards.dart';
import '../../core/widgets/not_found_state.dart';
import '../../core/widgets/responsive_container.dart';
import '../../core/widgets/responsive_grid.dart';
import '../../core/widgets/section_header.dart';
import '../../data/providers.dart';
import '../../l10n/app_localizations.dart';

class NewsDetailsPage extends ConsumerWidget {
  final String id;
  const NewsDetailsPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final article = ref.watch(newsArticleProvider(id));
    final all = ref.watch(newsProvider);

    return Scaffold(
      appBar: const AppHeader(),
      body: article.when(
        data: (a) {
          if (a == null) {
            return NotFoundState(
              message: l10n.articleNotFound,
              backLabel: l10n.newsTitle,
              backPath: '/news',
            );
          }
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ResponsiveContainer(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.hPad,
                    vertical: AppSpacing.xl,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextButton.icon(
                        onPressed: () => context.go('/news'),
                        icon: const Icon(Icons.arrow_back, size: 16),
                        label: Text(l10n.newsTitle),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Text(a.category,
                          style: Theme.of(context).textTheme.bodySmall),
                      const SizedBox(height: AppSpacing.sm),
                      Semantics(
                        header: true,
                        child: Text(a.title,
                            style: Theme.of(context).textTheme.displayLarge),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      // Localized date (was a fixed yyyy-MM-dd in every language).
                      Text(
                        context.formatDate(a.date),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      ClipRRect(
                        borderRadius:
                            BorderRadius.circular(AppSpacing.radiusLg),
                        child: AspectRatio(
                          aspectRatio: 16 / 9,
                          child: AppImage(path: a.image, semanticLabel: a.title),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      Text(a.content,
                          style: Theme.of(context).textTheme.bodyLarge),
                    ],
                  ),
                ),
                all.maybeWhen(
                  data: (list) {
                    final related =
                        list.where((n) => n.id != a.id).take(3).toList();
                    // No empty "Related articles" heading when there are none.
                    if (related.isEmpty) return const SizedBox.shrink();
                    return ResponsiveContainer(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.hPad,
                        vertical: AppSpacing.section,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SectionHeader(title: l10n.relatedArticles),
                          ResponsiveGrid(
                            columns: context.gridCols(
                                mobile: 1, tablet: 2, desktop: 3),
                            children: related
                                .map((n) => NewsCard(article: n))
                                .toList(),
                          ),
                        ],
                      ),
                    );
                  },
                  orElse: () => const SizedBox.shrink(),
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
}
