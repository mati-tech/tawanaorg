import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';
import '../../l10n/app_localizations.dart';

class StatusBadge extends StatelessWidget {
  final String status; // 'active' | 'completed' | 'upcoming'
  const StatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    late final Color bg;
    late final Color fg;
    late final String label;
    switch (status) {
      case 'completed':
        bg = const Color(0xFFE8F5E9);
        fg = AppColors.success;
        label = l10n.statusCompleted;
        break;
      case 'upcoming':
        bg = const Color(0xFFFFF3E0);
        fg = AppColors.warning;
        label = l10n.statusUpcoming;
        break;
      default:
        bg = const Color(0xFFE3F2FD);
        fg = AppColors.info;
        label = l10n.statusActive;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(color: fg, fontWeight: FontWeight.w600, fontSize: 12),
      ),
    );
  }
}