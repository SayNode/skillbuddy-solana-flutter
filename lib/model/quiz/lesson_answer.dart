class LessonAnswer {
  LessonAnswer();

  LessonAnswer.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? -1,
        answer = json['answer'] ?? '',
        answerCorrect =
            json['correct_answer'] is bool ? json['correct_answer'] : false;

  int id = -1;
  String answer = '';
  bool answerCorrect = false;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'answer_option': answer,
        'correct_answer': answerCorrect,
      };
}
