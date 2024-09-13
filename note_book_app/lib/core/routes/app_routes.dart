import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:note_book_app/presentation/web_version/home/pages/home_page_web.dart';
import 'package:note_book_app/presentation/web_version/level/pages/level_page_web.dart';
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
            WidgetsBinding.instance.addPostFrameCallback((_) {
              SystemChrome.setApplicationSwitcherDescription(
                const ApplicationSwitcherDescription(
                  label: "JNPT Note Book",
                ),
              );
            });
            return NoTransitionPage(
              child: const HomePageWeb(),
              key: state.pageKey,
            );
          },
        ),
        GoRoute(
          path: "/home/:level",
          pageBuilder: (context, state) {
            final level = state.pathParameters['level'];
            WidgetsBinding.instance.addPostFrameCallback((_) {
              SystemChrome.setApplicationSwitcherDescription(
                ApplicationSwitcherDescription(
                  label: level,
                ),
              );
            });
            return NoTransitionPage(
              child: LevelPageWeb(
                level: level!,
              ),
              key: state.pageKey,
            );
          },
        ),
      ],
      errorPageBuilder: (context, state) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          SystemChrome.setApplicationSwitcherDescription(
            const ApplicationSwitcherDescription(
              label: "Page Not Found",
            ),
          );
        });
        return NoTransitionPage(
          child: const NotFoundPageWeb(),
          key: state.pageKey,
        );
      },
    );
  }
}
