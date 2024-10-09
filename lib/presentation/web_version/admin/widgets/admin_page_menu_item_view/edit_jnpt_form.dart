import 'package:flutter/material.dart';
import 'package:note_book_app/domain/entities/level_entity.dart';

class EditJnptForm extends StatefulWidget{
  final LevelEntity jnpt;

  const EditJnptForm({super.key, required this.jnpt});

  @override
  State<EditJnptForm> createState() => _EditJnptFormState();
}

class _EditJnptFormState extends State<EditJnptForm> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}