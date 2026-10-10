import '../../models/project.dart';
import 'content_repository.dart';

abstract class ProjectRepository {
  Future<List<Project>> getProjects(String lang);
  Future<Project?> getById(String id, String lang);
}

class LocalProjectRepository implements ProjectRepository {
  final ContentRepository content;
  LocalProjectRepository(this.content);

  @override
  Future<List<Project>> getProjects(String lang) async {
    final data = await content.load();
    final section = (data['projects'] as Map).cast<String, dynamic>();
    final list = (section[lang] ?? section['en']) as List;
    return list.map((e) => Project.fromJson((e as Map).cast())).toList();
  }

  /// Returns `null` for an unknown id (previously fell back to the first
  /// project, so a mistyped URL silently showed the wrong project).
  @override
  Future<Project?> getById(String id, String lang) async {
    final all = await getProjects(lang);
    for (final p in all) {
      if (p.id == id) return p;
    }
    return null;
  }
}
