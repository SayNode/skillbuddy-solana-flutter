import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../../../model/content/course.dart';
import '../../../service/content_service.dart';
import '../../../widget/controller/skillbody_navigation_bar_controller.dart';
import '../../explore_course/course_page.dart';

class MyCoursesController extends GetxController {
  final ContentService _contentService = Get.find<ContentService>();

  Future<void> init() async {
    debugPrint('MyCoursesController - initializing ...');
    super.onInit();
  }

  int? courseToOpenId; // The ID of the course we want to open.

  RxBool loading = false.obs;

  ContentService contentService = Get.put(ContentService());

  Future<void> addCourse() async {
    Get.find<SkillBuddyNavigationBarController>().selectedPageIndex.value = 0;
  }

  void openEnrolledCourseDetails(int courseId) {
    final Course myCourseWrapper =
        _contentService.myCourses.data.value.firstWhere(
      (Course element) => element.id == courseId,
      orElse: () => throw Exception('Course not found!'),
    );
    final bool openFirstLesson = myCourseWrapper.progress <= 0;
    goToCourseDetails(
      myCourseWrapper,
      autoOpenFirstLesson: openFirstLesson,
    );
  }

  Future<void> goToCourseDetails(
    Course course, {
    bool autoOpenFirstLesson = false,
  }) async {
    // ignore: inference_failure_on_function_invocation
    await Get.to(
      () => CoursePage(
        courseId: course.id,
        autoOpenFirstLesson: autoOpenFirstLesson,
      ),
    );
  }

  Future<void> removeCourse(Course course) async {
    final bool isUnenroll = await contentService.unenrollCourse(course.id);
    if (isUnenroll) {
      await contentService.myCourses.reload();
    }
  }

  Future<void> resetProgress(Course course) async {
    final bool isResetProgress = await contentService.resetProgress(course.id);
    if (isResetProgress) {
      await contentService.myCourses.reload();
    }
  }

  void shareCourse(Course course) {
    Share.share(
      "Hey! I'm learning with SkillBuddy and my current course is ${course.name}. Discover the exciting world of blockchain, web3, and technology while earning rewards! SkillBuddy's bite-sized courses make learning easy and enjoyable. Don't just learn, get rewarded for it — all for free.\n\nFor ios click here: https://apps.apple.com/ch/app/skillbuddy-io/id6473525692?l=en-GB \n\nFor android click here: https://play.google.com/store/apps/details?id=io.skillbuddy.academy",
    );
  }
}
