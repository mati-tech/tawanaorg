import '../../models/news.dart';
import 'content_repository.dart';

abstract class NewsRepository {
  Future<List<NewsArticle>> getNews();
  Future<NewsArticle?> getById(String id);
}

class LocalNewsRepository implements NewsRepository {
  final ContentRepository content;
  LocalNewsRepository(this.content);

  Future<List<NewsArticle>> _all(String lang) async {
    final data = await content.load();
    final section = (data['news'] as Map).cast<String, dynamic>();
    final list = (section[lang] ?? section['en']) as List;
    return list.map((e) => NewsArticle.fromJson((e as Map).cast())).toList();
  }

  @override
  Future<List<NewsArticle>> getNews() async => _all('en');

  @override
  Future<NewsArticle?> getById(String id) async {
    final all = await _all('en');
    return all.firstWhere((n) => n.id == id, orElse: () => all.first);
  }
}