import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class LevelPageWeb extends StatelessWidget {
  const LevelPageWeb({super.key});

  @override
  Widget build(BuildContext context) {
    final level = GoRouterState.of(context).pathParameters['level'];

    WidgetsBinding.instance.addPostFrameCallback((_) {
      SystemChrome.setApplicationSwitcherDescription(
        ApplicationSwitcherDescription(
          label: "$level",
        ),
      );
    });

    return Scaffold();
  }
}
