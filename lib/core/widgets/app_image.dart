import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../app/theme/app_colors.dart';

/// Asset image with graceful fallback if the file has not been added yet.
///
/// K4: the asset manifest is consulted first, so paths listed in
/// content.json whose files are not on disk show the placeholder directly
/// instead of firing a 404 request in the browser.
class AppImage extends StatelessWidget {
  final String path;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? radius;

  /// Accessible description. Leave null for decorative images.
  final String? semanticLabel;

  const AppImage({
    super.key,
    required this.path,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.radius,
    this.semanticLabel,
  });

  static Set<String>? _assets;
  static Future<Set<String>>? _loading;

  static Future<Set<String>> _loadAssets() {
    return _loading ??= AssetManifest.loadFromAssetBundle(rootBundle)
        .then((m) => _assets = m.listAssets().toSet());
  }

  @override
  Widget build(BuildContext context) {
    final r = radius ?? BorderRadius.circular(12);
    return ClipRRect(
      borderRadius: r,
      child: SizedBox(
        width: width,
        height: height,
        child: path.isEmpty ? _fallback() : _resolve(),
      ),
    );
  }

  Widget _resolve() {
    final known = _assets;
    if (known != null) return known.contains(path) ? _image() : _fallback();
    return FutureBuilder<Set<String>>(
      future: _loadAssets(),
      builder: (context, snapshot) {
        if (snapshot.hasError) return _image(); // manifest unavailable: try anyway
        if (!snapshot.hasData) return _placeholder();
        return snapshot.data!.contains(path) ? _image() : _fallback();
      },
    );
  }

  Widget _image() => Image.asset(
        path,
        fit: fit,
        width: width,
        height: height,
        semanticLabel: semanticLabel,
        excludeFromSemantics: semanticLabel == null,
        errorBuilder: (_, __, ___) => _fallback(),
      );

  Widget _placeholder() => Container(color: AppColors.primaryLight);

  Widget _fallback() => Container(
        color: AppColors.primaryLight,
        alignment: Alignment.center,
        child: const ExcludeSemantics(
          child: Icon(
            Icons.image_outlined,
            size: 40,
            color: AppColors.primary,
          ),
        ),
      );
}
