import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_book_app/common/colors/app_colors.dart';
import 'package:note_book_app/domain/entities/word_entity.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/word_manager/word_manager_cubit.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/word_manager/word_manager_state.dart';

class WordDataTable extends StatefulWidget {
  final ScrollController scrollController;

  const WordDataTable({super.key, required this.scrollController});

  @override
  State<WordDataTable> createState() => _WordDataTableState();
}

class _WordDataTableState extends State<WordDataTable> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.white,
          border: Border(
            bottom: BorderSide(color: AppColors.black),
            right: BorderSide(color: AppColors.black),
            left: BorderSide(color: AppColors.black),
            top: BorderSide(color: AppColors.black),
          ),
        ),
        child: BlocBuilder<WordManagerCubit, WordManagerState>(
          builder: (context, state) {
            if (state is WordManagerLoaded) {
              return Column(
                children: [
                  _buildTableHeader(),
                  Expanded(
                    child: ListView.builder(
                      controller: widget.scrollController,
                      itemCount: state.words.length,
                      itemBuilder: (context, index) {
                        return _buildTableRow(
                          index,
                          state.words[index],
                          state.words.length,
                        );
                      },
                    ),
                  ),
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.kDFD3C3,
        border: Border(
          bottom: BorderSide(color: AppColors.black),
        ),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.kDFD3C3,
                  border: Border(right: BorderSide(color: AppColors.black)),
                ),
                padding: const EdgeInsets.all(8),
                child: const Text(
                  'STT',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.kDFD3C3,
                  border: Border(right: BorderSide(color: AppColors.black)),
                ),
                padding: const EdgeInsets.all(8),
                child: const Text(
                  'Từ vựng',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.kDFD3C3,
                  border: Border(right: BorderSide(color: AppColors.black)),
                ),
                padding: const EdgeInsets.all(8),
                child: const Text(
                  'Thể Kanji',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: AppColors.kDFD3C3,
                  border: Border(right: BorderSide(color: AppColors.black)),
                ),
                child: const Text(
                  'Định nghĩa',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.kDFD3C3,
                ),
                padding: const EdgeInsets.all(8),
                child: const Text(
                  'Thao tác',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTableRow(int index, WordEntity word, int length) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppColors.black),
                  right: BorderSide(color: AppColors.black),
                ),
              ),
              padding: const EdgeInsets.all(8),
              child: Text(
                "${index + 1}",
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppColors.black),
                  right: BorderSide(color: AppColors.black),
                ),
              ),
              padding: const EdgeInsets.all(8),
              child: Text(
                word.word,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppColors.black),
                  right: BorderSide(color: AppColors.black),
                ),
              ),
              padding: const EdgeInsets.all(8),
              child: Text(
                word.kanjiForm,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppColors.black),
                  right: BorderSide(color: AppColors.black),
                ),
              ),
              padding: const EdgeInsets.all(8),
              child: Text(
                word.meaning,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppColors.black),
                ),
              ),
              padding: const EdgeInsets.all(8),
              child: Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                    elevation: const WidgetStatePropertyAll(0),
                    padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(
                      EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                    ),
                    shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(
                            color: AppColors.kF8EDE3.withOpacity(0.8)),
                      ),
                    ),
                    overlayColor: WidgetStatePropertyAll(
                        AppColors.black.withOpacity(0.04)),
                    backgroundColor: WidgetStatePropertyAll(
                        AppColors.kF8EDE3.withOpacity(0.8)),
                  ),
                  onPressed: () {},
                  child: Text(
                    textAlign: TextAlign.center,
                    'Sửa',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppColors.black.withOpacity(0.4),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
