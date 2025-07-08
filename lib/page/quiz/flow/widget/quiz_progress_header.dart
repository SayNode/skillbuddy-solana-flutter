import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../service/theme_service.dart';
import '../../../../theme/theme.dart';
import '../../../../theme/typography.dart';
import '../../../../util/util.dart';
import '../controller/quiz_controller.dart';

class QuizProgressHeader extends StatelessWidget {
  QuizProgressHeader({
    required this.questionStatus,
    super.key,
  });

  final List<QuizQuestionStatus> questionStatus;

  final CustomTheme theme = Get.put(ThemeService()).theme;

  Color colorText(QuizQuestionStatus status) {
    switch (status) {
      case QuizQuestionStatus.current:
        return theme.electric;
      case QuizQuestionStatus.upcoming:
        return theme.graphite;
      case QuizQuestionStatus.correct:
      case QuizQuestionStatus.incorrect:
        return theme.linen;
    }
  }

  Color colorFill(QuizQuestionStatus status) {
    switch (status) {
      case QuizQuestionStatus.current:
        return theme.seashell;
      case QuizQuestionStatus.upcoming:
        return Colors.transparent;
      case QuizQuestionStatus.correct:
        return theme.green;
      case QuizQuestionStatus.incorrect:
        return theme.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    final QuizController controller = Get.find<QuizController>();

    return Obx(() {
      // Update itemKeys if questionStatus length changes
      if (controller.itemKeys.length != controller.questionStatus.length) {
        controller.itemKeys = List<GlobalKey>.generate(
          controller.questionStatus.length,
          (int index) => GlobalKey(),
        );
      }

      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        controller: controller.scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        child: Row(
          children:
              List<Widget>.generate(controller.questionStatus.length, (int i) {
            return Padding(
              padding: EdgeInsets.only(
                right: i == controller.questionStatus.length - 1
                    ? 0
                    : getRelativeWidth(10),
              ),
              child: KeyedSubtree(
                key: controller.itemKeys[i],
                child: Material(
                  color: colorFill(controller.questionStatus[i]),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2),
                    side: controller.questionStatus[i] ==
                            QuizQuestionStatus.upcoming
                        ? BorderSide(
                            color: theme.seashell,
                          )
                        : BorderSide.none,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getRelativeWidth(34),
                      vertical: getRelativeHeight(4),
                    ),
                    child: Text(
                      (i + 1).toString(),
                      style: SkillBuddyTypography.fromColor(
                        colorText(controller.questionStatus[i]),
                      ).kParagraphSemiBold,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      );
    });
  }
}
