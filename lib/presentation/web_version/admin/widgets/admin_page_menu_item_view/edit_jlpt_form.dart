import 'package:flutter/material.dart';
import 'package:note_book_app/domain/entities/level_entity.dart';

class EditJlptForm extends StatefulWidget{
  final LevelEntity jlpt;

  const EditJlptForm({super.key, required this.jlpt});

  @override
  State<EditJlptForm> createState() => _EditJlptFormState();
}

class _EditJlptFormState extends State<EditJlptForm> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}