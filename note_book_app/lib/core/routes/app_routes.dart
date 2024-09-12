import 'package:go_router/go_router.dart';
import 'package:note_book_app/presentation/web/home/pages/home_page_web.dart';
import 'package:note_book_app/presentation/web/level/pages/level_page_web.dart';
import 'package:note_book_app/presentation/web/not_found/pages/not_found_page_web.dart';

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
          pageBuilder: (context, state) => NoTransitionPage(
            child: HomePageWeb(),
            key: state.pageKey,
          ),
          routes: [
            GoRoute(
              path: ":level",
              pageBuilder: (context, state) {
                return NoTransitionPage(
                  child: LevelPageWeb(),
                  key: state.pageKey,
                );
              },
            ),
          ],
        ),
      ],
      errorBuilder: (context, state) => const NotFoundPageWeb(),
    );
  }
}
