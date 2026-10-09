class Project {
  final String id;
  final String title;
  final String description;
  final String longDescription;
  final String challenge;
  final String approach;
  final String results;
  final String category;
  final String location;
  final String status;
  final String image;
  final int beneficiaries;
  final double progress;
  final String goal;
  final String startDate;

  const Project({
    required this.id,
    required this.title,
    required this.description,
    required this.longDescription,
    required this.challenge,
    required this.approach,
    required this.results,
    required this.category,
    required this.location,
    required this.status,
    required this.image,
    required this.beneficiaries,
    required this.progress,
    required this.goal,
    required this.startDate,
  });

  factory Project.fromJson(Map<String, dynamic> j) => Project(
    id: j['id'] as String,
    title: j['title'] as String,
    description: j['description'] as String? ?? '',
    longDescription: j['longDescription'] as String? ?? '',
    challenge: j['challenge'] as String? ?? '',
    approach: j['approach'] as String? ?? '',
    results: j['results'] as String? ?? '',
    category: j['category'] as String? ?? '',
    location: j['location'] as String? ?? '',
    status: j['status'] as String? ?? 'active',
    image: j['image'] as String? ?? '',
    beneficiaries: j['beneficiaries'] as int? ?? 0,
    progress: (j['progress'] as num?)?.toDouble() ?? 0,
    goal: j['goal'] as String? ?? '',
    startDate: j['startDate'] as String? ?? '',
  );
}