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

class KanjiPageWeb extends StatefulWidget {
  final LessonEntity lesson;

  const KanjiPageWeb({super.key, required this.lesson});

  @override
  State<KanjiPageWeb> createState() => _KanjiPageWebState();
}

class _KanjiPageWebState extends State<KanjiPageWeb> {
  late TextEditingController _searchController;
  late KanjiPageWebCubit _kanjiPageWebCubit;

  @override
  void initState() {
    _kanjiPageWebCubit = getIt<KanjiPageWebCubit>();
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _kanjiPageWebCubit.close();
    _searchController.dispose();
    super.dispose();
  }

  void _handleSearchKanjis(BuildContext context) {
    _kanjiPageWebCubit.getAllKanjisByLevel(
          levelId: widget.lesson.level,
          hanVietSearchKey: _searchController.text,
          pageNumber: 1,
        );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<KanjiPageWebCubit>(
          create: (context) => _kanjiPageWebCubit
            ..getAllKanjisByLevel(
              levelId: widget.lesson.level,
              hanVietSearchKey: _searchController.text,
              pageNumber: 1,
            ),
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
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 360,
                  right: 360,
                  top: 16,
                  bottom: 8,
                ),
                child: TextField(
                  onSubmitted: (value) => _handleSearchKanjis(context),
                  cursorColor: AppColors.black,
                  controller: _searchController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.kF8EDE3.withOpacity(0.8),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    hintStyle: TextStyle(
                      color: AppColors.black.withOpacity(0.4),
                    ),
                    hintText: 'Tìm kiếm bằng chữ Hán Việt',
                    suffixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: IconButton(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        icon: Icon(
                          Icons.search,
                          color: AppColors.black.withOpacity(0.4),
                        ),
                        onPressed: () => _handleSearchKanjis(context),
                      ),
                    ),
                  ),
                ),
              ),
              BlocConsumer<KanjiPageWebCubit, KanjiPageWebState>(
                builder: (context, state) {
                  if (state is KanjiPageWebLoading) {
                    return const Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            color: AppColors.kDFD3C3,
                          ),
                        ],
                      ),
                    );
                  }
                  if (state is KanjiPageWebLoaded) {
                    return Expanded(
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
                    );
                  }
                  return const SizedBox();
                },
                listener: (context, state) {
                  if (state is KanjiPageWebFailure) {}
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
