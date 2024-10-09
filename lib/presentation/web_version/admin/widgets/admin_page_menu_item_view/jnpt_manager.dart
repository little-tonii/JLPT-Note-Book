import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:note_book_app/common/colors/app_colors.dart';
import 'package:note_book_app/common/utils/responsive_util.dart';
import 'package:note_book_app/core/services/get_it_service.dart';
import 'package:note_book_app/domain/entities/level_entity.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/create_new_jnpt/create_new_jnpt_cubit.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/create_new_jnpt/create_new_jnpt_state.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/delete_jnpt/delete_jnpt_cubit.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/delete_jnpt/delete_jnpt_state.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/edit_jnpt/edit_jnpt_cubit.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/edit_jnpt/edit_jnpt_state.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/jnpt_manager/jnpt_manager_cubit.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/jnpt_manager/jnpt_manager_state.dart';
import 'package:note_book_app/presentation/web_version/admin/widgets/admin_page_menu_item_view/create_new_jnpt_form.dart';
import 'package:note_book_app/presentation/web_version/admin/widgets/admin_page_menu_item_view/delete_jnpt_form.dart';
import 'package:note_book_app/presentation/web_version/admin/widgets/admin_page_menu_item_view/edit_jnpt_form.dart';

class JnptManager extends StatefulWidget {
  const JnptManager({super.key});

  @override
  State<JnptManager> createState() => _JnptManagerState();
}

class _JnptManagerState extends State<JnptManager> {
  late JnptManagerCubit _jnptManagerCubit;

  @override
  void initState() {
    _jnptManagerCubit = context.read<JnptManagerCubit>()..init();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _handleReload() {
    context.read<JnptManagerCubit>().init();
  }

  void _handleShowCreateNewJnptForm() {
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
            child: BlocProvider<CreateNewJnptCubit>(
              create: (context) => getIt<CreateNewJnptCubit>()..init(),
              child: BlocListener<CreateNewJnptCubit, CreateNewJnptState>(
                child: const CreateNewJnptForm(),
                listener: (BuildContext context, CreateNewJnptState state) {
                  if (state is CreateNewJnptSuccess) {
                    _jnptManagerCubit.addJnptListView(jnpt: state.levelEntity);
                  }
                  if (state is CreateNewJnptSuccess ||
                      state is CreateNewJnptFailure) {
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

  void _handleShowDeleteJnptForm({required LevelEntity level}) {
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
            child: BlocProvider<DeleteJnptCubit>(
              create: (context) => getIt<DeleteJnptCubit>()..init(),
              child: BlocListener<DeleteJnptCubit, DeleteJnptState>(
                listener: (context, state) {
                  if (state is DeleteJnptSuccess) {
                    _jnptManagerCubit.removeJnptListView(
                      jnptId: state.levelEntity.id,
                    );
                  }
                  if (state is DeleteJnptSuccess ||
                      state is DeleteJnptFailure) {
                    context.pop();
                  }
                },
                child: DeleteJnptForm(jnpt: level),
              ),
            ),
          );
        },
      ),
    );
  }

  void _handleShowEditJnptForm({required LevelEntity level}) {
    showDialog(
      context: context,
      builder: (context) => LayoutBuilder(
        builder: (context, constraints) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!ResponsiveUtil.isDesktop(context)) {
              context.pop();
            }
          });
          return BlocProvider<EditJnptCubit>(
            create: (context) => getIt<EditJnptCubit>()..init(),
            child: BlocListener<EditJnptCubit, EditJnptState>(
              listener: (context, state) {
                if (state is EditJnptSuccess) {
                  _jnptManagerCubit.updateJnptListView(jnpt: state.level);
                }
                if (state is EditJnptSuccess || state is EditJnptFailure) {
                  context.pop();
                }
              },
              child: EditJnptForm(jnpt: level),
            ),
          );
        },
      ),
    );
  }

  Widget _jnptTableHeader() {
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
              flex: 8,
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.kDFD3C3,
                  border: Border(right: BorderSide(color: AppColors.black)),
                ),
                padding: const EdgeInsets.all(8),
                child: const Text(
                  'JNPT',
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

  Widget _actionSelector() {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 1,
            child: DropdownButtonHideUnderline(
              child: DropdownButton2(
                value: null,
                dropdownStyleData: DropdownStyleData(
                  offset: const Offset(0, -8),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                buttonStyleData: ButtonStyleData(
                  decoration: BoxDecoration(
                    color: AppColors.kDFD3C3,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  height: 48,
                  width: double.infinity,
                ),
                onChanged: (value) {
                  if (value == "Tải lại") {
                    _handleReload();
                  } else if (value == "Tạo mới JNPT") {
                    _handleShowCreateNewJnptForm();
                  }
                },
                isExpanded: true,
                hint: Text(
                  "Hành động",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppColors.black.withOpacity(0.6),
                  ),
                ),
                items: ["Tải lại", "Tạo mới JNPT"]
                    .map(
                      (item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black.withOpacity(0.6),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          const Expanded(
            flex: 4,
            child: SizedBox(),
          ),
        ],
      ),
    );
  }

  Widget _buildTableRow({
    required int index,
    required LevelEntity level,
    required int length,
  }) {
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
            flex: 8,
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppColors.black),
                  right: BorderSide(color: AppColors.black),
                ),
              ),
              padding: const EdgeInsets.all(8),
              child: Text(
                level.level,
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
                  right: BorderSide(color: AppColors.black),
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
                  onPressed: () => _handleShowEditJnptForm(level: level),
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
                  onPressed: () => _handleShowDeleteJnptForm(level: level),
                  child: Text(
                    textAlign: TextAlign.center,
                    'Xoá',
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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      child: Column(
        children: [
          _actionSelector(),
          const SizedBox(height: 16),
          BlocBuilder<JnptManagerCubit, JnptManagerState>(
            buildWhen: (previous, current) => current is JnptManagerLoaded,
            builder: (context, state) {
              if (state is JnptManagerLoaded) {
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
                    child: Column(
                      children: [
                        _jnptTableHeader(),
                        Expanded(
                          child: ListView.builder(
                            itemCount: state.levels.length,
                            itemBuilder: (context, index) {
                              return _buildTableRow(
                                index: index,
                                level: state.levels[index],
                                length: state.levels.length,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: state is JnptManagerFailure
                          ? Text(
                              state.message,
                              style: TextStyle(
                                color: AppColors.white.withOpacity(0.4),
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : const CircularProgressIndicator(
                              color: AppColors.kDFD3C3,
                            ),
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
