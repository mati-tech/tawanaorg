import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_spacing.dart';
import 'app_footer.dart';
import 'responsive_container.dart';

/// Graceful "not found" state for an unknown `:id`, keeping header, footer
/// and a way back to the list.
class NotFoundState extends StatelessWidget {
  final String message;
  final String backLabel;
  final String backPath;
  const NotFoundState({
    super.key,
    required this.message,
    required this.backLabel,
    required this.backPath,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ResponsiveContainer(
            maxWidth: 560,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.section,
            ),
            child: Column(
              children: [
                const Icon(Icons.search_off,
                    size: 64, color: AppColors.textSecondary),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: AppSpacing.xl),
                FilledButton.icon(
                  onPressed: () => context.go(backPath),
                  icon: const Icon(Icons.arrow_back, size: 18),
                  label: Text(backLabel),
                ),
              ],
            ),
          ),
          const AppFooter(),
        ],
      ),
    );
  }
}
