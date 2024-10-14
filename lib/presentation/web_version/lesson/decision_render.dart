import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:note_book_app/common/colors/app_colors.dart';
import 'package:note_book_app/common/utils/responsive_util.dart';
import 'package:note_book_app/core/services/get_it_service.dart';
import 'package:note_book_app/domain/entities/question_entity.dart';
import 'package:note_book_app/domain/usecases/word/create_word_question_usecase.dart';
import 'package:note_book_app/presentation/web_version/lesson/character_page_web.dart';
import 'package:note_book_app/presentation/web_version/lesson/cubits/decision_render/decision_render_cubit.dart';
import 'package:note_book_app/presentation/web_version/lesson/cubits/decision_render/decision_render_state.dart';
import 'package:note_book_app/presentation/web_version/lesson/kanji_page_web.dart';

class DecisionRender extends StatelessWidget {
  const DecisionRender({super.key});

  @override
  Widget build(BuildContext context) {
    final lessonId = GoRouterState.of(context).pathParameters['lessonId']!;

    return BlocProvider<DecisionRenderCubit>(
      create: (context) =>
          getIt<DecisionRenderCubit>()..makeDecision(lessonId: lessonId),
      child: BlocConsumer<DecisionRenderCubit, DecisionRenderState>(
        listener: (context, state) {
          if (state is DecisionRenderFailure) {}
        },
        builder: (context, state) {
          if (state is DecisionRenderCharacterPageWeb) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              SystemChrome.setApplicationSwitcherDescription(
                ApplicationSwitcherDescription(
                  label: '${state.level.level} | ${state.lesson.lesson}',
                ),
              );
            });
            return CharacterPageWeb(lesson: state.lesson);
          }
          if (state is DecisionRenderKanjiPageWeb) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              SystemChrome.setApplicationSwitcherDescription(
                ApplicationSwitcherDescription(
                  label: '${state.level.level} | ${state.lesson.lesson}',
                ),
              );
            });
            return KanjiPageWeb(lesson: state.lesson);
          }
          if (state is DecisionRenderLessonPageWeb) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              SystemChrome.setApplicationSwitcherDescription(
                ApplicationSwitcherDescription(
                  label: '${state.level.level} | ${state.lesson.lesson}',
                ),
              );
            });
            return BlocProvider<TempCubit>(
              create: (context) => TempCubit(),
              child: Temp(),
            );
          }
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: AppColors.kDFD3C3,
              ),
            ),
          );
        },
      ),
    );
  }
}

class Temp extends StatefulWidget {
  const Temp({super.key});

  @override
  State<Temp> createState() => _TempState();
}

class _TempState extends State<Temp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final lessonId = GoRouterState.of(context).pathParameters['lessonId']!;
    final levelId = GoRouterState.of(context).pathParameters['levelId']!;
    context.read<TempCubit>().init(
          lessonId: lessonId,
          levelId: levelId,
          questionType: 'meaning',
          answerType: 'word',
        );
    return Scaffold(
      body: Center(
        child: BlocBuilder<TempCubit, TempState>(
          builder: (context, state) {
            if (state is TempLoaded) {
              final correctAnswerIndex = state
                  .questions[state.currentQuestionIndex].answers
                  .indexOf(state
                      .questions[state.currentQuestionIndex].correctAnswer);
              return ResponsiveUtil.isMobile(context)
                  ? _mobileRender(
                      state: state,
                      correctAnswerIndex: correctAnswerIndex,
                    )
                  : Container(
                      padding: EdgeInsets.all(16),
                      width: ResponsiveUtil.isDesktop(context)
                          ? 600
                          : ResponsiveUtil.isTablet(context)
                              ? 800
                              : double.infinity,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: AppColors.kF8EDE3,
                              ),
                              height:
                                  ResponsiveUtil.isDesktop(context) ? 180 : 120,
                              width: double.infinity,
                              child: Center(
                                child: Text(
                                  state.questions[state.currentQuestionIndex]
                                      .question,
                                  style: TextStyle(
                                    fontSize:
                                        ResponsiveUtil.isDesktop(context) ||
                                                ResponsiveUtil.isTablet(context)
                                            ? 24
                                            : 20,
                                    color: AppColors.black.withOpacity(0.4),
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            SizedBox(height: 16),
                            IntrinsicHeight(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                    child: _answerChoice(
                                      color: state.isAnswered &&
                                              state.selectedAnswerIndex == 0
                                          ? state.isCorrect
                                              ? AppColors.successColor
                                              : AppColors.failureColor
                                          : correctAnswerIndex == 0 &&
                                                  state.isAnswered
                                              ? AppColors.successColor
                                              : null,
                                      onPressed: () {
                                        if (state.isAnswered == false) {
                                          context
                                              .read<TempCubit>()
                                              .answerQuestion(
                                                answer: state
                                                    .questions[state
                                                        .currentQuestionIndex]
                                                    .answers[0],
                                              );
                                        }
                                      },
                                      answer: state
                                          .questions[state.currentQuestionIndex]
                                          .answers[0],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Expanded(
                                    child: _answerChoice(
                                      color: state.isAnswered &&
                                              state.selectedAnswerIndex == 1
                                          ? state.isCorrect
                                              ? AppColors.successColor
                                              : AppColors.failureColor
                                          : correctAnswerIndex == 1 &&
                                                  state.isAnswered
                                              ? AppColors.successColor
                                              : null,
                                      onPressed: () {
                                        if (!state.isAnswered) {
                                          context
                                              .read<TempCubit>()
                                              .answerQuestion(
                                                answer: state
                                                    .questions[state
                                                        .currentQuestionIndex]
                                                    .answers[1],
                                              );
                                        }
                                      },
                                      answer: state
                                          .questions[state.currentQuestionIndex]
                                          .answers[1],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 16),
                            IntrinsicHeight(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                    child: _answerChoice(
                                      color: state.isAnswered &&
                                              state.selectedAnswerIndex == 2
                                          ? state.isCorrect
                                              ? AppColors.successColor
                                              : AppColors.failureColor
                                          : correctAnswerIndex == 2 &&
                                                  state.isAnswered
                                              ? AppColors.successColor
                                              : null,
                                      onPressed: () {
                                        if (!state.isAnswered) {
                                          context
                                              .read<TempCubit>()
                                              .answerQuestion(
                                                answer: state
                                                    .questions[state
                                                        .currentQuestionIndex]
                                                    .answers[2],
                                              );
                                        }
                                      },
                                      answer: state
                                          .questions[state.currentQuestionIndex]
                                          .answers[2],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Expanded(
                                    child: _answerChoice(
                                      color: state.isAnswered &&
                                              state.selectedAnswerIndex == 3
                                          ? state.isCorrect
                                              ? AppColors.successColor
                                              : AppColors.failureColor
                                          : correctAnswerIndex == 3 &&
                                                  state.isAnswered
                                              ? AppColors.successColor
                                              : null,
                                      onPressed: () {
                                        if (!state.isAnswered) {
                                          context
                                              .read<TempCubit>()
                                              .answerQuestion(
                                                answer: state
                                                    .questions[state
                                                        .currentQuestionIndex]
                                                    .answers[3],
                                              );
                                        }
                                      },
                                      answer: state
                                          .questions[state.currentQuestionIndex]
                                          .answers[3],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
            }
            if (state is TempFinished) {
              return _answerChoice(
                answer: 'Bắt đầu lại',
                onPressed: () {
                  context.read<TempCubit>().init(
                        lessonId: lessonId,
                        levelId: levelId,
                        questionType: 'meaning',
                        answerType: 'word',
                      );
                },
              );
            }
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.kDFD3C3,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _mobileRender(
      {required TempLoaded state, required int correctAnswerIndex}) {
    return Container(
      padding: EdgeInsets.all(16),
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.kF8EDE3,
              ),
              height: ResponsiveUtil.isDesktop(context) ? 180 : 120,
              width: double.infinity,
              child: Center(
                child: Text(
                  state.questions[state.currentQuestionIndex].question,
                  style: TextStyle(
                    fontSize: ResponsiveUtil.isDesktop(context) ||
                            ResponsiveUtil.isTablet(context)
                        ? 24
                        : 20,
                    color: AppColors.black.withOpacity(0.4),
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 24),
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: _answerChoice(
                      color: state.isAnswered && state.selectedAnswerIndex == 0
                          ? state.isCorrect
                              ? AppColors.successColor
                              : AppColors.failureColor
                          : correctAnswerIndex == 0 && state.isAnswered
                              ? AppColors.successColor
                              : null,
                      onPressed: () {
                        if (state.isAnswered == false) {
                          context.read<TempCubit>().answerQuestion(
                                answer: state
                                    .questions[state.currentQuestionIndex]
                                    .answers[0],
                              );
                        }
                      },
                      answer: state
                          .questions[state.currentQuestionIndex].answers[0],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: _answerChoice(
                      color: state.isAnswered && state.selectedAnswerIndex == 1
                          ? state.isCorrect
                              ? AppColors.successColor
                              : AppColors.failureColor
                          : correctAnswerIndex == 1 && state.isAnswered
                              ? AppColors.successColor
                              : null,
                      onPressed: () {
                        if (state.isAnswered == false) {
                          context.read<TempCubit>().answerQuestion(
                                answer: state
                                    .questions[state.currentQuestionIndex]
                                    .answers[1],
                              );
                        }
                      },
                      answer: state
                          .questions[state.currentQuestionIndex].answers[1],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: _answerChoice(
                      color: state.isAnswered && state.selectedAnswerIndex == 2
                          ? state.isCorrect
                              ? AppColors.successColor
                              : AppColors.failureColor
                          : correctAnswerIndex == 2 && state.isAnswered
                              ? AppColors.successColor
                              : null,
                      onPressed: () {
                        if (state.isAnswered == false) {
                          context.read<TempCubit>().answerQuestion(
                                answer: state
                                    .questions[state.currentQuestionIndex]
                                    .answers[2],
                              );
                        }
                      },
                      answer: state
                          .questions[state.currentQuestionIndex].answers[2],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: _answerChoice(
                      color: state.isAnswered && state.selectedAnswerIndex == 3
                          ? state.isCorrect
                              ? AppColors.successColor
                              : AppColors.failureColor
                          : correctAnswerIndex == 3 && state.isAnswered
                              ? AppColors.successColor
                              : null,
                      onPressed: () {
                        if (state.isAnswered == false) {
                          context.read<TempCubit>().answerQuestion(
                                answer: state
                                    .questions[state.currentQuestionIndex]
                                    .answers[3],
                              );
                        }
                      },
                      answer: state
                          .questions[state.currentQuestionIndex].answers[3],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _answerChoice({
    required String answer,
    required Function() onPressed,
    Color? color,
  }) {
    return ElevatedButton(
      style: ButtonStyle(
        elevation: const WidgetStatePropertyAll(0),
        padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(
          EdgeInsets.symmetric(
            horizontal: 32,
            vertical: 18,
          ),
        ),
        shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        overlayColor: WidgetStatePropertyAll(AppColors.white.withOpacity(0.08)),
        backgroundColor: WidgetStatePropertyAll(color ?? AppColors.kD0B8A8),
      ),
      onPressed: onPressed,
      child: Text(
        answer,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: ResponsiveUtil.isDesktop(context) ||
                  ResponsiveUtil.isTablet(context)
              ? 20
              : 16,
          color: AppColors.black.withOpacity(0.4),
        ),
      ),
    );
  }
}

class TempCubit extends Cubit<TempState> {
  final CreateWordQuestionUsecase _createWordQuestionUsecase =
      getIt<CreateWordQuestionUsecase>();

  TempCubit() : super(TempInitial());

  void init({
    required String lessonId,
    required String levelId,
    required String questionType,
    required String answerType,
  }) async {
    final questions = await _createWordQuestionUsecase(
      questionType: questionType,
      answerType: answerType,
      levelId: levelId,
      lessonId: lessonId,
    );
    questions.fold(
      (failure) {
        emit(TempFailure(failureMessage: failure.message));
      },
      (success) {
        emit(TempLoaded(
          questions: success..shuffle(),
          currentQuestionIndex: 0,
          isAnswered: false,
          isCorrect: false,
          selectedAnswerIndex: -1,
        ));
      },
    );
  }

  void answerQuestion({required String answer}) {
    final currentState = state;
    if (currentState is TempLoaded) {
      final currentQuestion =
          currentState.questions[currentState.currentQuestionIndex];
      final isCorrect = currentQuestion.correctAnswer == answer;
      int index = currentQuestion.answers.indexOf(answer);
      emit(
        currentState.copyWith(
          isAnswered: true,
          isCorrect: isCorrect,
          selectedAnswerIndex: index,
        ),
      );
    }

    Future.delayed(const Duration(milliseconds: 1200), () {
      nextQuestion();
    });
  }

  void nextQuestion() {
    final currentState = state;
    if (currentState is TempLoaded) {
      final isLastQuestion = currentState.currentQuestionIndex ==
          currentState.questions.length - 1;
      if (isLastQuestion) {
        emit(TempFinished());
      } else {
        emit(
          currentState.copyWith(
            currentQuestionIndex: currentState.currentQuestionIndex + 1,
            isAnswered: false,
            isCorrect: false,
            selectedAnswerIndex: -1,
          ),
        );
      }
    }
  }
}

abstract class TempState extends Equatable {
  const TempState();

  @override
  List<Object> get props => [];
}

class TempLoading extends TempState {}

class TempFinished extends TempState {}

class TempLoaded extends TempState {
  final List<QuestionEntity> questions;
  final int currentQuestionIndex;
  final bool isAnswered;
  final bool isCorrect;
  final int selectedAnswerIndex;

  const TempLoaded({
    required this.questions,
    required this.currentQuestionIndex,
    required this.isCorrect,
    required this.isAnswered,
    required this.selectedAnswerIndex,
  });

  @override
  List<Object> get props => [
        questions,
        currentQuestionIndex,
        isAnswered,
        isCorrect,
        selectedAnswerIndex
      ];

  TempLoaded copyWith({
    List<QuestionEntity>? questions,
    int? currentQuestionIndex,
    bool? isAnswered,
    bool? isCorrect,
    int? selectedAnswerIndex,
  }) {
    return TempLoaded(
      questions: questions ?? this.questions,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      isAnswered: isAnswered ?? this.isAnswered,
      isCorrect: isCorrect ?? this.isCorrect,
      selectedAnswerIndex: selectedAnswerIndex ?? this.selectedAnswerIndex,
    );
  }
}

class TempInitial extends TempState {}

class TempFailure extends TempState {
  final String failureMessage;

  const TempFailure({required this.failureMessage});

  @override
  List<Object> get props => [failureMessage];
}
