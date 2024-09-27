import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_book_app/common/colors/app_colors.dart';
import 'package:note_book_app/common/utils/responsive_util.dart';
import 'package:note_book_app/core/services/get_it_service.dart';
import 'package:note_book_app/presentation/web_version/home/cubits/home_page_web_cubit.dart';
import 'package:note_book_app/presentation/web_version/home/cubits/home_page_web_state.dart';
import 'package:note_book_app/presentation/web_version/home/widgets/level_card.dart';

class HomePageWeb extends StatefulWidget {
  const HomePageWeb({super.key});

  @override
  State<HomePageWeb> createState() => _HomePageWebState();
}

class _HomePageWebState extends State<HomePageWeb> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SystemChrome.setApplicationSwitcherDescription(
        const ApplicationSwitcherDescription(
          label: "Levels",
        ),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomePageWebCubit>()..getAllLevels(),
      child: Scaffold(
        body: BlocConsumer<HomePageWebCubit, HomePageWebState>(
          buildWhen: (previous, current) => current is! HomePageWebFailure,
          builder: (context, state) {
            if (state is HomePageWebLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.kDFD3C3,
                ),
              );
            }
            if (state is HomePageWebLoaded) {
              return ListView.builder(
                padding: ResponsiveUtil.isDesktop(context)
                    ? const EdgeInsets.symmetric(horizontal: 320, vertical: 32)
                    : ResponsiveUtil.isTablet(context)
                        ? const EdgeInsets.symmetric(
                            horizontal: 100, vertical: 32)
                        : const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 24),
                itemCount: state.levels.length,
                itemBuilder: (context, index) {
                  if (index != state.levels.length - 1) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: LevelCard(levelEntity: state.levels[index]),
                    );
                  }
                  return LevelCard(levelEntity: state.levels[index]);
                },
              );
            }
            return const SizedBox();
          },
          listener: (context, state) {
            if (state is HomePageWebFailure) {}
          },
        ),
      ),
    );
  }
}
