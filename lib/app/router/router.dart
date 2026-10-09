import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:talker_flutter/talker_flutter.dart';
import '../../di/di.dart';            // для talker
import '../features/features.dart';  // для HomeScreen и MovieScreen

final _rootNavigationKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final router = GoRouter(
  observers: [TalkerRouteObserver(talker)],
  debugLogDiagnostics: true,
  initialLocation: '/home',
  navigatorKey: _rootNavigationKey,
  routes: [
    // Главный экран
    GoRoute(
      path: '/home',
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const HomeScreen(),
      ),
    ),
    // Детальный экран фильма
    GoRoute(
      path: '/movie/:id',
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: MovieScreen(movieId: state.pathParameters['id']!),
      ),
    ),
  ],
);