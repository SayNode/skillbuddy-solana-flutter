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
import 'controller/quiz_results_controller.dart';

class QuizFailedPage extends GetView<QuizResultsController> {
  const QuizFailedPage({
    required this.correctAnswers,
    required this.answersAmount,
    required this.score,
    required this.course,
    required this.module,
    required this.chapter,
    required this.lesson,
    required this.lastLesson,
    super.key,
  });

  final int correctAnswers;
  final int answersAmount;
  final LessonScore score;
  final Course course;
  final Module module;
  final Chapter chapter;
  final Lesson lesson;
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
    return SkillBuddyScaffold(
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
                    "Let's master this!".tr,
                    textAlign: TextAlign.center,
                    style:
                        SkillBuddyTypography.fromColor(theme.graphite).kTitle,
                  ),
                  Gap(getRelativeHeight(12)),
                  Text(
                    'Oops, it looks like there were a few mistakes in your quiz answers. No worries!\n Mistakes are a natural part of learning.\n You need to get 75% correct to pass this module'
                        .tr,
                    textAlign: TextAlign.center,
                    style: SkillBuddyTypography.fromColor(theme.graphite)
                        .kParagraph,
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
                              style:
                                  SkillBuddyTypography.fromColor(theme.graphite)
                                      .kParagraph,
                            ),
                            Text(
                              '$correctAnswers/$answersAmount',
                              style:
                                  SkillBuddyTypography.fromColor(theme.graphite)
                                      .kParagraphSemiBold,
                            ),
                          ],
                        ),
                        Gap(getRelativeHeight(12)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'XP Collected'.tr,
                              style:
                                  SkillBuddyTypography.fromColor(theme.graphite)
                                      .kParagraph,
                            ),
                            Text(
                              '+${score.xpCollected} XP',
                              style:
                                  SkillBuddyTypography.fromColor(theme.graphite)
                                      .kParagraphSemiBold,
                            ),
                          ],
                        ),
                        const Spacer(flex: 2),
                      ],
                    ),
                  ),
                  Gap(getRelativeWidth(12)),
                  Obx(
                    () {
                      if (controller.riveFile.value != null) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          controller.loadRive();
                        });

                        return const SizedBox();
                      }
                      return const Expanded(
                        child: RiveAnimation.asset(
                          'asset/animations/Fourth_Crane.riv',
                          fit: BoxFit.fitHeight,
                        ),
                      );
                    },
                  ),
                  Gap(getRelativeWidth(12)),
                ],
              ),
            ),
            const Spacer(),
            SkillBuddyButton(
              text: 'Retake quiz'.tr,
              onTap: controller.retakeQuiz,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
