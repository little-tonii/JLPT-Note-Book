// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:note_book_app/common/colors/app_colors.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/import_word_data/import_word_data_cubit.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/import_word_data/import_word_data_state.dart';
import 'package:note_book_app/presentation/web_version/admin/widgets/admin_page_menu_item_view/filter_select_box.dart';

class ImportWordDataForm extends StatelessWidget {
  const ImportWordDataForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 600,
      height: 800,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.kF8EDE3,
      ),
      child: BlocBuilder<ImportWordDataCubit, ImportWordDataState>(
        buildWhen: (previous, current) =>
            current is ImportWordDataLoaded ||
            current is ImportWordDataLoading ||
            current is ImportWordSaveDataLoading,
        builder: (context, state) {
          if (state is ImportWordSaveDataLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.kDFD3C3,
              ),
            );
          }
          return Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      child: IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: BlocBuilder<ImportWordDataCubit,
                                  ImportWordDataState>(
                                builder: (context, state) {
                                  return FilterSelectBox(
                                    hint: "JNPT",
                                    items: (state is ImportWordDataLoaded)
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
                                      context
                                          .read<ImportWordDataCubit>()
                                          .updateLevelFilter(levelId: value);
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      child: IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: BlocBuilder<ImportWordDataCubit,
                                  ImportWordDataState>(
                                buildWhen: (previous, current) =>
                                    current is ImportWordDataLoaded,
                                builder: (context, state) {
                                  return FilterSelectBox(
                                    hint: "Bài học",
                                    items: (state is ImportWordDataLoaded)
                                        ? state.lessons
                                            .map((lesson) => {
                                                  'value': lesson.id,
                                                  'label': lesson.lesson,
                                                })
                                            .toList()
                                        : [],
                                    onChanged: (value) {
                                      context
                                          .read<ImportWordDataCubit>()
                                          .updateLessonFilter(lessonId: value);
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (state is ImportWordDataLoading)
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.kDFD3C3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (state is ImportWordDataLoaded &&
                        state.selectedLesson.isNotEmpty &&
                        state.selectedLevel.isNotEmpty &&
                        !state.fileSelected)
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: _chooseFileButton(
                                onPressed: () {
                                  FileUploadInputElement uploadInput =
                                      FileUploadInputElement();
                                  uploadInput.accept = '.json';
                                  uploadInput.click();
                                  uploadInput.onChange.listen((event) {
                                    final file = uploadInput.files!.first;
                                    final reader = FileReader();
                                    reader.readAsText(file);
                                    reader.onLoadEnd.listen((event) {
                                      final jsonString =
                                          reader.result as String;
                                      final data = jsonDecode(jsonString)
                                          as List<dynamic>;
                                      if (context.mounted) {
                                        context
                                            .read<ImportWordDataCubit>()
                                            .handleJsonData(jsonData: data);
                                      }
                                    });
                                  });
                                },
                                text: 'Chọn file dữ liệu',
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (state is ImportWordDataLoaded &&
                        state.selectedLesson.isNotEmpty &&
                        state.selectedLevel.isNotEmpty &&
                        state.fileSelected)
                      SizedBox(height: 16),
                    if (state is ImportWordDataLoaded &&
                        state.selectedLesson.isNotEmpty &&
                        state.selectedLevel.isNotEmpty &&
                        state.fileSelected)
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              ...state.words.asMap().entries.map(
                                    (entry) => Column(
                                      children: [
                                        _dataField(
                                          title: 'Từ vựng',
                                          text: entry.value.word,
                                        ),
                                        _dataField(
                                          title: 'Thể Kanji',
                                          text: entry.value.kanjiForm,
                                        ),
                                        _dataField(
                                          title: 'Định nghĩa',
                                          text: entry.value.meaning,
                                        ),
                                        if (entry.key != state.words.length - 1)
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                              horizontal: 16,
                                            ),
                                            height: 1,
                                            color: AppColors.black
                                                .withOpacity(0.4),
                                          ),
                                      ],
                                    ),
                                  ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: _actionButton(
                          text: 'Xác nhận',
                          onPressed: () {
                            context.read<ImportWordDataCubit>().saveData();
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _actionButton(
                          text: 'Huỷ bỏ',
                          onPressed: () => context.pop(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _dataField({required String title, required String text}) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColors.black.withOpacity(0.4),
                  ),
                ),
                child: Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppColors.black.withOpacity(0.8),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              flex: 4,
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.black.withOpacity(0.8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _actionButton(
      {required String text, required void Function() onPressed}) {
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
        backgroundColor: const WidgetStatePropertyAll(AppColors.kD0B8A8),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: AppColors.black.withOpacity(0.4),
        ),
      ),
    );
  }

  Widget _chooseFileButton(
      {required void Function() onPressed, required String text}) {
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
            side: const BorderSide(color: AppColors.kF8EDE3),
          ),
        ),
        overlayColor: WidgetStatePropertyAll(AppColors.black.withOpacity(0.04)),
        backgroundColor: const WidgetStatePropertyAll(AppColors.kF8EDE3),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: AppColors.black.withOpacity(0.4),
        ),
      ),
    );
  }
}
