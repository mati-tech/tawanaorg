import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

/// V1: loads a single static JSON file with all content in all languages.
/// To migrate to a backend later, replace this with an API implementation.
abstract class ContentRepository {
  Future<Map<String, dynamic>> load();
}

class StaticContentRepository implements ContentRepository {
  static const _path = 'assets/content/content.json';
  Map<String, dynamic>? _cache;

  @override
  Future<Map<String, dynamic>> load() async {
    if (_cache != null) return _cache!;
    final raw = await rootBundle.loadString(_path);
    _cache = jsonDecode(raw) as Map<String, dynamic>;
    return _cache!;
  }
}