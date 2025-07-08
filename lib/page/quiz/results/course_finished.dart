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

class CourseFinishedPage extends GetView<QuizResultsController> {
  const CourseFinishedPage({
    required this.course,
    required this.module,
    required this.score,
    required this.chapter,
    required this.lesson,
    super.key,
  });

  final Course course;
  final Module module;
  final LessonScore score;
  final Chapter chapter;
  final Lesson lesson;

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
        true,
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
                    '${'Congratulations!'.tr} 🎉',
                    textAlign: TextAlign.center,
                    style:
                        SkillBuddyTypography.fromColor(theme.graphite).kTitle,
                  ),
                  Gap(getRelativeHeight(4)),
                  Text(
                    "You've completed the course".tr,
                    textAlign: TextAlign.center,
                    style:
                        SkillBuddyTypography.fromColor(theme.graphite).kTitle,
                  ),
                  Gap(getRelativeHeight(10)),
                  Text(
                    'You’ve successfully finished the course and can now claim your reward. Once claimed, your reward will be added to your balance.'
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
                          children: <Widget>[
                            Text(
                              '${controller.capitalizeFirstLetter(controller.score.rewardType)} :',
                              style:
                                  SkillBuddyTypography.fromColor(theme.graphite)
                                      .kParagraph,
                            ),
                            Gap(getRelativeWidth(20)),
                            Text(
                              '+${controller.score.rewardAmount}',
                              style:
                                  SkillBuddyTypography.fromColor(theme.graphite)
                                      .kParagraphSemiBold,
                            ),
                          ],
                        ),
                        Gap(getRelativeHeight(12)),
                        const Spacer(flex: 2),
                      ],
                    ),
                  ),
                  Gap(getRelativeWidth(12)),
                  const Expanded(
                    child: RiveAnimation.asset(
                      'asset/animations/Confetti_Crane.riv',
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            SkillBuddyButton(
              text: 'Claim Reward'.tr,
              onTap: () => controller.claimCourseReward(score.courseId),
            ),
            Obx(
              () => controller.errorMessage.value.isNotEmpty
                  ? Text(
                      controller.errorMessage.value,
                      style:
                          SkillBuddyTypography.fromColor(theme.red).kParagraph,
                    )
                  : const SizedBox.shrink(),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
