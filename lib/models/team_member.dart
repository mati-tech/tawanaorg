class TeamMember {
  final String id;
  final String name;
  final String position;
  final String biography;
  final String photo;
  final String group;

  const TeamMember({
    required this.id,
    required this.name,
    required this.position,
    required this.biography,
    required this.photo,
    required this.group,
  });

  factory TeamMember.fromJson(Map<String, dynamic> j) => TeamMember(
    id: j['id'] as String,
    name: j['name'] as String,
    position: j['position'] as String? ?? '',
    biography: j['biography'] as String? ?? '',
    photo: j['photo'] as String? ?? '',
    group: j['group'] as String? ?? 'staff',
  );
}