import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:note_book_app/core/failures/authentication_failure.dart';
import 'package:note_book_app/core/failures/firestore_failure.dart';
import 'package:note_book_app/data/datasources/user_datasource.dart';
import 'package:note_book_app/data/models/user_model.dart';

class UserDatasourceImpl implements UserDatasource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  UserDatasourceImpl({
    required this.firebaseAuth,
    required this.firebaseFirestore,
  });

  @override
  Future<UserModel> loginWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final userData = await firebaseFirestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      return UserModel.fromJson({
        'id': userData.id,
        'email': userData.data()!['email'],
        'fullName': userData.data()!['fullName'],
        'createdAt': userData.data()!['createdAt'],
        'role': userData.data()!['role'],
      });
    } on FirebaseException catch (e) {
      log(e.toString());
      if (e.code == 'invalid-email' ||
          e.code == 'wrong-password' ||
          e.code == 'invalid-credential') {
        throw AuthenticationFailure(
            message: "Email hoặc mật khẩu không chính xác");
      } else if (e.code == 'user-not-found') {
        throw AuthenticationFailure(message: "Người dùng không tồn tại");
      } else {
        throw FirestoreFailure(message: e.message.toString());
      }
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  @override
  Future<bool> logout() async {
    try {
      await firebaseAuth.signOut();
      return true;
    } on FirebaseException catch (e) {
      log(e.toString());
      throw FirestoreFailure(message: e.message.toString());
    } catch (e) {
      throw Exception(e);
    }
  }
}
