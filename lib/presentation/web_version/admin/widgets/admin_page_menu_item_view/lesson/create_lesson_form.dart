import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:note_book_app/common/colors/app_colors.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/create_lesson/create_lesson_cubit.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/create_lesson/create_lesson_state.dart';

class CreateLessonForm extends StatefulWidget {
  const CreateLessonForm({super.key});

  @override
  State<CreateLessonForm> createState() => _CreateLessonFormState();
}

class _CreateLessonFormState extends State<CreateLessonForm> {
  late TextEditingController _lessonController;

  @override
  void initState() {
    _lessonController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _lessonController.dispose();
    super.dispose();
  }

  Widget _dataField({
    required String title,
    required TextEditingController controller,
    required String hintText,
  }) {
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
              child: TextField(
                cursorColor: AppColors.black,
                controller: controller,
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
                  hintText: hintText,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _actionFormButton(
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

  void _handleCreateNewLesson() {
    context
        .read<CreateLessonCubit>()
        .createNewLesson(lesson: _lessonController.text);
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
      child: BlocBuilder<CreateLessonCubit, CreateLessonState>(
        buildWhen: (previous, current) => current is CreateLessonLoading,
        builder: (context, state) {
          if (state is CreateLessonLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.kDFD3C3,
              ),
            );
          }
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _dataField(
                        title: "Bài học",
                        controller: _lessonController,
                        hintText: "Nhập bài học",
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: _actionFormButton(
                          text: 'Tạo mới',
                          onPressed: _handleCreateNewLesson,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _actionFormButton(
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
