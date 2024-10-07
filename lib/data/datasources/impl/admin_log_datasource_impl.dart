import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:note_book_app/core/failures/firestore_failure.dart';
import 'package:note_book_app/data/datasources/admin_log_datasource.dart';
import 'package:note_book_app/data/models/admin_log_model.dart';

class AdminLogDatasourceImpl implements AdminLogDatasource {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;

  const AdminLogDatasourceImpl({
    required this.firebaseFirestore,
    required this.firebaseAuth,
  });

  @override
  Future<bool> createAdminLog({
    required String message,
    required String action,
    required String actionStatus,
  }) async {
    try {
      final adminLogsCollection = firebaseFirestore.collection('adminLogs');
      await adminLogsCollection.add({
        'message': message,
        'createdAt': Timestamp.now(),
        'action': action,
        'actionStatus': actionStatus,
        'userEmail': firebaseAuth.currentUser!.email,
      });
      final currentLogsSnapshot = await adminLogsCollection.count().get();
      final currentLogs = currentLogsSnapshot.count!;
      if (currentLogs > 100) {
        final oldestSnapshot = await adminLogsCollection
            .orderBy('createdAt')
            .limit(currentLogs - 100)
            .get();

        for (final doc in oldestSnapshot.docs) {
          await doc.reference.delete();
        }
      }
      return true;
    } on FirebaseException {
      return false;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<AdminLogModel>> getAdminLogs({
    required int pageNumber,
    required int pageSize,
    required String filterType,
  }) async {
    try {
      final skipCount = (pageNumber - 1) * pageSize;
      Query<Map<String, dynamic>> query = firebaseFirestore
          .collection('adminLogs')
          .orderBy('createdAt', descending: true);
      final now = DateTime.now();
      switch (filterType) {
        case 'today':
          final startOfDay = DateTime(now.year, now.month, now.day);
          query = query.where(
            'createdAt',
            isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay),
          );
          break;
        case 'yesterday':
          final startOfYesterday = DateTime(now.year, now.month, now.day - 1);
          final endOfYesterday = DateTime(now.year, now.month, now.day);
          query = query
              .where(
                'createdAt',
                isGreaterThanOrEqualTo: Timestamp.fromDate(startOfYesterday),
              )
              .where(
                'createdAt',
                isLessThan: Timestamp.fromDate(endOfYesterday),
              );
          break;
        case 'thisWeek':
          int daysToSubtract = now.weekday - DateTime.monday;
          if (daysToSubtract < 0) daysToSubtract += 7;
          final startOfWeek = DateTime(
            now.year,
            now.month,
            now.day - daysToSubtract,
          );
          query = query.where(
            'createdAt',
            isGreaterThanOrEqualTo: Timestamp.fromDate(startOfWeek),
          );
          break;
        case 'thisMonth':
          final startOfMonth = DateTime(now.year, now.month, 1);
          query = query.where(
            'createdAt',
            isGreaterThanOrEqualTo: Timestamp.fromDate(startOfMonth),
          );
          break;
        default:
      }
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
              'action': log.data()['action'],
              'actionStatus': log.data()['actionStatus'],
              'userEmail': log.data()['userEmail'],
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
