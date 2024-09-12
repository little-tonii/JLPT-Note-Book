import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:note_book_app/common/themes/app_themes.dart';
import 'package:note_book_app/core/routes/app_routes.dart';
import 'package:note_book_app/core/services/get_it_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const NoteBookApp());
}

class NoteBookApp extends StatelessWidget {
  const NoteBookApp({super.key});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return MaterialApp.router(
        theme: AppThemes.defaultTheme,
        debugShowCheckedModeBanner: false,
        title: "JNPT Note Book",
        routerConfig: AppRoutes.goRouterConfig(),
      );
    }
    return MaterialApp();
  }
}
