import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:note_book_app/common/colors/app_colors.dart';
import 'package:note_book_app/domain/entities/lesson_entity.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/delete_lesson/delete_lesson_cubit.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/delete_lesson/delete_lesson_state.dart';

class DeleteLessonForm extends StatefulWidget {
  final LessonEntity lesson;

  const DeleteLessonForm({super.key, required this.lesson});

  @override
  State<DeleteLessonForm> createState() => _DeleteLessonFormState();
}

class _DeleteLessonFormState extends State<DeleteLessonForm> {
  late TextEditingController _confirmController;

  @override
  void initState() {
    _confirmController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 600,
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.kF8EDE3,
      ),
      child: BlocBuilder<DeleteLessonCubit, DeleteLessonState>(
        buildWhen: (previous, current) =>
            current is DeleteLessonLoaded || current is DeleteLessonLoading,
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              textAlign: TextAlign.center,
                              'Bạn có chắc chắn muốn xoá bài học này?',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColors.black.withOpacity(0.4),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: state is DeleteLessonLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.kDFD3C3,
                              ),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  widget.lesson.lesson,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.black.withOpacity(0.4),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 80,
                                  ),
                                  child: TextField(
                                    cursorColor: AppColors.black,
                                    controller: _confirmController,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: AppColors.kDFD3C3,
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
                                      hintText:
                                          "Nhập \"${widget.lesson.lesson}\" để xác nhận",
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                              ],
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
                        child: _customButtonForm(
                          text: 'Xác nhận',
                          onPressed: () => {
                            if (_confirmController.text == widget.lesson.lesson)
                              {
                                context
                                    .read<DeleteLessonCubit>()
                                    .deleteLesson(id: widget.lesson.id),
                              }
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _customButtonForm(
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
}

Widget _customButtonForm(
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
