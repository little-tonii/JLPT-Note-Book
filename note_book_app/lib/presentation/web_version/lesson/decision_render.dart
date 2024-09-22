import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:note_book_app/common/colors/app_colors.dart';
import 'package:note_book_app/core/services/get_it_service.dart';
import 'package:note_book_app/presentation/web_version/lesson/character_page_web.dart';
import 'package:note_book_app/presentation/web_version/lesson/cubits/decision_render/decision_render_cubit.dart';
import 'package:note_book_app/presentation/web_version/lesson/cubits/decision_render/decision_render_state.dart';
import 'package:note_book_app/presentation/web_version/lesson/kanji_page_web.dart';

class DecisionRender extends StatefulWidget {
  const DecisionRender({super.key});

  @override
  State<DecisionRender> createState() => _DecisionRenderState();
}

class _DecisionRenderState extends State<DecisionRender> {
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
                  label: '${state.lesson.level} | ${state.lesson.lesson}',
                ),
              );
            });
            return CharacterPageWeb(lesson: state.lesson);
          }
          if (state is DecisionRenderKanjiPageWeb) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              SystemChrome.setApplicationSwitcherDescription(
                ApplicationSwitcherDescription(
                  label: '${state.lesson.level} | ${state.lesson.lesson}',
                ),
              );
            });
            return KanjiPageWeb(lesson: state.lesson);
          }
          if (state is DecisionRenderLessonPageWeb) {}
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
