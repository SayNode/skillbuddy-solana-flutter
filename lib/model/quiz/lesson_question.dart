import 'lesson_answer.dart';

class LessonQuestion {
  LessonQuestion();

  LessonQuestion.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? -1,
        question = json['question'] ?? '',
        answers = createAnswerOptions(json);

  int id = -1;
  String question = '';
  List<LessonAnswer> answers = <LessonAnswer>[];

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'question': question,
        'answers': answers,
      };

  static List<LessonAnswer> createAnswerOptions(Map<String, dynamic> json) {
    final List<dynamic> untypedList = json['answers'] ?? <dynamic>[];
    final List<LessonAnswer> answers = <LessonAnswer>[];
    for (int i = 0; i < untypedList.length; i++) {
      final LessonAnswer answer = LessonAnswer.fromJson(untypedList[i]);
      answers.add(answer);
    }
    return answers..shuffle();
  }
}
