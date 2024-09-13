import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:note_book_app/common/colors/app_colors.dart';
import 'package:note_book_app/common/utils/responsive_util.dart';
import 'package:note_book_app/core/services/get_it_service.dart';
import 'package:note_book_app/presentation/web_version/level/blocs/level_page_web_cubit.dart';
import 'package:note_book_app/presentation/web_version/level/blocs/level_page_web_state.dart';
import 'package:note_book_app/presentation/web_version/level/widgets/detail_card.dart';

class LevelPageWeb extends StatefulWidget {
  final String level;

  const LevelPageWeb({super.key, required this.level});

  @override
  State<LevelPageWeb> createState() => _LevelPageWebState();
}

class _LevelPageWebState extends State<LevelPageWeb> {
  void _handleOnTapNavigateBack() {
    context.go("/home");
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LevelPageWebCubit>(
      create: (context) =>
          getIt<LevelPageWebCubit>()..getAllLevelDetails(level: widget.level),
      child: Scaffold(
        body: BlocBuilder<LevelPageWebCubit, LevelPageWebState>(
          builder: (context, state) {
            if (state is LevelPageWebLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.kDFD3C3,
                ),
              );
            }
            if (state is LevelPageWebLoaded) {
              return ListView.builder(
                padding: ResponsiveUtil.isDesktop(context)
                    ? const EdgeInsets.symmetric(horizontal: 320, vertical: 32)
                    : ResponsiveUtil.isTablet(context)
                        ? const EdgeInsets.symmetric(
                            horizontal: 100, vertical: 32)
                        : const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 24),
                itemCount: state.levelDetails.length,
                itemBuilder: (context, index) {
                  if (index != state.levelDetails.length - 1) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: DetailCard(detail: state.levelDetails[index]),
                    );
                  }
                  return DetailCard(detail: state.levelDetails[index]);
                },
              );
            }
            if (state is LevelPageWebError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.message,
                      style: TextStyle(
                        fontSize: ResponsiveUtil.isDesktop(context)
                            ? 32
                            : ResponsiveUtil.isTablet(context)
                                ? 24
                                : 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.kD0B8A8,
                      ),
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      style: ButtonStyle(
                        padding:
                            const WidgetStatePropertyAll<EdgeInsetsGeometry>(
                          EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                        ),
                        shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        overlayColor: WidgetStatePropertyAll(
                            AppColors.black.withOpacity(0.08)),
                        backgroundColor:
                            const WidgetStatePropertyAll(AppColors.kF8EDE3),
                      ),
                      onPressed: _handleOnTapNavigateBack,
                      child: Text(
                        "Quay lại",
                        style: TextStyle(
                          fontSize: ResponsiveUtil.isDesktop(context)
                              ? 24
                              : ResponsiveUtil.isTablet(context)
                                  ? 20
                                  : 16,
                          color: AppColors.black.withOpacity(0.4),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
