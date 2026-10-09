import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_spacing.dart';
import '../../l10n/app_localizations.dart';
import '../responsive/responsive.dart';
import 'language_selector.dart';

class AppHeader extends ConsumerWidget implements PreferredSizeWidget {
  const AppHeader({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(72);

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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final currentPath = GoRouterState.of(context).uri.path;
    final isMobile = context.isMobile;

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
            height: 72,
            child: Row(
              children: [
                // Logo
                InkWell(
                  onTap: () => context.go('/'),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 40,
                        height: 40,
                        child: Image.asset(
                          'assets/images/logo/logo.png',
                          fit: BoxFit.contain,
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
                      const SizedBox(width: 10),
                      Text(
                        l10n.appName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                if (!isMobile)
                  Expanded(
                    child: Center(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: _navItems
                              .map((item) => _navLink(
                            context,
                            item,
                            l10n,
                            currentPath == item.path,
                          ))
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                if (!isMobile) ...[
                  const LanguageSelector(),
                  const SizedBox(width: AppSpacing.md),
                  FilledButton(
                    onPressed: () => context.go('/donate'),
                    child: Text(l10n.donate),
                  ),
                ] else ...[
                  IconButton(
                    onPressed: () => _openDrawer(context, ref),
                    icon: const Icon(Icons.menu),
                  ),
                ],
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
      child: TextButton(
        onPressed: () => context.go(item.path),
        style: TextButton.styleFrom(
          foregroundColor: active ? AppColors.primary : AppColors.textPrimary,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: active ? FontWeight.w700 : FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  String _localized(AppLocalizations l, String key) {
    switch (key) {
      case 'navHome': return l.navHome;
      case 'navAbout': return l.navAbout;
      case 'navPrograms': return l.navPrograms;
      case 'navProjects': return l.navProjects;
      case 'navImpact': return l.navImpact;
      case 'navNews': return l.navNews;
      case 'navGetInvolved': return l.navGetInvolved;
      case 'navTransparency': return l.navTransparency;
      case 'navContact': return l.navContact;
      default: return key;
    }
  }

  void _openDrawer(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => _MobileMenu(items: _navItems, l10n: l10n),
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
  final AppLocalizations l10n;
  const _MobileMenu({required this.items, required this.l10n});

  String _label(String key) {
    switch (key) {
      case 'navHome': return l10n.navHome;
      case 'navAbout': return l10n.navAbout;
      case 'navPrograms': return l10n.navPrograms;
      case 'navProjects': return l10n.navProjects;
      case 'navImpact': return l10n.navImpact;
      case 'navNews': return l10n.navNews;
      case 'navGetInvolved': return l10n.navGetInvolved;
      case 'navTransparency': return l10n.navTransparency;
      case 'navContact': return l10n.navContact;
      default: return key;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const LanguageSelector(),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const Divider(height: 32),
            ...items.map(
                  (i) => ListTile(
                title: Text(_label(i.label)),
                onTap: () {
                  Navigator.pop(context);
                  context.go(i.path);
                },
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            FilledButton(
              onPressed: () {
                Navigator.pop(context);
                context.go('/donate');
              },
              child: Text(l10n.donate),
            ),
          ],
        ),
      ),
    );
  }
}