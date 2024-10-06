import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:note_book_app/core/failures/firestore_failure.dart';
import 'package:note_book_app/data/datasources/admin_log_datasource.dart';
import 'package:note_book_app/data/models/admin_log_model.dart';

class AdminLogDatasourceImpl implements AdminLogDatasource {
  final FirebaseFirestore firebaseFirestore;

  const AdminLogDatasourceImpl({required this.firebaseFirestore});

  @override
  Future<bool> createAdminLog({required String message}) async {
    try {
      final adminLogsCollection = firebaseFirestore.collection('adminLogs');
      await adminLogsCollection.add({
        'message': message,
        'createdAt': Timestamp.now(),
      });
      final currentLogsSnapshot = await adminLogsCollection.count().get();
      final currentLogs = currentLogsSnapshot.count!;
      if (currentLogs > 100) {
        final oldestSnapshot =
            await adminLogsCollection.orderBy('createdAt').limit(1).get();
        await oldestSnapshot.docs.first.reference.delete();
      }
      return true;
    } on FirebaseException {
      return false;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<AdminLogModel>> getAdminLogs(
      {required int pageNumber, required int pageSize}) async {
    try {
      final skipCount = (pageNumber - 1) * pageSize;
      Query<Map<String, dynamic>> query = firebaseFirestore
          .collection('adminLogs')
          .orderBy('createdAt', descending: true);
      if (skipCount > 0) {
        final lastDoc = await query.limit(skipCount).get();
        if (lastDoc.docs.isNotEmpty) {
          query = query.startAfterDocument(lastDoc.docs.last);
        }
      }
      final querySnapshot = await query.limit(pageSize).get();
      final logs = querySnapshot.docs
          .map(
            (log) => AdminLogModel.fromJson({
              'id': log.id,
              'message': log.data()['message'],
              'createdAt': log.data()['createdAt'],
            }),
          )
          .toList();
      return logs;
    } on FirebaseException catch (e) {
      log(e.toString());
      throw FirestoreFailure(message: "Có lỗi xảy ra khi truy cập admin logs");
    } catch (e) {
      throw Exception(e);
    }
  }
}
