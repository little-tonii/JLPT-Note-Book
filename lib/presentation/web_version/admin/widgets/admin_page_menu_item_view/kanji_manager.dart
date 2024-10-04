import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_book_app/common/colors/app_colors.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/kanji_manager/kanji_manager_cubit.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/kanji_manager/kanji_manager_state.dart';
import 'package:note_book_app/presentation/web_version/admin/widgets/admin_page_menu_item_view/filter_select_box.dart';
import 'package:note_book_app/presentation/web_version/admin/widgets/admin_page_menu_item_view/kanji_manager_button.dart';
import 'package:note_book_app/presentation/web_version/admin/widgets/admin_page_menu_item_view/search_field.dart';

class KanjiManager extends StatelessWidget {
  const KanjiManager({super.key});

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
                  FilterSelectBox(
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
                  const SizedBox(width: 16),
                  KanjiManagerButton(
                    text: "Tìm kiếm",
                    onPressed: () {},
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Expanded(
                child: SearchField(),
              ),
              const SizedBox(width: 8),
              IconButton(
                color: AppColors.white,
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onPressed: () {},
                icon: const Icon(
                  Icons.refresh_rounded,
                  size: 32,
                  color: AppColors.kDFD3C3,
                ),
              ),
              const SizedBox(width: 8),
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
          ),
        ],
      ),
    );
  }
}
