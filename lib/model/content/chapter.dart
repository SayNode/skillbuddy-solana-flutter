import 'lesson.dart';

/// In the backend, this is the Lesson
/// In SkillBuddy figma, this is the Chapter
///
class Chapter {
  Chapter();

  Chapter.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? -1,
        name = json['name'] ?? '',
        sequence = json['sequence'] ?? 0,
        lessons = Lesson.createLessonList(json),
        chapterCompleted = json['chapter_completed'] ?? false,
        isFirstTime = json['is_first_time'] ?? true,
        activated = json['activated'] ?? false;

  int id = -1;
  String name = '';
  int sequence = 0;
  List<Lesson> lessons = <Lesson>[];
  bool chapterCompleted = false;
  bool isFirstTime = true;
  bool activated = false;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'sequence': sequence,
        'lessons': lessons,
        'chapter_completed': chapterCompleted,
        'is_first_time': isFirstTime,
        'activated': activated,
      };

  static List<Chapter> createChapterList(Map<String, dynamic> json) {
    final List<dynamic> untypedList = json['chapters'] ?? <dynamic>[];
    final List<Chapter> chapterList = <Chapter>[];
    for (int i = 0; i < untypedList.length; i++) {
      final Chapter chapterFromJson = Chapter.fromJson(untypedList[i]);
      chapterList.add(chapterFromJson);
    }
    return chapterList;
  }
}
