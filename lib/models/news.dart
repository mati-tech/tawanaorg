class NewsArticle {
  final String id;
  final String title;
  final String summary;
  final String content;
  final String image;
  final DateTime date;
  final String category;

  const NewsArticle({
    required this.id,
    required this.title,
    required this.summary,
    required this.content,
    required this.image,
    required this.date,
    required this.category,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> j) => NewsArticle(
    id: j['id'] as String,
    title: j['title'] as String,
    summary: j['summary'] as String? ?? '',
    content: j['content'] as String? ?? '',
    image: j['image'] as String? ?? '',
    date: DateTime.tryParse(j['date'] as String? ?? '') ?? DateTime.now(),
    category: j['category'] as String? ?? '',
  );
}