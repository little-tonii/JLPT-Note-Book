import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_book_app/core/services/get_it_service.dart';
import 'package:note_book_app/presentation/web_version/character/cubits/character_page_web_cubit.dart';

class CharacterPageWeb extends StatefulWidget {
  const CharacterPageWeb({super.key});

  @override
  State<CharacterPageWeb> createState() => _CharacterPageWebState();
}

class _CharacterPageWebState extends State<CharacterPageWeb> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CharacterPageWebCubit>(
      create: (context) => getIt<CharacterPageWebCubit>(),
      child: Scaffold(),
    );
  }
}
