import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_book_app/common/colors/app_colors.dart';
import 'package:note_book_app/domain/entities/admin_log_entity.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/admin_log_manager/admin_log_manager_cubit.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/admin_log_manager/admin_log_manager_state.dart';
import 'package:note_book_app/presentation/web_version/admin/widgets/admin_page_menu_item_view/filter_select_box.dart';

class AdminLogManager extends StatefulWidget {
  const AdminLogManager({super.key});

  @override
  State<AdminLogManager> createState() => _AdminLogManagerState();
}

class _AdminLogManagerState extends State<AdminLogManager> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      final state = context.read<AdminLogManagerCubit>().state;
      if (state is AdminLogManagerLoaded) {
        context
            .read<AdminLogManagerCubit>()
            .getAdminLogs(filterType: state.filterType);
      }
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  Widget _logItem(AdminLogEntity adminLogEntity) {
    final date = adminLogEntity.createdAt.toDate();
    final year = date.year;
    final month = date.month;
    final day = date.day;
    final hour = date.hour;
    final minute = date.minute;
    final second = date.second;
    final message = adminLogEntity.message;
    final action = adminLogEntity.action;
    final user = adminLogEntity.userEmail;
    final actionStatus = adminLogEntity.actionStatus;

    return Padding(
      padding: const EdgeInsets.only(
        bottom: 8,
        left: 8,
        right: 8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              children: [
                const TextSpan(text: '['),
                TextSpan(
                  text:
                      '$year/${month < 10 ? '0$month' : month}/${day < 10 ? '0$day' : day} - ${hour < 10 ? '0$hour' : hour}:${minute < 10 ? '0$minute' : minute}:${second < 10 ? '0$second' : second}',
                  style: const TextStyle(
                    color: AppColors.successColorBlue,
                  ),
                ),
                const TextSpan(text: '] ['),
                TextSpan(text: user),
                const TextSpan(text: '] ['),
                TextSpan(
                  text: 'Action: $action',
                  style: TextStyle(
                    color: action == "CREATE"
                        ? AppColors.successColor
                        : action == "UPDATE"
                            ? AppColors.successColorYellow
                            : AppColors.failureColor,
                  ),
                ),
                const TextSpan(text: '] ['),
                TextSpan(
                  text: 'Status: $actionStatus',
                  style: TextStyle(
                    color: actionStatus == "SUCCESS"
                        ? AppColors.successColor
                        : AppColors.failureColor,
                  ),
                ),
                const TextSpan(text: '] ['),
                TextSpan(text: message),
                const TextSpan(text: ']'),
              ],
            ),
            style: TextStyle(
              color: AppColors.white.withOpacity(0.6),
              fontSize: 16,
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
          Row(
            children: [
              Expanded(
                flex: 1,
                child: FilterSelectBox(
                  hint: "Thời gian",
                  items: const [
                    'Hôm nay',
                    'Hôm qua',
                    'Tuần này',
                    'Tháng này',
                    'Tất cả'
                  ],
                  onChanged: (value) {
                    String filterType = '';
                    if (value == 'Hôm nay') {
                      filterType = 'today';
                    } else if (value == 'Hôm qua') {
                      filterType = 'yesterday';
                    } else if (value == 'Tuần này') {
                      filterType = 'thisWeek';
                    } else if (value == 'Tháng này') {
                      filterType = 'thisMonth';
                    } else {
                      filterType = 'all';
                    }
                    context.read<AdminLogManagerCubit>()
                      ..resetState()
                      ..getAdminLogs(filterType: filterType);
                  },
                ),
              ),
              const Expanded(
                flex: 4,
                child: SizedBox(),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: BlocBuilder<AdminLogManagerCubit, AdminLogManagerState>(
              builder: (context, state) {
                if (state is AdminLogManagerLoaded) {
                  return Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.white.withOpacity(0.4),
                    ),
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.black.withOpacity(0.8),
                      ),
                      child: Theme(
                        data: ThemeData(
                          scrollbarTheme: ScrollbarThemeData(
                            thumbColor: WidgetStatePropertyAll(
                                AppColors.white.withOpacity(0.1)),
                            trackColor: WidgetStatePropertyAll(
                                AppColors.white.withOpacity(0.1)),
                            trackBorderColor: const WidgetStatePropertyAll(
                                Colors.transparent),
                            radius: const Radius.circular(10),
                            thickness: const WidgetStatePropertyAll(6),
                            thumbVisibility: const WidgetStatePropertyAll(true),
                            interactive: true,
                          ),
                        ),
                        child: Scrollbar(
                          controller: _scrollController,
                          child: ListView.builder(
                            controller: _scrollController,
                            itemCount: state.hasReachedMax
                                ? state.logs.length
                                : state.logs.length + 1,
                            itemBuilder: (context, index) {
                              if (index >= state.logs.length) {
                                return const SizedBox();
                              }
                              return index == 0
                                  ? Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: _logItem(state.logs[index]),
                                    )
                                  : _logItem(state.logs[index]);
                            },
                          ),
                        ),
                      ),
                    ),
                  );
                }
                if (state is AdminLogManagerFailure) {
                  return SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: Center(
                      child: Text(
                        state.message,
                        style: TextStyle(
                          color: AppColors.white.withOpacity(0.4),
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
