import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../app/app.dart';
import '../models/impact_stat.dart';
import '../models/news.dart';
import '../models/program.dart';
import '../models/project.dart';
import '../models/team_member.dart';
import 'repositories/content_repository.dart';
import 'repositories/news_repository.dart';
import 'repositories/project_repository.dart';
import 'repositories/team_repository.dart';

final contentRepositoryProvider =
Provider<ContentRepository>((ref) => StaticContentRepository());

final projectRepositoryProvider = Provider<ProjectRepository>(
        (ref) => LocalProjectRepository(ref.read(contentRepositoryProvider)));

final newsRepositoryProvider = Provider<NewsRepository>(
        (ref) => LocalNewsRepository(ref.read(contentRepositoryProvider)));

final teamRepositoryProvider = Provider<TeamRepository>(
        (ref) => LocalTeamRepository(ref.read(contentRepositoryProvider)));

final currentLangProvider =
Provider<String>((ref) => ref.watch(localeProvider).languageCode);

final projectsProvider = FutureProvider<List<Project>>((ref) async {
  final lang = ref.watch(currentLangProvider);
  return ref.read(projectRepositoryProvider).getProjects(lang);
});

final projectProvider =
    FutureProvider.family<Project?, String>((ref, id) async {
  final lang = ref.watch(currentLangProvider);
  return ref.read(projectRepositoryProvider).getById(id, lang);
});

final newsProvider = FutureProvider<List<NewsArticle>>((ref) async {
  final lang = ref.watch(currentLangProvider);
  return ref.read(newsRepositoryProvider).getNews(lang);
});

final newsArticleProvider =
    FutureProvider.family<NewsArticle?, String>((ref, id) async {
  final lang = ref.watch(currentLangProvider);
  return ref.read(newsRepositoryProvider).getById(id, lang);
});

final teamProvider = FutureProvider<List<TeamMember>>((ref) async {
  final lang = ref.watch(currentLangProvider);
  return ref.read(teamRepositoryProvider).getMembers(lang);
});

final programsProvider = FutureProvider<List<Program>>((ref) async {
  final lang = ref.watch(currentLangProvider);
  final data = await ref.read(contentRepositoryProvider).load();
  final section = (data['programs'] as Map).cast<String, dynamic>();
  final list = (section[lang] ?? section['en']) as List;
  return list.map((e) => Program.fromJson((e as Map).cast())).toList();
});

final impactStatsProvider = FutureProvider<List<ImpactStat>>((ref) async {
  final lang = ref.watch(currentLangProvider);
  final data = await ref.read(contentRepositoryProvider).load();
  final section =
  ((data['impact'] as Map)[lang] ?? (data['impact'] as Map)['en'])
  as Map;
  final list = (section['stats'] as List);
  return list.map((e) => ImpactStat.fromJson((e as Map).cast())).toList();
});

final impactStoriesProvider = FutureProvider<List<ImpactStory>>((ref) async {
  final lang = ref.watch(currentLangProvider);
  final data = await ref.read(contentRepositoryProvider).load();
  final section =
  ((data['impact'] as Map)[lang] ?? (data['impact'] as Map)['en'])
  as Map;
  final list = (section['stories'] as List);
  return list.map((e) => ImpactStory.fromJson((e as Map).cast())).toList();
});

final aboutProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final lang = ref.watch(currentLangProvider);
  final data = await ref.read(contentRepositoryProvider).load();
  final section = (data['about'] as Map).cast<String, dynamic>();
  return (section[lang] ?? section['en']) as Map<String, dynamic>;
});

final reportsProvider =
FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final lang = ref.watch(currentLangProvider);
  final data = await ref.read(contentRepositoryProvider).load();
  final section = (data['reports'] as Map).cast<String, dynamic>();
  final list = (section[lang] ?? section['en']) as List;
  return list.map((e) => (e as Map).cast<String, dynamic>()).toList();
});