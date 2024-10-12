import 'package:note_book_app/core/failures/failure.dart';

class InvalidParameterFailure extends Failure {
  InvalidParameterFailure() : super(message: "Tham số đầu vào không hợp lệ");
}
