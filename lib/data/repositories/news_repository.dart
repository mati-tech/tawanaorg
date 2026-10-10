import '../../models/news.dart';
import 'content_repository.dart';

abstract class NewsRepository {
  Future<List<NewsArticle>> getNews(String lang);
  Future<NewsArticle?> getById(String id, String lang);
}

class LocalNewsRepository implements NewsRepository {
  final ContentRepository content;
  LocalNewsRepository(this.content);

  @override
  Future<List<NewsArticle>> getNews(String lang) async {
    final data = await content.load();
    final section = (data['news'] as Map).cast<String, dynamic>();
    final list = (section[lang] ?? section['en']) as List;
    return list.map((e) => NewsArticle.fromJson((e as Map).cast())).toList();
  }

  /// Returns `null` for an unknown id (previously fell back to the first
  /// article).
  @override
  Future<NewsArticle?> getById(String id, String lang) async {
    final all = await getNews(lang);
    for (final n in all) {
      if (n.id == id) return n;
    }
    return null;
  }
}
