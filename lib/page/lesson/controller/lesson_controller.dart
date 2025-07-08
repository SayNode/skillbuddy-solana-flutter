import 'package:get/get.dart';

import '../../../model/content/chapter.dart';
import '../../../model/content/course.dart';
import '../../../model/content/lesson.dart';
import '../../../model/content/module.dart';
import '../../../model/exception/content_fetch_exception.dart';
import '../../../model/last_visited_lesson.dart';
import '../../../model/quiz/lesson_quiz.dart';
import '../../../service/content_service.dart';
import '../../../service/user_state_service.dart';
import '../../explore_course/controller/discover_courses_controller.dart';
import '../../loading/loading_page.dart';
import '../../quiz/flow/quiz_page.dart';

class LessonController extends GetxController {
  LessonController({
    required this.course,
    required this.module,
    required this.lesson,
    required this.chapter,
    required this.enrolled,
  });

  final Course course;
  final Module module;
  final Lesson lesson;
  final Chapter chapter;
  final ContentService contentService = Get.put(ContentService());
  final bool enrolled;

  @override
  void onInit() {
    Get.find<UserStateService>().saveLastVisitedLesson(
      LastVisitedLesson(
        courseId: course.id,
        moduleSequence: module.sequence,
        chapterId: chapter.id,
        lessonId: lesson.id,
      ),
    );
    super.onInit();
  }

  @override
  void onClose() {
    Get.find<DiscoverCoursesController>().refreshCourses();
    super.onClose();
  }

  void startQuiz() {
    if (enrolled) {
      Get.off<void>(
        () => LoadingPage(
          title: 'Loading your next Quiz...'.tr,
          job: () async {
            try {
              final LessonQuiz quiz =
                  await contentService.getLessonQuiz(lesson.id);
              await Get.off<void>(
                () => QuizPage(
                  course: course,
                  module: module,
                  quiz: quiz,
                  lesson: lesson,
                  chapter: chapter,
                ),
              );
            } on ContentFetchException catch (e) {
              if (e.statusCode == 404) {
                Get
                  ..back<void>()
                  ..snackbar(
                    'Quiz not found'.tr,
                    'This lesson does not have a quiz yet'.tr,
                  );
                return;
              }
            }
          },
        ),
      );
    } else {
      Get.snackbar(
        'Not Enrolled'.tr,
        'You need to enroll in this course to take the quiz'.tr,
      );
    }
  }
}
