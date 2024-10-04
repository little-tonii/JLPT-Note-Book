import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_book_app/common/colors/app_colors.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/kanji_manager/kanji_manager_cubit.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/kanji_manager/kanji_manager_state.dart';

class KanjiDataTable extends StatefulWidget {
  final ScrollController scrollController;

  const KanjiDataTable({super.key, required this.scrollController});

  @override
  State<KanjiDataTable> createState() => _KanjiDataTableState();
}

class _KanjiDataTableState extends State<KanjiDataTable> {
  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.white,
        ),
        child: BlocBuilder<KanjiManagerCubit, KanjiManagerState>(
          builder: (context, state) {
            if (state is KanjiManagerLoaded) {
              return ListView.builder(
                controller: widget.scrollController,
                itemCount: state.kanjis.length + 1,
                itemBuilder: (context, index) {
                  if (index < state.kanjis.length) {
                    final kanji = state.kanjis[index];
                    return ListTile(
                      title: Text(kanji.kanji),
                      subtitle: Text(kanji.viet),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  void _onScroll() {
    if (_isBottom()) {
      final state = context.read<KanjiManagerCubit>().state;
      if (state is KanjiManagerLoaded) {
        context.read<KanjiManagerCubit>().searchKanjis(
              hanVietSearchKey: state.searchKey,
            );
      }
    }
  }

  bool _isBottom() {
    if (!widget.scrollController.hasClients) return false;
    final maxScroll = widget.scrollController.position.maxScrollExtent;
    final currentScroll = widget.scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }
}
