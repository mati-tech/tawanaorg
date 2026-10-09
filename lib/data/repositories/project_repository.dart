import '../../models/project.dart';
import 'content_repository.dart';

abstract class ProjectRepository {
  Future<List<Project>> getProjects();
  Future<Project?> getById(String id);
}

class LocalProjectRepository implements ProjectRepository {
  final ContentRepository content;
  LocalProjectRepository(this.content);

  Future<List<Project>> _all(String lang) async {
    final data = await content.load();
    final section = (data['projects'] as Map).cast<String, dynamic>();
    final list = (section[lang] ?? section['en']) as List;
    return list.map((e) => Project.fromJson((e as Map).cast())).toList();
  }

  @override
  Future<List<Project>> getProjects() async => _all('en');

  @override
  Future<Project?> getById(String id) async {
    final all = await _all('en');
    return all.firstWhere((p) => p.id == id, orElse: () => all.first);
  }
}