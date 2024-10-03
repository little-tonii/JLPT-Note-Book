import 'package:dartz/dartz.dart';
import 'package:note_book_app/core/failures/failure.dart';
import 'package:note_book_app/domain/repositories/user_repository.dart';

class LogoutUsecase {
  final UserRepository userRepository;

  const LogoutUsecase({required this.userRepository});

  Future<Either<Failure, bool>> call() async {
    return await userRepository.logout();
  }
}
