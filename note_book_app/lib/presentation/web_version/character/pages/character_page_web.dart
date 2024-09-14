import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_book_app/common/colors/app_colors.dart';
import 'package:note_book_app/common/utils/responsive_util.dart';
import 'package:note_book_app/core/services/get_it_service.dart';
import 'package:note_book_app/presentation/web_version/character/cubits/character_page_web_cubit.dart';
import 'package:note_book_app/presentation/web_version/character/cubits/character_page_web_state.dart';
import 'package:note_book_app/presentation/web_version/character/cubits/character_question_phase_web_cubit.dart';
import 'package:note_book_app/presentation/web_version/character/widgets/action_button.dart';
import 'package:note_book_app/presentation/web_version/character/widgets/character_table.dart';
import 'package:note_book_app/presentation/web_version/character/widgets/question_phase_landing.dart';

class CharacterPageWeb extends StatefulWidget {
  const CharacterPageWeb({super.key});

  @override
  State<CharacterPageWeb> createState() => _CharacterPageWebState();
}

class _CharacterPageWebState extends State<CharacterPageWeb> {
  void _handleShowHiragana(BuildContext context) {
    context.read<CharacterPageWebCubit>().changeCharacterType(type: 'Hiragana');
  }

  void _handleShowKatakana(BuildContext context) {
    context.read<CharacterPageWebCubit>().changeCharacterType(type: 'Katakana');
  }

  void _handleStartQuestionsPhase(BuildContext context) {
    context.read<CharacterPageWebCubit>().startQuestionsPhase();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CharacterPageWebCubit>(
          create: (context) =>
              getIt<CharacterPageWebCubit>()..getAllCharacters(),
        ),
        BlocProvider(
          create: (context) => getIt<CharacterQuestionPhaseWebCubit>(),
        ),
      ],
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: ResponsiveUtil.isDesktop(context)
                    ? 100
                    : ResponsiveUtil.isTablet(context)
                        ? 40
                        : 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ActionButton(
                    text: 'Hiragana',
                    onPressed: _handleShowHiragana,
                  ),
                  const SizedBox(width: 16),
                  ActionButton(
                    text: 'Katakana',
                    onPressed: _handleShowKatakana,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ActionButton(
                    text: 'Ghi nhớ',
                    onPressed: _handleStartQuestionsPhase,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              BlocConsumer<CharacterPageWebCubit, CharacterPageWebState>(
                listener: (context, state) {
                  if (state is CharacterPageWebError) {}
                },
                builder: (context, state) {
                  if (state is CharacterPageWebLoading) {
                    return const SizedBox(
                      height: 400,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColors.kDFD3C3,
                        ),
                      ),
                    );
                  }
                  if (state is CharacterPageWebLoaded) {
                    return CharacterTable(
                      characters: state.characters,
                    );
                  }
                  if (state is QuestionPhase) {
                    return const QuestionPhaseLanding();
                  }
                  return const SizedBox();
                },
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
