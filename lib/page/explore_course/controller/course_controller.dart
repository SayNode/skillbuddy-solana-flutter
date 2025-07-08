import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../model/content/chapter.dart';
import '../../../model/content/course.dart';
import '../../../model/content/lesson.dart';
import '../../../model/content/module.dart';
import '../../../model/last_visited_lesson.dart';
import '../../../service/content_service.dart';
import '../../../widget/popups/popup_manager.dart';
import '../../lesson/lesson_page.dart';

class CourseDetailsController extends GetxController {
  CourseDetailsController(
    this.courseId, {
    this.lastVisitedLesson,
    this.autoOpenFirstLesson = false,
  });

  LastVisitedLesson? lastVisitedLesson;
  bool autoOpenFirstLesson;

  late int courseId;
  late RxBool isEnrolled = false.obs;

  Rx<Course> course = Course().obs;
  RxList<Module> modules = <Module>[].obs;
  RxDouble progress = 0.0.obs;

  ContentService contentService = Get.find<ContentService>();

  RxBool enrolling = false.obs;
  RxBool loading = false.obs;

  @override
  Future<void> onInit() async {
    loading.value = true;
    await fetchModulesAndLessons();
    getUserEnrolledCourses();

    // Conditions to auto-open the first lesson:
    // 1. Not loading
    // 2. User is enrolled
    // 3. autoOpenFirstLesson is true
    // 4. Lesson not opened yet
    // 5. There is at least one module, one chapter, and one lesson
    if (!loading.value &&
        isEnrolled.value &&
        autoOpenFirstLesson &&
        modules.isNotEmpty &&
        modules[0].chapters.isNotEmpty &&
        modules[0].chapters[0].lessons.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final Module firstModule = modules[0];
        final Chapter firstChapter = firstModule.chapters[0];
        final Lesson firstLesson = firstChapter.lessons[0];
        onLessonTap(firstModule, firstChapter, firstLesson);
      });
    }

    if (course.value.progress > 0 && course.value.progress < 100) {
      try {
        final int currentLessonId = modules
            .skipWhile((Module module) => module.isCompleted)
            .elementAt(0)
            .chapters
            .skipWhile((Chapter chapter) => chapter.chapterCompleted)
            .elementAt(0)
            .lessons
            .skipWhile((Lesson lesson) => lesson.isCompleted)
            .elementAt(0)
            .id;
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => Scrollable.ensureVisible(
            GlobalObjectKey(currentLessonId).currentContext!,
            duration: 1.seconds,
          ),
        );
      } catch (_) {}
    }

    loading.value = false;
    super.onInit();
  }

  void getUserEnrolledCourses() {
    final List<Course> courses = <Course>[];
    for (final Course courseProgressTuple
        in contentService.myCourses.data.value) {
      courses.add(courseProgressTuple);
    }
    final List<int> enrolledCourseList =
        courses.map((Course e) => e.id).toList();
    isEnrolled.value = enrolledCourseList.any((int e) => e == courseId);
  }

  Future<void> fetchModulesAndLessons() async {
    // Fetch the modules and course details
    final CourseModulesTuple result =
        await contentService.getAllModulesFromCourse(courseId);

    // Filter and sort modules
    final List<Module> filteredModules = result.modules
        .where(
          (Module module) => module.activated,
        ) // Only include activated modules
        .map((Module module) {
          // Filter activated chapters
          module.chapters = module.chapters.where((Chapter chapter) {
            // Filter activated lessons
            chapter.lessons = chapter.lessons
                .where((Lesson? lesson) => lesson != null && lesson.activated)
                .toList();
            // Include chapter only if it has activated lessons
            return chapter.activated && chapter.lessons.isNotEmpty;
          }).toList();
          // Include module only if it has activated chapters
          return module;
        })
        .where((Module module) => module.chapters.isNotEmpty)
        .toList();

    // Sort modules by sequence
    sortBySequence(filteredModules);

    // Update state
    modules.value = filteredModules;
    progress.value = result.course.progress;
    course.value = result.course;
  }

  void sortBySequence(List<Module> modules) {
    modules.sort((Module a, Module b) => a.sequence.compareTo(b.sequence));
    for (final Module module in modules) {
      if (module.chapters.isEmpty) {
        continue;
      }
      module.chapters
          .sort((Chapter a, Chapter b) => a.sequence.compareTo(b.sequence));
      for (final Chapter chapter in module.chapters) {
        if (chapter.lessons.isEmpty) {
          continue;
        }
        chapter.lessons.sort((Lesson? a, Lesson? b) {
          if (a == null || b == null) {
            return 0; // Handle null cases as needed
          }
          return a.sequence.compareTo(b.sequence);
        });
      }
    }
  }

  void onLessonTap(Module module, Chapter chapter, Lesson lesson) {
    Get.to<void>(
      () => LessonPage(
        course: course.value,
        module: module,
        lesson: lesson,
        chapter: chapter,
        enrolled: isEnrolled.value,
      ),
    )?.then(
      (_) => fetchModulesAndLessons(),
    );
  }

  Future<void> onEnrollTap() async {
    enrolling.value = true;
    final bool enrollSuccess = await contentService.enrollCourse(courseId);
    if (enrollSuccess) {
      unawaited(
        PopupManager.openCourseAddedPopup(courseId: courseId).then((_) {
          onLessonTap(
            modules[0],
            modules[0].chapters[0],
            modules[0].chapters[0].lessons[0],
          );
        }),
      );
      isEnrolled.value = true;
      await contentService.fetchData();
    }
    enrolling.value = false;
  }

  bool isCurrentLesson(int moduleIndex, int chapterIndex, int lessonIndex) {
    final Chapter chapter = modules[moduleIndex].chapters[chapterIndex];
    final Lesson lesson = chapter.lessons[lessonIndex];
    if (lessonIndex == 0) {
      return !lesson.isCompleted &&
          !isLessonLocked(moduleIndex, chapterIndex, lessonIndex);
    }

    final Lesson previousLesson = chapter.lessons[lessonIndex - 1];
    return !lesson.isCompleted && previousLesson.isCompleted;
  }

  bool isLessonLocked(int moduleIndex, int chapterIndex, int lessonIndex) {
    if (lessonIndex == 0) return isChapterLocked(moduleIndex, chapterIndex);

    final Chapter chapter = modules[moduleIndex].chapters[chapterIndex];
    final Lesson lesson = chapter.lessons[lessonIndex];
    final Lesson previousLesson = chapter.lessons[lessonIndex - 1];

    return !lesson.isCompleted && !previousLesson.isCompleted;
  }

  bool isChapterLocked(int moduleIndex, int chapterIndex) {
    if (chapterIndex == 0) return isModuleLocked(moduleIndex);

    final Chapter chapter = modules[moduleIndex].chapters[chapterIndex];
    final Chapter previousChapter =
        modules[moduleIndex].chapters[chapterIndex - 1];

    return !chapter.chapterCompleted && !previousChapter.chapterCompleted;
  }

  bool isModuleLocked(int moduleIndex) {
    if (moduleIndex == 0) return !isEnrolled.value;

    final Module module = modules[moduleIndex];
    final Module previousModule = modules[moduleIndex - 1];

    return !module.isCompleted && !previousModule.isCompleted;
  }
}
