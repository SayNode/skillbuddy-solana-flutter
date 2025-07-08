/// In the backend, this is the Class
/// This is the SkillBuddy Lesson, according to Figma
///
class Lesson implements Comparable<Lesson> {
  Lesson();

  Lesson.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? -1,
        name = json['name'] ?? '',
        sequence = json['sequence'] ?? 0,
        isFirstTime = json['is_first_time'] ?? true,
        isCompleted = json['lesson_completed'] ?? false,
        content = json['content'] ?? '',
        image = json['image_content'] ?? '',
        activated = json['activated'] ?? false;

  int id = -1;
  String name = '';
  int sequence = 0;
  bool isFirstTime = true;
  bool isCompleted = false;
  String content = '';
  String image = '';
  bool activated = false;
  bool isLastInChapter = false;

  @override
  int compareTo(Lesson other) {
    return sequence.compareTo(other.sequence);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'sequence': sequence,
        'is_first_time': isFirstTime,
        'is_completed': isCompleted,
        'content': content,
        'image': image,
        'activated': activated,
      };

  static List<Lesson> createLessonList(Map<String, dynamic> json) {
    final List<dynamic> untypedList = json['lessons'] ?? <dynamic>[];
    final List<Lesson> lessonList = <Lesson>[];
    for (int i = 0; i < untypedList.length; i++) {
      final Lesson lessonFromJson = Lesson.fromJson(untypedList[i]);
      lessonList.add(lessonFromJson);
    }
    return lessonList;
  }
}
