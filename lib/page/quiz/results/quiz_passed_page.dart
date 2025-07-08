import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

import '../../../model/content/chapter.dart';
import '../../../model/content/course.dart';
import '../../../model/content/lesson.dart';
import '../../../model/content/lesson_score.dart';
import '../../../model/content/module.dart';
import '../../../service/theme_service.dart';
import '../../../theme/theme.dart';
import '../../../theme/typography.dart';
import '../../../util/util.dart';
import '../../../widget/skillbuddy_button.dart';
import '../../../widget/skillbuddy_scaffold.dart';
import '../../explore_course/controller/course_controller.dart';
import 'controller/quiz_results_controller.dart';

class QuizPassedPage extends GetView<QuizResultsController> {
  const QuizPassedPage({
    required this.course,
    required this.module,
    required this.chapter,
    required this.lesson,
    required this.correctAnswers,
    required this.answersAmount,
    required this.score,
    required this.lastLesson,
    super.key,
  });
  final Course course;
  final Module module;
  final Chapter chapter;
  final Lesson lesson;
  final int correctAnswers;
  final int answersAmount;
  final LessonScore score;
  final bool lastLesson;

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.put(ThemeService()).theme;
    Get.put(
      QuizResultsController(
        score,
        course,
        module,
        chapter,
        lesson,
        lastLesson,
      ),
    );
    return PopScope(
      onPopInvokedWithResult: (bool didPop, dynamic result) {
        if (didPop) {
          Get.find<CourseDetailsController>().fetchModulesAndLessons();
        }
      },
      child: SkillBuddyScaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getRelativeWidth(18),
          ),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '${'Congratulations'.tr}🎉',
                      textAlign: TextAlign.center,
                      style:
                          SkillBuddyTypography.fromColor(theme.graphite).kTitle,
                    ),
                    Gap(getRelativeHeight(12)),
                    Text(
                      "You've successfully completed the quiz. Your understanding of the topic is impressive.\nKeep up the great work!"
                          .tr,
                      textAlign: TextAlign.center,
                      style: SkillBuddyTypography.fromColor(theme.graphite)
                          .kParagraph,
                    ),
                    if (score.lootBox.isNotEmpty) Gap(getRelativeHeight(12)),
                    if (score.lootBox.isNotEmpty)
                      RichText(
                        text: TextSpan(
                          children: <InlineSpan>[
                            TextSpan(
                              text: '${'It is a'.tr} ',
                              style:
                                  SkillBuddyTypography.fromColor(theme.graphite)
                                      .kParagraphSemiBold,
                            ),
                            TextSpan(
                              text: 'Loot Box'.tr,
                              style:
                                  SkillBuddyTypography.fromColor(theme.electric)
                                      .kParagraphSemiBold,
                              recognizer: TapGestureRecognizer()
                                ..onTap = controller.lootBox,
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Your Score'.tr,
                                style: SkillBuddyTypography.fromColor(
                                  theme.graphite,
                                ).kParagraph,
                              ),
                              Text(
                                '$correctAnswers/$answersAmount',
                                style: SkillBuddyTypography.fromColor(
                                  theme.graphite,
                                ).kParagraphSemiBold,
                              ),
                            ],
                          ),
                          Gap(getRelativeHeight(12)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'XP Collected'.tr,
                                style: SkillBuddyTypography.fromColor(
                                  theme.graphite,
                                ).kParagraph,
                              ),
                              Text(
                                '+${score.xpCollected} XP',
                                style: SkillBuddyTypography.fromColor(
                                  theme.graphite,
                                ).kParagraphSemiBold,
                              ),
                            ],
                          ),
                          const Spacer(flex: 2),
                        ],
                      ),
                    ),
                    Gap(getRelativeWidth(12)),
                    Expanded(
                      child: Transform.flip(
                        flipX: true,
                        child: const RiveAnimation.asset(
                          'asset/animations/first_crane.riv',
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              SkillBuddyButton(
                text: 'Continue the journey'.tr,
                onTap: controller.continueTheJourney,
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
