import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_book_app/common/colors/app_colors.dart';
import 'package:note_book_app/common/utils/responsive_util.dart';
import 'package:note_book_app/presentation/web_version/character/cubits/character_question_phase_web_cubit.dart';
import 'package:note_book_app/presentation/web_version/character/cubits/character_question_phase_web_state.dart';

class AnswerButton extends StatefulWidget {
  final String answer;

  const AnswerButton({super.key, required this.answer});

  @override
  State<AnswerButton> createState() => _AnswerButtonState();
}

class _AnswerButtonState extends State<AnswerButton> {
  int status = -1;

  void _handleAnswer(BuildContext context) {
    context
        .read<CharacterQuestionPhaseWebCubit>()
        .answerQuestion(answer: widget.answer);
  }

  @override
  void didUpdateWidget(covariant AnswerButton oldWidget) {
    if (oldWidget.answer != widget.answer) {
      setState(() {
        status = -1;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CharacterQuestionPhaseWebCubit,
        CharacterQuestionPhaseWebState>(
      listener: (context, state) {
        if (context.read<CharacterQuestionPhaseWebCubit>().currentAnswer ==
            widget.answer) {
          if (state is CharacterQuestionPhaseWebCorrectAnswer) {
            setState(() {
              status = 1;
            });
          } else if (state is CharacterQuestionPhaseWebWrongAnswer) {
            setState(() {
              status = 0;
            });
          }
        }
      },
      child: ElevatedButton(
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
                color: status == 1
                    ? AppColors.correctChoice
                    : status == 0
                        ? AppColors.wrongChoice
                        : AppColors.black.withOpacity(0.4),
                width: 2,
              ),
            ),
          ),
          overlayColor:
              WidgetStatePropertyAll(AppColors.black.withOpacity(0.08)),
          backgroundColor: const WidgetStatePropertyAll(AppColors.kF8EDE3),
        ),
        onPressed: () => _handleAnswer(context),
        child: Text(
          widget.answer,
          style: TextStyle(
            fontSize: ResponsiveUtil.isDesktop(context)
                ? 32
                : ResponsiveUtil.isTablet(context)
                    ? 24
                    : 16,
            color: AppColors.black.withOpacity(0.4),
          ),
        ),
      ),
    );
  }
}
