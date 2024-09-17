import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:note_book_app/data/datasources/level_datasource.dart';
import 'package:note_book_app/data/models/level_model.dart';

class LevelDatasourcesImpl implements LevelDatasource {
  final FirebaseFirestore firebaseFirestore;

  const LevelDatasourcesImpl({required this.firebaseFirestore});

  @override
  Future<List<LevelModel>> getAllLevels() async {
    final levels = await firebaseFirestore.collection('levels').get();
    return levels.docs.map((e) {
      return LevelModel.fromJson({
        'level': e.data()['level'],
        'id': e.id,
      });
    }).toList();
  }
}
