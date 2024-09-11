import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const NoteBookApp());
}

class NoteBookApp extends StatelessWidget {
  const NoteBookApp({super.key});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return MaterialApp();
    }
    return MaterialApp();
  }
}
