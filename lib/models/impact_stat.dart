class ImpactStat {
  final String label;
  final String value;
  const ImpactStat({required this.label, required this.value});
  factory ImpactStat.fromJson(Map<String, dynamic> j) =>
      ImpactStat(label: j['label'] as String, value: j['value'] as String);
}

class ImpactStory {
  final String title;
  final String text;
  const ImpactStory({required this.title, required this.text});
  factory ImpactStory.fromJson(Map<String, dynamic> j) =>
      ImpactStory(title: j['title'] as String, text: j['text'] as String);
}