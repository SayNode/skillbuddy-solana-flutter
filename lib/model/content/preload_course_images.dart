import 'preload_module_images.dart';

class PreloadCourseImages {
  PreloadCourseImages();

  PreloadCourseImages.fromJson(Map<String, dynamic> json)
      : currentLessonImages =
            createPreloadClassList(json['current_lesson_images']),
        nextLessonImages = createPreloadClassList(json['next_lesson_images']);
  List<PreloadModuleImages> currentLessonImages = <PreloadModuleImages>[];
  List<PreloadModuleImages> nextLessonImages = <PreloadModuleImages>[];

  static List<PreloadModuleImages> createPreloadClassList(List<dynamic> json) {
    return List<PreloadModuleImages>.generate(
      json.length,
      (int index) => PreloadModuleImages.fromJson(json[index]),
    );
  }
}
