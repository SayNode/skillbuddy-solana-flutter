import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../service/theme_service.dart';
import '../../service/user_state_service.dart';
import '../../theme/theme.dart';
import '../../theme/typography.dart';
import '../../util/util.dart';
import '../skillbuddy_button.dart';

class VerifyPopup extends StatelessWidget {
  const VerifyPopup({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomTheme skillBuddyTheme = ThemeService().theme;
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getRelativeWidth(20),
          vertical: getRelativeHeight(8),
        ),
        child: Column(
          children: <Widget>[
            const Gap(35),
            Text(
              'Verify'.tr,
              style: SkillBuddyTypography.fromColor(
                skillBuddyTheme.graphite,
              ).kTitle,
            ),
            const Gap(15),
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'You must be verified in order to withdraw funds.\n Please click verify below to receive your verification email.'
                        .tr,
                    textAlign: TextAlign.center,
                    style: SkillBuddyTypography.fromColor(
                      skillBuddyTheme.graphite,
                    ).kParagraph,
                  ),
                  const Gap(15),
                  SkillBuddyButton(
                    color: skillBuddyTheme.electric,
                    text: 'Verify'.tr,
                    onTap: () {
                      Get.find<UserStateService>().verification();
                      Get.close(1);
                    },
                  ),
                ],
              ),
            ),
            const Gap(10),
          ],
        ),
      ),
    );
  }
}
