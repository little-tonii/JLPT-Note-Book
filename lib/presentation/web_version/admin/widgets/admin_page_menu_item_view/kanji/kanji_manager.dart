import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:note_book_app/common/utils/responsive_util.dart';
import 'package:note_book_app/core/services/get_it_service.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/create_kanji/create_kanji_cubit.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/create_kanji/create_kanji_state.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/kanji_manager/kanji_manager_cubit.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/kanji_manager/kanji_manager_state.dart';
import 'package:note_book_app/presentation/web_version/admin/widgets/admin_page_menu_item_view/kanji/create_new_kanji_form.dart';
import 'package:note_book_app/presentation/web_version/admin/widgets/admin_page_menu_item_view/filter_select_box.dart';
import 'package:note_book_app/presentation/web_version/admin/widgets/admin_page_menu_item_view/kanji/kanji_data_table.dart';
import 'package:note_book_app/presentation/web_version/admin/widgets/admin_page_menu_item_view/kanji/kanji_manager_button.dart';
import 'package:note_book_app/presentation/web_version/admin/widgets/admin_page_menu_item_view/search_field.dart';

class KanjiManager extends StatefulWidget {
  const KanjiManager({super.key});

  @override
  State<KanjiManager> createState() => _KanjiManagerState();
}

class _KanjiManagerState extends State<KanjiManager> {
  late ScrollController _scrollController;
  late TextEditingController _searchController;

  @override
  void initState() {
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
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 1),
      curve: Curves.easeInOut,
    );
  }

  void _handleReload() {
    context
        .read<KanjiManagerCubit>()
        .searchKanjis(hanVietSearchKey: '', refresh: true);
    _scrollToTop();
    _searchController.clear();
  }

  void _handleShowCreateNewKanjiForm({required String levelId}) {
    showDialog(
      context: context,
      builder: (context) {
        return LayoutBuilder(
          builder: (context, constraints) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!ResponsiveUtil.isDesktop(context)) {
                context.pop();
              }
            });
            return Dialog(
              child: BlocProvider<CreateKanjiCubit>(
                create: (context) => getIt<CreateKanjiCubit>()..init(),
                child: BlocListener<CreateKanjiCubit, CreateKanjiState>(
                  child: CreateNewKanjiForm(
                    levelId: levelId,
                  ),
                  listener: (BuildContext context, CreateKanjiState state) {
                    if (state is CreateKanjiSuccess ||
                        state is CreateKanjiFailure) {
                      context.pop();
                    }
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _handleImportKanjiData() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      child: Column(
        children: [
          BlocBuilder<KanjiManagerCubit, KanjiManagerState>(
            builder: (context, state) {
              return Row(
                children: [
                  Expanded(
                    child: FilterSelectBox(
                      hint: "JLPT",
                      items: state is KanjiManagerLoaded
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
                        context.read<KanjiManagerCubit>().updateFilterChoice(
                              levelId: value,
                            );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 16),
          BlocBuilder<KanjiManagerCubit, KanjiManagerState>(
            builder: (context, state) {
              if (state is KanjiManagerLoaded &&
                  state.levelFilterState.isNotEmpty) {
                return IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: SearchField(
                          searchController: _searchController,
                        ),
                      ),
                      const SizedBox(width: 16),
                      KanjiManagerButton(
                        text: 'Tải lại',
                        onPressed: _handleReload,
                      ),
                      const SizedBox(width: 16),
                      KanjiManagerButton(
                        text: "Thêm mới",
                        onPressed: () => _handleShowCreateNewKanjiForm(
                          levelId: state.levelFilterState,
                        ),
                      ),
                      const SizedBox(width: 16),
                      KanjiManagerButton(
                        text: "Nhập dữ liệu",
                        onPressed: _handleImportKanjiData,
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox();
            },
          ),
          const SizedBox(height: 16),
          BlocBuilder<KanjiManagerCubit, KanjiManagerState>(
            builder: (context, state) {
              if (state is KanjiManagerLoaded &&
                  state.levelFilterState.isNotEmpty) {
                return KanjiDataTable(
                  scrollController: _scrollController,
                );
              }
              return const SizedBox();
            },
          )
        ],
      ),
    );
  }
}
