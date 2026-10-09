import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/home/home_page.dart';
import '../features/about/about_page.dart';
import '../features/programs/programs_page.dart';
import '../features/projects/projects_page.dart';
import '../features/projects/project_details_page.dart';
import '../features/impact/impact_page.dart';
import '../features/news/news_page.dart';
import '../features/news/news_details_page.dart';
import '../features/team/team_page.dart';
import '../features/transparency/transparency_page.dart';
import '../features/get_involved/get_involved_page.dart';
import '../features/donate/donate_page.dart';
import '../features/contact/contact_page.dart';
import '../features/error/not_found_page.dart';

final _rootKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootKey,
    initialLocation: '/',
    errorBuilder: (context, state) => const NotFoundPage(),
    routes: [
      GoRoute(path: '/', builder: (_, __) => const HomePage()),
      GoRoute(path: '/about', builder: (_, __) => const AboutPage()),
      GoRoute(path: '/programs', builder: (_, __) => const ProgramsPage()),
      GoRoute(
        path: '/projects',
        builder: (_, __) => const ProjectsPage(),
        routes: [
          GoRoute(
            path: ':id',
            builder: (_, state) =>
                ProjectDetailsPage(id: state.pathParameters['id']!),
          ),
        ],
      ),
      GoRoute(path: '/impact', builder: (_, __) => const ImpactPage()),
      GoRoute(
        path: '/news',
        builder: (_, __) => const NewsPage(),
        routes: [
          GoRoute(
            path: ':id',
            builder: (_, state) =>
                NewsDetailsPage(id: state.pathParameters['id']!),
          ),
        ],
      ),
      GoRoute(path: '/team', builder: (_, __) => const TeamPage()),
      GoRoute(
          path: '/transparency',
          builder: (_, __) => const TransparencyPage()),
      GoRoute(
          path: '/get-involved',
          builder: (_, __) => const GetInvolvedPage()),
      GoRoute(path: '/donate', builder: (_, __) => const DonatePage()),
      GoRoute(path: '/contact', builder: (_, __) => const ContactPage()),
    ],
  );
});