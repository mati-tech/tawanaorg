import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_spacing.dart';
import '../../core/responsive/responsive.dart';
import '../../core/widgets/app_footer.dart';
import '../../core/widgets/app_header.dart';
import '../../core/widgets/responsive_container.dart';
import '../../l10n/app_localizations.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _formKey = GlobalKey<FormState>();
  bool _sent = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
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
                    Text(l10n.contactTitle,
                        style: Theme.of(context).textTheme.displayLarge),
                    const SizedBox(height: AppSpacing.md),
                    Text(l10n.contactSubtitle,
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
              child: context.isMobile
                  ? Column(
                children: [
                  _info(context, l10n),
                  const SizedBox(height: AppSpacing.xl),
                  _form(context, l10n),
                ],
              )
                  : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _info(context, l10n)),
                  const SizedBox(width: AppSpacing.xxl),
                  Expanded(child: _form(context, l10n)),
                ],
              ),
            ),
            const AppFooter(),
          ],
        ),
      ),
    );
  }

  Widget _info(BuildContext context, AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _infoRow(context, Icons.place_outlined, l10n.contactAddress,
            'Example Street 1, City, Country'),
        _infoRow(context, Icons.email_outlined, l10n.contactEmail,
            'info@example-foundation.org'),
        _infoRow(context, Icons.phone_outlined, l10n.contactPhone,
            '+00 000 000 000'),
        _infoRow(context, Icons.schedule_outlined, l10n.contactHours,
            'Mon–Fri, 9:00–17:00'),
        const SizedBox(height: AppSpacing.lg),
        Text(l10n.contactFollow,
            style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: AppSpacing.sm),
        const Row(
          children: [
            Icon(Icons.facebook, color: AppColors.textSecondary),
            SizedBox(width: 12),
            Icon(Icons.alternate_email, color: AppColors.textSecondary),
            SizedBox(width: 12),
            Icon(Icons.camera_alt_outlined, color: AppColors.textSecondary),
            SizedBox(width: 12),
            Icon(Icons.play_circle_outline, color: AppColors.textSecondary),
          ],
        ),
      ],
    );
  }

  Widget _infoRow(
      BuildContext context, IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.primary),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                Text(value, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _form(BuildContext context, AppLocalizations l10n) {
    if (_sent) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Row(
            children: [
              const Icon(Icons.check_circle, color: AppColors.success),
              const SizedBox(width: AppSpacing.md),
              Expanded(child: Text(l10n.contactFormSuccess)),
            ],
          ),
        ),
      );
    }
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: l10n.contactFormName),
            validator: (v) =>
            (v == null || v.isEmpty) ? l10n.error : null,
          ),
          const SizedBox(height: AppSpacing.md),
          TextFormField(
            decoration: InputDecoration(labelText: l10n.contactFormEmail),
            validator: (v) =>
            (v == null || !v.contains('@')) ? l10n.error : null,
          ),
          const SizedBox(height: AppSpacing.md),
          TextFormField(
            decoration: InputDecoration(labelText: l10n.contactFormPhone),
          ),
          const SizedBox(height: AppSpacing.md),
          TextFormField(
            decoration: InputDecoration(labelText: l10n.contactFormSubject),
          ),
          const SizedBox(height: AppSpacing.md),
          TextFormField(
            maxLines: 5,
            decoration: InputDecoration(labelText: l10n.contactFormMessage),
            validator: (v) =>
            (v == null || v.isEmpty) ? l10n.error : null,
          ),
          const SizedBox(height: AppSpacing.lg),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: FilledButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  setState(() => _sent = true);
                }
              },
              child: Text(l10n.contactFormSend),
            ),
          ),
        ],
      ),
    );
  }
}