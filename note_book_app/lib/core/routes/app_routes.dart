import 'package:go_router/go_router.dart';
import 'package:note_book_app/presentation/web_version/home/home_page_web.dart';
import 'package:note_book_app/presentation/web_version/lesson/decision_render.dart';
import 'package:note_book_app/presentation/web_version/level/level_page_web.dart';
import 'package:note_book_app/presentation/web_version/not_found/pages/not_found_page_web.dart';

abstract class AppRoutes {
  static GoRouter goRouterConfig() {
    return GoRouter(
      initialLocation: "/",
      routes: [
        GoRoute(
          path: "/",
          redirect: (context, state) => "/home",
        ),
        GoRoute(
          path: "/home",
          pageBuilder: (context, state) {
            return NoTransitionPage(
              child: const HomePageWeb(),
              key: state.pageKey,
            );
          },
        ),
        GoRoute(
          path: '/home/:levelId',
          pageBuilder: (context, state) {
            return NoTransitionPage(
              child: const LevelPageWeb(),
              key: state.pageKey,
            );
          },
        ),
        GoRoute(
          path: '/home/:levelId/:lessonId',
          pageBuilder: (context, state) {
            return NoTransitionPage(
              child: const DecisionRender(),
              key: state.pageKey,
            );
          },
        ),
      ],
      errorPageBuilder: (context, state) {
        return NoTransitionPage(
          child: const NotFoundPageWeb(),
          key: state.pageKey,
        );
      },
    );
  }
}
