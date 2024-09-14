import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_book_app/common/colors/app_colors.dart';
import 'package:note_book_app/common/utils/responsive_util.dart';
import 'package:note_book_app/presentation/web_version/character/cubits/character_question_phase_web_cubit.dart';
import 'package:note_book_app/presentation/web_version/character/cubits/character_question_phase_web_state.dart';
import 'package:note_book_app/presentation/web_version/character/widgets/answer_button.dart';

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
    return Column(
      children: [
        const SizedBox(height: 32),
        BlocBuilder<CharacterQuestionPhaseWebCubit,
            CharacterQuestionPhaseWebState>(
          builder: (context, state) {
            int currentQuestion =
                context.read<CharacterQuestionPhaseWebCubit>().currentQuestion;
            int maxQuestion =
                context.read<CharacterQuestionPhaseWebCubit>().questions.length;
            return Text(
              'Câu $currentQuestion/$maxQuestion',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: ResponsiveUtil.isDesktop(context)
                    ? 24
                    : ResponsiveUtil.isTablet(context)
                        ? 20
                        : 12,
                color: AppColors.kF8EDE3.withOpacity(0.8),
              ),
            );
          },
        ),
        BlocBuilder<CharacterQuestionPhaseWebCubit,
            CharacterQuestionPhaseWebState>(
          builder: (context, state) {
            int correctQuestions =
                context.read<CharacterQuestionPhaseWebCubit>().correctAnswers;
            int maxQuestion =
                context.read<CharacterQuestionPhaseWebCubit>().questions.length;
            return Text(
              'Số câu đúng $correctQuestions/$maxQuestion',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: ResponsiveUtil.isDesktop(context)
                    ? 24
                    : ResponsiveUtil.isTablet(context)
                        ? 20
                        : 12,
                color: AppColors.kF8EDE3.withOpacity(0.8),
              ),
            );
          },
        ),
        const SizedBox(height: 8),
        BlocConsumer<CharacterQuestionPhaseWebCubit,
            CharacterQuestionPhaseWebState>(
          listener: (context, state) {
            if (state is CharacterQuestionPhaseWebError) {}
          },
          buildWhen: (previous, current) =>
              current is CharacterQuestionPhaseWebLoaded ||
              current is CharacterQuestionPhaseWebLoading,
          builder: (context, state) {
            if (state is CharacterQuestionPhaseWebLoading) {
              return const SizedBox(
                height: 400,
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppColors.kDFD3C3,
                  ),
                ),
              );
            }
            if (state is CharacterQuestionPhaseWebLoaded) {
              return Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                margin: EdgeInsets.only(
                  left: ResponsiveUtil.isMobile(context) ? 16 : 0,
                  right: ResponsiveUtil.isMobile(context) ? 16 : 0,
                ),
                width: 600,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            state.question.question,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: ResponsiveUtil.isDesktop(context)
                                  ? 32
                                  : ResponsiveUtil.isTablet(context)
                                      ? 24
                                      : 16,
                              color: AppColors.black.withOpacity(0.8),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                        height: ResponsiveUtil.isMobile(context) ? 16 : 32),
                    if (!ResponsiveUtil.isMobile(context))
                      Row(
                        children: [
                          Expanded(
                            child:
                                AnswerButton(answer: state.question.answers[0]),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child:
                                AnswerButton(answer: state.question.answers[1]),
                          ),
                        ],
                      ),
                    if (!ResponsiveUtil.isMobile(context))
                      const SizedBox(height: 16),
                    if (!ResponsiveUtil.isMobile(context))
                      Row(
                        children: [
                          Expanded(
                            child:
                                AnswerButton(answer: state.question.answers[2]),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child:
                                AnswerButton(answer: state.question.answers[3]),
                          ),
                        ],
                      ),
                    if (ResponsiveUtil.isMobile(context))
                      Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: AnswerButton(
                                    answer: state.question.answers[0]),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: AnswerButton(
                                    answer: state.question.answers[1]),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: AnswerButton(
                                    answer: state.question.answers[2]),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: AnswerButton(
                                    answer: state.question.answers[3]),
                              ),
                            ],
                          ),
                        ],
                      ),
                  ],
                ),
              );
            }
            if (state is CharacterQuestionPhaseWebEnd) {}
            return const SizedBox();
          },
        ),
        BlocBuilder<CharacterQuestionPhaseWebCubit,
            CharacterQuestionPhaseWebState>(
          builder: (context, state) {
            if (state is CharacterQuestionPhaseWebCorrectAnswer ||
                state is CharacterQuestionPhaseWebWrongAnswer ||
                state is CharacterQuestionPhaseWebEnd) {
              return Padding(
                padding: EdgeInsets.only(
                  top: ResponsiveUtil.isMobile(context) ? 16 : 32,
                ),
                child: ElevatedButton(
                  style: ButtonStyle(
                    padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(
                      EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                    ),
                    shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    overlayColor: WidgetStatePropertyAll(
                        AppColors.black.withOpacity(0.08)),
                    backgroundColor:
                        const WidgetStatePropertyAll(AppColors.kF8EDE3),
                  ),
                  onPressed: () {
                    if (state is CharacterQuestionPhaseWebEnd) {
                      context.read<CharacterQuestionPhaseWebCubit>().startPhase(
                            answerType: "Romanji",
                            numberOfQuestions: 10,
                            questionType: "Hiragana",
                          );
                      return;
                    }
                    context
                        .read<CharacterQuestionPhaseWebCubit>()
                        .nextQuestion();
                  },
                  child: Text(
                    context.read<CharacterQuestionPhaseWebCubit>().currentQuestion ==
                            context
                                .read<CharacterQuestionPhaseWebCubit>()
                                .questions
                                .length
                        ? "Làm lại"
                        : "Câu tiếp theo",
                    style: TextStyle(
                      fontSize: ResponsiveUtil.isDesktop(context)
                          ? 24
                          : ResponsiveUtil.isTablet(context)
                              ? 20
                              : 12,
                      color: AppColors.black.withOpacity(0.4),
                    ),
                  ),
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ],
    );
  }
}
