import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_book_app/presentation/web_version/character/cubits/character_question_phase_web_cubit.dart';
import 'package:note_book_app/presentation/web_version/character/cubits/character_question_phase_web_state.dart';

class QuestionPhaseLanding extends StatefulWidget {
  const QuestionPhaseLanding({super.key});

  @override
  State<QuestionPhaseLanding> createState() => _QuestionPhaseLandingState();
}

class _QuestionPhaseLandingState extends State<QuestionPhaseLanding> {
  @override
  void initState() {
    context.read<CharacterQuestionPhaseWebCubit>().startPhase(
          answerType: "Romanji",
          numberOfQuestions: 10,
          questionType: "Hiragana",
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CharacterQuestionPhaseWebCubit,
        CharacterQuestionPhaseWebState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          width: 200,
          height: 200,
          color: Colors.red,
        );
      },
    );
  }
}
