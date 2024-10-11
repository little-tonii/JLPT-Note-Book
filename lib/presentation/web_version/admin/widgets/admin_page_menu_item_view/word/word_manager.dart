import 'package:flutter/material.dart';

class WordManager extends StatefulWidget {
  const WordManager({super.key});

  @override
  State<WordManager> createState() => _WordManagerState();
}

class _WordManagerState extends State<WordManager> {
  late ScrollController _scrollController;
  late TextEditingController _searchController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.jumpTo(0);
  }

  void _handleReload() {}

  void _handleCreateNewWordForm({required String levelId}) {}

  void _handleImportWordData() {}

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
