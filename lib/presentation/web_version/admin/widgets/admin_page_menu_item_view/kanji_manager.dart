import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/kanji_manager/kanji_manager_cubit.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/kanji_manager/kanji_manager_state.dart';
import 'package:note_book_app/presentation/web_version/admin/widgets/admin_page_menu_item_view/filter_select_box.dart';
import 'package:note_book_app/presentation/web_version/admin/widgets/admin_page_menu_item_view/kanji_data_table.dart';
import 'package:note_book_app/presentation/web_version/admin/widgets/admin_page_menu_item_view/kanji_manager_button.dart';
import 'package:note_book_app/presentation/web_version/admin/widgets/admin_page_menu_item_view/search_field.dart';

class KanjiManager extends StatefulWidget {
  const KanjiManager({super.key});

  @override
  State<KanjiManager> createState() => _KanjiManagerState();
}

class _KanjiManagerState extends State<KanjiManager> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

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
                      hint: "JNPT",
                      items: state is KanjiManagerLoaded
                          ? state.levels.map((level) => level.level).toList()
                          : [],
                      onChanged: (value) {
                        context.read<KanjiManagerCubit>().updateFilterChoice(
                              level: value,
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
                return Row(
                  children: [
                    const Expanded(
                      child: SearchField(),
                    ),
                    const SizedBox(width: 16),
                    KanjiManagerButton(
                      text: 'Tải lại',
                      onPressed: () {
                        context
                            .read<KanjiManagerCubit>()
                            .searchKanjis(hanVietSearchKey: '', refresh: true);
                        _scrollToTop();
                      },
                    ),
                    const SizedBox(width: 16),
                    KanjiManagerButton(
                      text: "Thêm mới",
                      onPressed: () {},
                    ),
                    const SizedBox(width: 16),
                    KanjiManagerButton(
                      text: "Nhập dữ liệu",
                      onPressed: () {},
                    ),
                  ],
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
