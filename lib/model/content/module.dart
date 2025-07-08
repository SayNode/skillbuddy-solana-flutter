import 'chapter.dart';

/// In the backend, this is the Chapter
/// In the SkillBuddy figma, this is the Module
///
class Module {
  Module();

  Module.fromJson(Map<String, dynamic> json)
      : name = json['name'] ?? '',
        sequence = json['sequence'] ?? 0,
        chapters = Chapter.createChapterList(json),
        isFirstTime = json['is_first_time'] ?? true,
        isCompleted = json['is_completed'] ?? false,
        activated = json['activated'] ?? false;

  String name = '';
  int sequence = 0;
  List<Chapter> chapters = <Chapter>[];
  bool isFirstTime = true;
  bool isCompleted = false;
  bool activated = false;

  Map<String, dynamic> toJson() => <String, dynamic>{};

  static List<Module> createModuleList(Map<String, dynamic> json) {
    final List<dynamic> untypedList = json['modules'] ?? <Chapter>[];
    final List<Module> moduleList = <Module>[];
    for (int i = 0; i < untypedList.length; i++) {
      final Module moduleFromJson = Module.fromJson(untypedList[i]);
      moduleList.add(moduleFromJson);
    }
    return moduleList;
  }
}
