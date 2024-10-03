import 'package:dartz/dartz.dart';
import 'package:note_book_app/core/failures/failure.dart';
import 'package:note_book_app/domain/entities/user_entity.dart';
import 'package:note_book_app/domain/repositories/user_repository.dart';

class LoginWithEmailAndPasswordUsecase {
  final UserRepository userRepository;

  const LoginWithEmailAndPasswordUsecase({required this.userRepository});

  Future<Either<Failure, UserEntity>> call({
    required String email,
    required String password,
  }) async {
    return await userRepository.loginWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
