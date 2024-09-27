import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:note_book_app/common/colors/app_colors.dart';
import 'package:note_book_app/common/utils/responsive_util.dart';
import 'package:note_book_app/core/services/get_it_service.dart';
import 'package:note_book_app/presentation/web_version/level/cubits/level_page_web_cubit.dart';
import 'package:note_book_app/presentation/web_version/level/cubits/level_page_web_state.dart';
import 'package:note_book_app/presentation/web_version/level/widgets/lesson_card.dart';

class LevelPageWeb extends StatefulWidget {
  const LevelPageWeb({super.key});

  @override
  State<LevelPageWeb> createState() => _LevelPageWebState();
}

class _LevelPageWebState extends State<LevelPageWeb> {
  @override
  Widget build(BuildContext context) {
    final levelId = GoRouterState.of(context).pathParameters['levelId']!;
    return BlocProvider<LevelPageWebCubit>(
      create: (context) =>
          getIt<LevelPageWebCubit>()..initPageTitle(levelId: levelId),
      child: Scaffold(
        body: BlocConsumer<LevelPageWebCubit, LevelPageWebState>(
          listener: (context, state) {
            if (state is LevelPageWebTitle) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                SystemChrome.setApplicationSwitcherDescription(
                  ApplicationSwitcherDescription(
                    label: state.title,
                  ),
                );
              });
              context
                  .read<LevelPageWebCubit>()
                  .getAllLessonsByLevel(level: state.title);
            }
          },
          builder: (context, state) {
            if (state is LevelPageWebLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.kDFD3C3,
                ),
              );
            }
            if (state is LevelPageWebLoaded) {
              return ListView.builder(
                padding: ResponsiveUtil.isDesktop(context)
                    ? const EdgeInsets.symmetric(horizontal: 320, vertical: 32)
                    : ResponsiveUtil.isTablet(context)
                        ? const EdgeInsets.symmetric(
                            horizontal: 100, vertical: 32)
                        : const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 24),
                itemCount: state.lessons.length,
                itemBuilder: (context, index) {
                  if (index != state.lessons.length - 1) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: LessonCard(lesson: state.lessons[index]),
                    );
                  }
                  return LessonCard(lesson: state.lessons[index]);
                },
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
