import 'lesson_question.dart';

class LessonQuiz {
  LessonQuiz();

  LessonQuiz.fromJson(List<dynamic> json)
      : questionList = createQuestionList(json);

  List<LessonQuestion> questionList = <LessonQuestion>[];

  Map<String, dynamic> toJson() => <String, dynamic>{
        'results': questionList,
      };

  static List<LessonQuestion> createQuestionList(List<dynamic> untypedList) {
    final List<LessonQuestion> questionListReturn = <LessonQuestion>[];
    for (int i = 0; i < untypedList.length; i++) {
      final LessonQuestion question = LessonQuestion.fromJson(untypedList[i]);
      questionListReturn.add(question);
    }
    return questionListReturn..shuffle();
  }
}
