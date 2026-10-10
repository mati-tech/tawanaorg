import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_spacing.dart';
import '../../l10n/app_localizations.dart';
import '../responsive/responsive.dart';
import 'language_selector.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  const AppHeader({super.key});

  static const double height = 72;

  @override
  Size get preferredSize => const Size.fromHeight(height);

  static const _navItems = <_NavItem>[
    _NavItem(path: '/', label: 'navHome'),
    _NavItem(path: '/about', label: 'navAbout'),
    _NavItem(path: '/programs', label: 'navPrograms'),
    _NavItem(path: '/projects', label: 'navProjects'),
    _NavItem(path: '/impact', label: 'navImpact'),
    _NavItem(path: '/news', label: 'navNews'),
    _NavItem(path: '/get-involved', label: 'navGetInvolved'),
    _NavItem(path: '/transparency', label: 'navTransparency'),
    _NavItem(path: '/contact', label: 'navContact'),
  ];

  /// A nav item is active on its own route and on its detail routes
  /// (e.g. "Projects" stays highlighted on /projects/education-for-all).
  static bool _isActive(String currentPath, String itemPath) {
    if (itemPath == '/') return currentPath == '/';
    return currentPath == itemPath || currentPath.startsWith('$itemPath/');
  }

  static String _localized(AppLocalizations l, String key) {
    switch (key) {
      case 'navHome':
        return l.navHome;
      case 'navAbout':
        return l.navAbout;
      case 'navPrograms':
        return l.navPrograms;
      case 'navProjects':
        return l.navProjects;
      case 'navImpact':
        return l.navImpact;
      case 'navNews':
        return l.navNews;
      case 'navGetInvolved':
        return l.navGetInvolved;
      case 'navTransparency':
        return l.navTransparency;
      case 'navContact':
        return l.navContact;
      default:
        return key;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final currentPath = GoRouterState.of(context).uri.path;
    // The full desktop nav (9 links + language + donate) does not fit below
    // the tablet breakpoint, so phones *and* portrait tablets use the menu.
    final compact = context.width < Breakpoints.tablet;
    // The long foundation name only fits next to the full nav on wide screens.
    final showName = compact || context.isLargeDesktop;

    final logo = Semantics(
      link: true,
      label: l10n.navHome,
      child: InkWell(
        onTap: () => context.go('/'),
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 40,
                height: 40,
                child: Image.asset(
                  'assets/images/logo/logo.png',
                  fit: BoxFit.contain,
                  semanticLabel: l10n.appName,
                  // Drawn at 40 px; decode small instead of at full resolution.
                  cacheWidth: 160,
                  errorBuilder: (_, __, ___) => Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
              if (showName) ...[
                const SizedBox(width: 10),
                Flexible(
                  child: Text(
                    l10n.appName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: compact ? 16 : 18,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.hPad),
          child: SizedBox(
            height: height,
            child: compact
                ? Row(
                    children: [
                      // K1: the name shrinks with an ellipsis instead of
                      // pushing the action buttons off-screen (280–899 px).
                      Expanded(
                        child: Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: logo,
                        ),
                      ),
                      IconButton(
                        tooltip: l10n.language,
                        onPressed: () => _openLanguageSheet(context),
                        icon: const Icon(Icons.language),
                      ),
                      IconButton(
                        tooltip: MaterialLocalizations.of(context)
                            .openAppDrawerTooltip,
                        onPressed: () => _openMenu(context, currentPath),
                        icon: const Icon(Icons.menu),
                      ),
                    ],
                  )
                : Row(
                    children: [
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 420),
                        child: logo,
                      ),
                      const SizedBox(width: AppSpacing.md),
                      // Takes the remaining width and scrolls horizontally
                      // when the localized labels do not fit.
                      Expanded(
                        child: Align(
                          alignment: AlignmentDirectional.center,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: _navItems
                                  .map((item) => _navLink(
                                        context,
                                        item,
                                        l10n,
                                        _isActive(currentPath, item.path),
                                      ))
                                  .toList(),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      const LanguageSelector(),
                      const SizedBox(width: AppSpacing.md),
                      FilledButton(
                        onPressed: () => context.go('/donate'),
                        child: Text(l10n.donate),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget _navLink(
    BuildContext context,
    _NavItem item,
    AppLocalizations l10n,
    bool active,
  ) {
    final label = _localized(l10n, item.label);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Semantics(
        selected: active,
        child: TextButton(
          onPressed: () => context.go(item.path),
          style: TextButton.styleFrom(
            foregroundColor: active ? AppColors.primary : AppColors.textPrimary,
            minimumSize: const Size(48, 48),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontWeight: active ? FontWeight.w700 : FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  void _openLanguageSheet(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) => SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                    AppSpacing.lg, 0, AppSpacing.lg, AppSpacing.sm),
                child: Text(
                  l10n.language,
                  style: Theme.of(sheetContext).textTheme.titleLarge,
                ),
              ),
              LanguageSelector(
                forceList: true,
                onSelected: () => Navigator.pop(sheetContext),
              ),
              const SizedBox(height: AppSpacing.md),
            ],
          ),
        ),
      ),
    );
  }

  void _openMenu(BuildContext context, String currentPath) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => _MobileMenu(
        items: _navItems,
        currentPath: currentPath,
        // The page context outlives the sheet, so navigate with it.
        routerContext: context,
      ),
    );
  }
}

class _NavItem {
  final String path;
  final String label;
  const _NavItem({required this.path, required this.label});
}

class _MobileMenu extends StatelessWidget {
  final List<_NavItem> items;
  final String currentPath;
  final BuildContext routerContext;
  const _MobileMenu({
    required this.items,
    required this.currentPath,
    required this.routerContext,
  });

  void _goTo(BuildContext sheetContext, String path) {
    Navigator.pop(sheetContext);
    routerContext.go(path);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    // Scrollable so all 9 links + Donate fit on short screens (e.g. 320×568).
    return SafeArea(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height * 0.9,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  const Flexible(child: LanguageSelector()),
                  const Spacer(),
                  IconButton(
                    tooltip:
                        MaterialLocalizations.of(context).closeButtonTooltip,
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const Divider(height: 32),
              ...items.map((i) {
                final active = AppHeader._isActive(currentPath, i.path);
                return ListTile(
                  selected: active,
                  selectedColor: AppColors.primary,
                  selectedTileColor: AppColors.primaryLight,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.radius),
                  ),
                  title: Text(
                    AppHeader._localized(l10n, i.label),
                    style: TextStyle(
                      fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                    ),
                  ),
                  onTap: () => _goTo(context, i.path),
                );
              }),
              const SizedBox(height: AppSpacing.md),
              FilledButton(
                onPressed: () => _goTo(context, '/donate'),
                child: Text(l10n.donate),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
