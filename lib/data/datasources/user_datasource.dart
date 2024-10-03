import 'package:note_book_app/data/models/user_model.dart';

abstract class UserDatasource {
  Future<UserModel> loginWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<bool> logout();
  Future<UserModel> isLoggedIn();
  Future<UserModel> getUserInfor();
}
