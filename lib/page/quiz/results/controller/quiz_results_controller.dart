import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

import '../../../../model/content/chapter.dart';
import '../../../../model/content/course.dart';
import '../../../../model/content/lesson.dart';
import '../../../../model/content/lesson_score.dart';
import '../../../../model/content/module.dart';
import '../../../../model/exception/content_fetch_exception.dart';
import '../../../../service/content_service.dart';
import '../../../../service/reward_claim_and_payout_services.dart';
import '../../../../service/user_state_service.dart';
import '../../../explore_course/controller/course_controller.dart';
import '../../../lesson/lesson_page.dart';
import '../call_to_action_page.dart';
import '../course_finished.dart';
import '../level_up.dart';

class QuizResultsController extends GetxController {
  QuizResultsController(
    this.score,
    this.course,
    this.module,
    this.chapter,
    this.lesson,
    this.lastLesson,
  );
  late final Course course;
  late final Module module;
  late final Chapter chapter;
  late final Lesson lesson;
  late final LessonScore score;
  late final bool lastLesson;
  final CourseDetailsController courseController =
      Get.find<CourseDetailsController>();
  RxString errorMessage = ''.obs;

  Rx<RiveFile?> riveFile = Rx<RiveFile?>(null);

  Future<void> loadRive() async {
    final RiveFile riveFile = await RiveFile.asset(
      'asset/animations/Fourth_Crane.riv',
    );
    this.riveFile.value = riveFile;
  }

  Future<void> continueTheJourney() async {
    await checkForLevelUp();
    if (score.courseClaimable) {
      await Get.to<void>(
        () => CourseFinishedPage(
          course: course,
          module: module,
          score: score,
          chapter: chapter,
          lesson: lesson,
        ),
      );
    } else {
      if (lastLesson) {
        final int moduleIndex =
            courseController.modules.indexWhere((Module module) {
          try {
            module.chapters.firstWhere(
              (Chapter chapterComparison) => chapterComparison.id == chapter.id,
            );
            return true;
          } catch (e) {
            return false;
          }
        });

        final int chapterIndex =
            courseController.modules[moduleIndex].chapters.indexWhere(
          (Chapter chapterComparison) => chapterComparison.id == chapter.id,
        );
        final bool lastChapter = chapterIndex ==
            courseController.modules[moduleIndex].chapters.length - 1;
        if (lastChapter) {
          final bool lastModule =
              moduleIndex == courseController.modules.length - 1;
          if (lastModule) {
            // course claimed page is handled at the top of this function
            final NextStep? nextStep =
                await Get.find<ContentService>().courseNextStep(course.id);
            if (nextStep == null) {
              Get.back<void>();
              return;
            } else {
              // ignore: unawaited_futures
              Get.off<void>(
                () => CallToActionPage(
                  nextStep: nextStep,
                ),
              );
            }
            return;
          } else {
            Get.back<void>();
            await Get.to<void>(
              () => LessonPage(
                course: course,
                module: module,
                lesson: courseController
                    .modules[moduleIndex + 1].chapters.first.lessons.first,
                chapter:
                    courseController.modules[moduleIndex + 1].chapters.first,
                enrolled: courseController.isEnrolled.value,
              ),
            )?.then(
              (_) => courseController.fetchModulesAndLessons(),
            );
          }
        } else {
          Get.back<void>();
          await Get.to<void>(
            () => LessonPage(
              course: course,
              module: module,
              lesson: courseController.modules[moduleIndex]
                  .chapters[chapterIndex + 1].lessons.first,
              chapter: courseController
                  .modules[moduleIndex].chapters[chapterIndex + 1],
              enrolled: courseController.isEnrolled.value,
            ),
          )?.then(
            (_) => courseController.fetchModulesAndLessons(),
          );
        }
      } else {
        Get.back<void>();
        await Get.to<void>(
          () => LessonPage(
            course: course,
            module: module,
            lesson: chapter.lessons[chapter.lessons.indexOf(lesson) + 1],
            chapter: chapter,
            enrolled: courseController.isEnrolled.value,
          ),
        )?.then(
          (_) => courseController.fetchModulesAndLessons(),
        );
      }
    }
  }

  Future<void> checkForLevelUp() async {
    final UserStateService userService = Get.find<UserStateService>();
    final int currentLevel = userService.user.value.level;
    final int newLevel =
        await userService.get().then((_) => userService.user.value.level);
    if (newLevel > currentLevel) {
      await Get.to<void>(
        () => LevelUpScreen(
          level: newLevel,
        ),
      );
    }
  }

  String capitalizeFirstLetter(String input) {
    if (input.isEmpty) return input;
    return input[0].toUpperCase() + input.substring(1);
  }

  Future<void> claimCourseReward(int courseId) async {
    try {
      await RewardClaimAndPayoutService().claimCourseReward(courseId);
      await Get.find<UserStateService>().clearLastVisitedLesson();
      await Get.find<UserStateService>().get();
      await Get.find<UserStateService>().getNFTstatus();

      final NextStep? nextStep =
          await Get.find<ContentService>().courseNextStep(courseId);
      if (nextStep == null) {
        Get.close(3);
        return;
      } else {
        // ignore: unawaited_futures
        Get.off<void>(
          () => CallToActionPage(
            nextStep: nextStep,
          ),
        );
      }

      // ignore: unawaited_futures
      // ..to<void>(() => const CallToActionPage());
    } catch (e) {
      debugPrint('Error: $e');
      if (e is ContentFetchException) {
        errorMessage.value = e.body.toString();
      } else {
        errorMessage.value = 'Error: $e';
      }
    }
  }

  void retakeQuiz() {
    Get.off<void>(
      LessonPage(
        course: course,
        module: module,
        lesson: lesson,
        chapter: chapter,
        enrolled: courseController.isEnrolled.value,
      ),
    );
  }

  void lootBox() {
    debugPrint('lootBox');
    // TODO
  }
}
