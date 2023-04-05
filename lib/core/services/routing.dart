import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:github_challenge/core/models/repository_model.dart';
import 'package:github_challenge/core/models/user_data.dart';
import 'package:github_challenge/modules/starred_repositories/starred_repositories_page.dart';

import '../../modules/home/home_page.dart';
import '../../modules/login/login_page.dart';
import '../../modules/saved_repositories/saved_repositories_page.dart';

enum AppRoutes { login, home, starredRep, savedRep }

final GoRouter routes = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  restorationScopeId: 'router',
  routes: [
    GoRoute(
      path: '/home',
      name: AppRoutes.home.name,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/starredRep',
      name: AppRoutes.starredRep.name,
      builder: (context, state) {
        final arguments = state.extra as Map<String, dynamic>;
        return StarredRepositoriesPage(
          starredRepositories:
              arguments['repositories'] as List<RepositoryModel>,
          user: arguments['user'] as UserData,
        );
      },
    ),
    GoRoute(
      path: '/savedRep',
      name: AppRoutes.savedRep.name,
      builder: (context, state) {
        final arguments = state.extra as Map<String, dynamic>;
        return SavedRepositoriesPage(
          user: arguments['user'] as UserData,
        );
      },
    ),
    GoRoute(
      path: '/',
      name: AppRoutes.login.name,
      builder: (context, state) => const LoginPage(),
    ),
  ],
  redirect: (context, state) {
    // if the user is not logged in, they need to login
    final bool loggedIn = FirebaseAuth.instance.currentUser != null;
    final bool loggingIn = state.subloc == '/';
    if (!loggedIn) {
      return '/';
    }

    // if the user is logged in but still on the login page, send them to
    // the home page
    if (loggingIn) {
      return '/home';
    }

    // no need to redirect at all
    return null;
  },
);
