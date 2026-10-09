import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';

/// Asset image with graceful fallback if the file has not been added yet.
class AppImage extends StatelessWidget {
  final String path;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? radius;
  const AppImage({
    super.key,
    required this.path,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    final r = radius ?? BorderRadius.circular(12);
    return ClipRRect(
      borderRadius: r,
      child: SizedBox(
        width: width,
        height: height,
        child: path.isEmpty
            ? _fallback()
            : Image.asset(
          path,
          fit: fit,
          width: width,
          height: height,
          errorBuilder: (_, __, ___) => _fallback(),
        ),
      ),
    );
  }

  Widget _fallback() => Container(
    color: AppColors.primaryLight,
    alignment: Alignment.center,
    child: const Icon(
      Icons.image_outlined,
      size: 40,
      color: AppColors.primary,
    ),
  );
}