import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_book_app/common/colors/app_colors.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/kanji_manager/kanji_manager_cubit.dart';

class SearchField extends StatelessWidget {
  final TextEditingController searchController;

  const SearchField({super.key, required this.searchController});

  void _handleSearch(BuildContext context) {
    context.read<KanjiManagerCubit>().searchKanjis(
          hanVietSearchKey: searchController.text,
          refresh: true,
        );
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: (value) => _handleSearch(context),
      cursorColor: AppColors.black,
      controller: searchController,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.kF8EDE3,
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
          fontWeight: FontWeight.bold,
          fontSize: 16,
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
            onPressed: () => _handleSearch(context),
          ),
        ),
      ),
    );
  }
}
