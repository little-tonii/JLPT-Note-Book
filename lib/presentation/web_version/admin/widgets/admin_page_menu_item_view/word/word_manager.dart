import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:note_book_app/common/utils/responsive_util.dart';
import 'package:note_book_app/core/services/get_it_service.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/import_word_data/import_word_data_cubit.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/import_word_data/import_word_data_state.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/word_manager/word_manager_cubit.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/word_manager/word_manager_state.dart';
import 'package:note_book_app/presentation/web_version/admin/widgets/admin_page_menu_item_view/filter_select_box.dart';
import 'package:note_book_app/presentation/web_version/admin/widgets/admin_page_menu_item_view/search_field.dart';
import 'package:note_book_app/presentation/web_version/admin/widgets/admin_page_menu_item_view/word/import_word_data_form.dart';
import 'package:note_book_app/presentation/web_version/admin/widgets/admin_page_menu_item_view/word/word_data_table.dart';
import 'package:note_book_app/presentation/web_version/admin/widgets/admin_page_menu_item_view/word/word_manager_button.dart';

class WordManager extends StatefulWidget {
  const WordManager({super.key});

  @override
  State<WordManager> createState() => _WordManagerState();
}

class _WordManagerState extends State<WordManager> {
  late ScrollController _scrollController;
  late TextEditingController _searchController;
  late WordManagerCubit _wordManagerCubit;

  @override
  void initState() {
    _wordManagerCubit = context.read<WordManagerCubit>()..init();
    _scrollController = ScrollController();
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(0);
    }
  }

  void _handleReload() {
    final state = context.read<WordManagerCubit>().state;
    if (state is WordManagerLoaded) {
      _scrollToTop();
      context
          .read<WordManagerCubit>()
          .loadMoreWords(searchKey: _searchController.text);
    }
  }

  void _handleShowCreateNewWordForm() {}

  void _handleShowImportWordDataForm() {
    showDialog(
      context: context,
      builder: (context) => LayoutBuilder(
        builder: (context, constraints) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!ResponsiveUtil.isDesktop(context)) {
              context.pop();
            }
          });
          return Dialog(
            child: BlocProvider<ImportWordDataCubit>(
              create: (context) => getIt<ImportWordDataCubit>()..init(),
              child: BlocListener<ImportWordDataCubit, ImportWordDataState>(
                child: const ImportWordDataForm(),
                listener: (BuildContext context, ImportWordDataState state) {
                  if (state is ImportWordDataSuccess ||
                      state is ImportWordDataFailure) {
                    context.pop();
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: BlocBuilder<WordManagerCubit, WordManagerState>(
                  builder: (context, state) {
                    return FilterSelectBox(
                      hint: "JLPT",
                      items: state is WordManagerLoaded
                          ? state.levels
                              .map(
                                (level) => {
                                  'value': level.id,
                                  'label': level.level,
                                },
                              )
                              .toList()
                          : [],
                      onChanged: (value) {
                        _scrollToTop();
                        context
                            .read<WordManagerCubit>()
                            .updateLevelFilter(levelId: value);
                      },
                    );
                  },
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: BlocBuilder<WordManagerCubit, WordManagerState>(
                  builder: (context, state) {
                    return FilterSelectBox(
                      key: Key(state is WordManagerLoaded
                          ? state.selectedLevel
                          : ''),
                      hint: "Bài học",
                      items: state is WordManagerLoaded
                          ? state.lessons
                              .map(
                                (lesson) => {
                                  'value': lesson.id,
                                  'label': lesson.lesson,
                                },
                              )
                              .toList()
                          : [],
                      onChanged: (value) {
                        _scrollToTop();
                        context
                            .read<WordManagerCubit>()
                            .updateLessonFilter(lessonId: value);
                      },
                    );
                  },
                ),
              ),
              const SizedBox(width: 16),
              WordManagerButton(
                text: "Nhập dữ liệu",
                onPressed: _handleShowImportWordDataForm,
              ),
            ],
          ),
          const SizedBox(height: 16),
          BlocBuilder<WordManagerCubit, WordManagerState>(
            builder: (context, state) {
              if (state is WordManagerLoaded &&
                  state.selectedLevel.isNotEmpty) {
                return IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: SearchField(
                          hint: "Tìm kiếm bằng tiếng Nhật",
                          searchController: _searchController,
                        ),
                      ),
                      const SizedBox(width: 16),
                      WordManagerButton(
                        text: 'Tải lại',
                        onPressed: _handleReload,
                      ),
                      const SizedBox(width: 16),
                      WordManagerButton(
                        text: "Thêm mới",
                        onPressed: () => _handleShowCreateNewWordForm,
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox();
            },
          ),
          const SizedBox(height: 16),
          BlocBuilder<WordManagerCubit, WordManagerState>(
            builder: (context, state) {
              if (state is WordManagerLoaded &&
                  state.selectedLevel.isNotEmpty) {
                return WordDataTable(
                  searchController: _searchController,
                  scrollController: _scrollController,
                );
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
