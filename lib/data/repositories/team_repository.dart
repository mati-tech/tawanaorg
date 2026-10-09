import '../../models/team_member.dart';
import 'content_repository.dart';

abstract class TeamRepository {
  Future<List<TeamMember>> getMembers(String lang);
}

class LocalTeamRepository implements TeamRepository {
  final ContentRepository content;
  LocalTeamRepository(this.content);

  @override
  Future<List<TeamMember>> getMembers(String lang) async {
    final data = await content.load();
    final section = (data['team'] as Map).cast<String, dynamic>();
    final list = (section[lang] ?? section['en']) as List;
    return list.map((e) => TeamMember.fromJson((e as Map).cast())).toList();
  }
}