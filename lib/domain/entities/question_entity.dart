class QuestionEntity {
  final String question;
  final String correctAnswer;
  final List<String> answers;

  QuestionEntity({
    required this.question,
    required this.correctAnswer,
    required this.answers,
  });
}
