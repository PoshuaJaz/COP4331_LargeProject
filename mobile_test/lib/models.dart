class Problem {
  const Problem(
      this.id,
      this.exam_id,
      this.section,
      this.category,
      this.subcategory,
      this.question,
      this.answerCorrect,
      this.answersWrong,
    );
  
  final String id;
  final String exam_id;
  final String section;
  final String category;
  final String subcategory;
  final String question;
  final String answerCorrect;
  final List<String> answersWrong;

  factory Problem.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        "_id": String id,
        "exam_id": String exam_id,
        "section": String section,
        "category": String category,
        "subcategory": String subcategory,
        "question": String question,
        "answerCorrect": String answerCorrect,
        "answersWrong": List<String> answersWrong,
      } => Problem(
        id,
        exam_id,
        section,
        category,
        subcategory,
        question,
        answerCorrect,
        answersWrong,
      ),
      _ => throw const FormatException('Failed to load problem.'),
    };
  }

}

class Answer {
  Answer(
    this.id,
    this.user_id,
    this.problem_id,
    this.datetime,
    this.isCorrect,
    this.category,
    this.topic,
  );

  // answer constructor for a new answer object to be submitted to database
  Answer.newAnswer(
    this.user_id,
    this.problem_id,
    this.isCorrect,
    this.category,
    this.topic
  ) {
    id = "";
    datetime = DateTime.now();
  }

  late String id;
  String user_id;
  String problem_id;
  late DateTime datetime;
  bool isCorrect;
  String category;
  String topic;
}