import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

import '../../../service/theme_service.dart';
import '../../../theme/theme.dart';
import '../../../theme/typography.dart';
import '../../../util/util.dart';
import '../../../widget/skillbuddy_button.dart';
import '../../../widget/skillbuddy_scaffold.dart';
import 'controller/quiz_results_controller.dart';

class LevelUpScreen extends GetView<QuizResultsController> {
  const LevelUpScreen({
    required this.level,
    super.key,
  });
  final int level;

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.put(ThemeService()).theme;
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
                    '🎉 Level Up!',
                    textAlign: TextAlign.center,
                    style:
                        SkillBuddyTypography.fromColor(theme.graphite).kTitle,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    child: Text(
                      'You’ve just unlocked Level ${level + 1}! Keep going to unlock more rewards!'
                          .tr,
                      textAlign: TextAlign.center,
                      style: SkillBuddyTypography.fromColor(theme.graphite)
                          .kParagraph,
                    ),
                  ),
                ],
              ),
            ),
            const Expanded(
              flex: 4,
              child: Row(
                children: <Widget>[
                  Gap(12),
                  Expanded(
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
              text: 'Unlock Level ${level + 1}'.tr,
              onTap: () => Get.back<void>(),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
