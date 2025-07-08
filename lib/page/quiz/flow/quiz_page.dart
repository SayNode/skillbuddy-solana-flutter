import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../model/content/chapter.dart';
import '../../../model/content/course.dart';
import '../../../model/content/lesson.dart';
import '../../../model/content/module.dart';
import '../../../model/quiz/lesson_answer.dart';
import '../../../model/quiz/lesson_question.dart';
import '../../../model/quiz/lesson_quiz.dart';
import '../../../service/theme_service.dart';
import '../../../theme/theme.dart';
import '../../../theme/typography.dart';
import '../../../util/util.dart';
import '../../../widget/skillbuddy_button.dart';
import '../../../widget/skillbuddy_scaffold.dart';
import 'controller/quiz_controller.dart';
import 'widget/quiz_answer_card.dart';
import 'widget/quiz_progress_header.dart';

class QuizPage extends GetView<QuizController> {
  const QuizPage({
    required this.course,
    required this.module,
    required this.chapter,
    required this.quiz,
    required this.lesson,
    super.key,
  });
  final Course course;
  final Module module;
  final Chapter chapter;
  final LessonQuiz quiz;
  final Lesson lesson;

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.put(ThemeService()).theme;
    Get.put(
      QuizController(
        course: course,
        module: module,
        quiz: quiz,
        lesson: lesson,
        chapter: chapter,
      ),
    );
    return SkillBuddyScaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getRelativeWidth(18),
        ),
        child: Obx(
          () {
            final LessonQuestion question =
                controller.quiz.questionList[controller.currentQuestion.value];
            return Column(
              children: <Widget>[
                Gap(getRelativeHeight(20)),
                Text(
                  'Quiz'.tr,
                  style: SkillBuddyTypography.fromColor(theme.graphite).kTitle,
                ),
                Gap(getRelativeHeight(20)),
                QuizProgressHeader(
                  questionStatus: controller.questionStatus,
                ),
                Gap(getRelativeHeight(20)),
                Text(
                  question.question,
                  style: SkillBuddyTypography.fromColor(theme.graphite)
                      .kParagraphSemiBold,
                ),
                Gap(getRelativeHeight(50)),
                if (question.answers.isNotEmpty)
                  ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (_, int i) {
                      final LessonAnswer answer = question.answers[i];
                      return Obx(
                        () => QuizAnswerCard(
                          letter: letterFromIndex(i),
                          answer: answer.answer,
                          onTap: () => controller.onAnswerTap(i),
                          status: controller.answerStatus[i],
                        ),
                      );
                    },
                    separatorBuilder: (_, int i) => Gap(getRelativeHeight(20)),
                    itemCount: question.answers.length,
                  ),
                const Spacer(flex: 2),
                Text(
                  controller.feedbackMessage.value,
                  style: SkillBuddyTypography.fromColor(
                    controller.quizAnswerStatus.value ==
                            QuizAnswerStatus.correct
                        ? theme.green
                        : theme.red,
                  ).kTitle,
                ),
                const Spacer(),
                SkillBuddyButton(
                  onTap: controller.selectedIndex.value != -1
                      ? controller.onConfirmAnswer
                      : controller.onTapToProceed,
                  locked: controller.quizAnswerStatus.value ==
                          QuizAnswerStatus.neutral ||
                      controller.validating.value,
                  text: controller.quizAnswerStatus.value ==
                              QuizAnswerStatus.neutral ||
                          controller.quizAnswerStatus.value ==
                              QuizAnswerStatus.selected
                      ? 'Check answer'
                      : controller.quizAnswerStatus.value ==
                              QuizAnswerStatus.correct
                          ? 'Continue'.tr
                          : 'Got it'.tr,
                  color: controller.quizAnswerStatus.value ==
                          QuizAnswerStatus.selected
                      ? theme.electric
                      : controller.quizAnswerStatus.value ==
                              QuizAnswerStatus.correct
                          ? theme.green
                          : theme.red,
                ),
                const Gap(20),
              ],
            );
          },
        ),
      ),
    );
  }
}
