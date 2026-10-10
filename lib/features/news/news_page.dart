import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_spacing.dart';
import '../../core/responsive/responsive.dart';
import '../../core/utils/formatters.dart';
import '../../core/widgets/app_footer.dart';
import '../../core/widgets/app_header.dart';
import '../../core/widgets/app_image.dart';
import '../../core/widgets/cards.dart';
import '../../core/widgets/responsive_container.dart';
import '../../core/widgets/responsive_grid.dart';
import '../../data/providers.dart';
import '../../l10n/app_localizations.dart';
import '../../models/news.dart';

/// News list: the most recent article is featured at the top, the rest
/// follow in a 1 / 2 / 3 column grid (newest first).
class NewsPage extends ConsumerWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final news = ref.watch(newsProvider);

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
                    Semantics(
                      header: true,
                      child: Text(l10n.newsTitle,
                          style: Theme.of(context).textTheme.displayLarge),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(l10n.newsSubtitle,
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
              child: news.when(
                data: (list) {
                  if (list.isEmpty) {
                    return Center(
                      child: Text(
                        l10n.newsEmpty,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    );
                  }
                  final sorted = [...list]
                    ..sort((a, b) => b.date.compareTo(a.date));
                  final rest = sorted.skip(1).toList();
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _FeaturedArticle(article: sorted.first),
                      if (rest.isNotEmpty) ...[
                        const SizedBox(height: AppSpacing.xl),
                        ResponsiveGrid(
                          columns:
                              context.gridCols(mobile: 1, tablet: 2, desktop: 3),
                          children:
                              rest.map((a) => NewsCard(article: a)).toList(),
                        ),
                      ],
                    ],
                  );
                },
                loading: () => const Center(
                  child: Padding(
                    padding: EdgeInsets.all(AppSpacing.xxl),
                    child: CircularProgressIndicator(),
                  ),
                ),
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

class _FeaturedArticle extends StatelessWidget {
  final NewsArticle article;
  const _FeaturedArticle({required this.article});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final text = Theme.of(context).textTheme;

    final image = AspectRatio(
      aspectRatio: 16 / 9,
      child: AppImage(path: article.image, radius: BorderRadius.zero),
    );

    final details = Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              l10n.featuredLabel,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            '${article.category} · ${context.formatDate(article.date)}',
            style: text.bodySmall,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(article.title, style: text.headlineMedium),
          const SizedBox(height: AppSpacing.sm),
          Text(article.summary, style: text.bodyLarge),
          const SizedBox(height: AppSpacing.md),
          Text(
            l10n.readMore,
            style: const TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.go('/news/${article.id}'),
        child: context.isMobile
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [image, details],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: image),
                  Expanded(child: details),
                ],
              ),
      ),
    );
  }
}
