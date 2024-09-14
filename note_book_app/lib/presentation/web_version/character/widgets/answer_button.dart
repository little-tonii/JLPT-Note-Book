import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_book_app/common/colors/app_colors.dart';
import 'package:note_book_app/common/utils/responsive_util.dart';
import 'package:note_book_app/presentation/web_version/character/cubits/character_question_phase_web_cubit.dart';

class AnswerButton extends StatelessWidget {
  final String answer;

  const AnswerButton({super.key, required this.answer});

  void _handleAnswer(BuildContext context) {
    context
        .read<CharacterQuestionPhaseWebCubit>()
        .answerQuestion(answer: answer);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        padding: WidgetStatePropertyAll<EdgeInsetsGeometry>(
          EdgeInsets.symmetric(
            vertical: ResponsiveUtil.isMobile(context) ? 16 : 20,
          ),
        ),
        shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
            side: BorderSide(
              color: AppColors.black.withOpacity(0.4),
              width: 2,
            ),
          ),
        ),
        overlayColor: WidgetStatePropertyAll(AppColors.black.withOpacity(0.08)),
        backgroundColor: const WidgetStatePropertyAll(AppColors.kF8EDE3),
      ),
      onPressed: () => _handleAnswer(context),
      child: Text(
        answer,
        style: TextStyle(
          fontSize: ResponsiveUtil.isDesktop(context)
              ? 32
              : ResponsiveUtil.isTablet(context)
                  ? 24
                  : 16,
          color: AppColors.black.withOpacity(0.4),
        ),
      ),
    );
  }
}
