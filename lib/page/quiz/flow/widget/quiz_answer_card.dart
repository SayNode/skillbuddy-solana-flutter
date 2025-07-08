import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../service/theme_service.dart';
import '../../../../theme/theme.dart';
import '../../../../theme/typography.dart';
import '../../../../util/util.dart';
import '../controller/quiz_controller.dart';

class QuizAnswerCard extends StatelessWidget {
  QuizAnswerCard({
    required this.letter,
    required this.answer,
    required this.status,
    super.key,
    this.onTap,
  });

  final String letter;
  final String answer;
  final dynamic Function()? onTap;
  final QuizAnswerStatus status;

  final double _thickness = 1;

  final CustomTheme theme = Get.put(ThemeService()).theme;

  Color colorText(QuizAnswerStatus status) {
    switch (status) {
      case QuizAnswerStatus.neutral:
        return theme.slate;
      case QuizAnswerStatus.selected:
      case QuizAnswerStatus.validating:
      case QuizAnswerStatus.correct:
      case QuizAnswerStatus.incorrect:
        return theme.linen;
    }
  }

  Color colorBorder(QuizAnswerStatus status) {
    switch (status) {
      case QuizAnswerStatus.neutral:
        return theme.graphite;
      case QuizAnswerStatus.selected:
        return theme.electric;
      case QuizAnswerStatus.validating:
        return theme.electric;
      case QuizAnswerStatus.correct:
        return theme.green;
      case QuizAnswerStatus.incorrect:
        return theme.red;
    }
  }

  Color colorFill(QuizAnswerStatus status) {
    switch (status) {
      case QuizAnswerStatus.neutral:
        return Colors.transparent;
      case QuizAnswerStatus.selected:
        return theme.electric;
      case QuizAnswerStatus.validating:
        return theme.electric;
      case QuizAnswerStatus.correct:
        return theme.green;
      case QuizAnswerStatus.incorrect:
        return theme.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: colorBorder(status), width: _thickness),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        enableFeedback: status == QuizAnswerStatus.neutral,
        child: IntrinsicHeight(
          child: Row(
            children: <Widget>[
              Expanded(
                child: Material(
                  color: colorFill(status),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Center(
                      child: Text(
                        letter,
                        style: SkillBuddyTypography.fromColor(
                          colorText(status),
                        ).kParagraphSemiBold,
                      ),
                    ),
                  ),
                ),
              ),
              VerticalDivider(
                color: colorBorder(status),
                width: _thickness,
                thickness: _thickness,
              ),
              Expanded(
                flex: 9,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: getRelativeHeight(12),
                    horizontal: getRelativeWidth(8),
                  ),
                  child: Text(
                    answer,
                    style:
                        SkillBuddyTypography.fromColor(theme.slate).kParagraph,
                  ),
                ),
              ),
              if (status == QuizAnswerStatus.validating)
                SizedBox(
                  height: getRelativeHeight(18),
                  width: getRelativeWidth(18),
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                )
              else
                SizedBox(
                  height: getRelativeHeight(18),
                  width: getRelativeWidth(18),
                ),
              const Gap(12),
            ],
          ),
        ),
      ),
    );
  }
}
