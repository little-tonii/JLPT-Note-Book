import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_book_app/common/colors/app_colors.dart';
import 'package:note_book_app/core/services/get_it_service.dart';
import 'package:note_book_app/domain/entities/lesson_entity.dart';
import 'package:note_book_app/presentation/web_version/lesson/cubits/kanji_page_web/kanji_page_web_cubit.dart';
import 'package:note_book_app/presentation/web_version/lesson/cubits/kanji_page_web/kanji_page_web_state.dart';
import 'package:note_book_app/presentation/web_version/lesson/cubits/kanji_page_web/kunyomi_dialog_cubit.dart';
import 'package:note_book_app/presentation/web_version/lesson/cubits/kanji_page_web/onyomi_dialog_cubit.dart';
import 'package:note_book_app/presentation/web_version/lesson/widgets/kanji_page_web/kanji_component.dart';

class KanjiPageWeb extends StatelessWidget {
  final LessonEntity lesson;

  const KanjiPageWeb({super.key, required this.lesson});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<KanjiPageWebCubit>(
          create: (context) => getIt<KanjiPageWebCubit>()
            ..getAllKanjisByLevel(levelId: lesson.level),
        ),
        BlocProvider<KunyomiDialogCubit>(
          create: (context) => getIt<KunyomiDialogCubit>(),
        ),
        BlocProvider<OnyomiDialogCubit>(
          create: (context) => getIt<OnyomiDialogCubit>(),
        ),
      ],
      child: Scaffold(
        body: Center(
          child: BlocConsumer<KanjiPageWebCubit, KanjiPageWebState>(
            builder: (context, state) {
              if (state is KanjiPageWebLoading) {
                return const CircularProgressIndicator(
                  color: AppColors.kDFD3C3,
                );
              }
              if (state is KanjiPageWebLoaded) {
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Container(
                            height: 300,
                            padding: EdgeInsets.only(
                              left: 360,
                              right: 360,
                              top: index == 0 ? 32 : 16,
                              bottom:
                                  index == state.kanjis.length - 1 ? 32 : 16,
                            ),
                            child: KanjiComponent(
                              kanji: state.kanjis[index],
                              kunyomiDialogCubit:
                                  context.read<KunyomiDialogCubit>(),
                              onyomiDialogCubit:
                                  context.read<OnyomiDialogCubit>(),
                            ),
                          );
                        },
                        itemCount: state.kanjis.length,
                      ),
                    ),
                  ],
                );
              }
              return const SizedBox();
            },
            listener: (context, state) {
              if (state is KanjiPageWebFailure) {}
            },
          ),
        ),
      ),
    );
  }
}
