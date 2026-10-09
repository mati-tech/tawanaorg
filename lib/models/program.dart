class Program {
  final String id;
  final String title;
  final String description;
  final String objectives;
  final String impact;

  const Program({
    required this.id,
    required this.title,
    required this.description,
    required this.objectives,
    required this.impact,
  });

  factory Program.fromJson(Map<String, dynamic> j) => Program(
    id: j['id'] as String,
    title: j['title'] as String,
    description: j['description'] as String? ?? '',
    objectives: j['objectives'] as String? ?? '',
    impact: j['impact'] as String? ?? '',
  );
}