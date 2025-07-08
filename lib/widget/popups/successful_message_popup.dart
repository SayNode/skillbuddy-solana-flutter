import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../service/theme_service.dart';
import '../../theme/theme.dart';
import '../../theme/typography.dart';
import '../../util/util.dart';
import '../skillbuddy_button.dart';

class SuccessfulPopup extends StatelessWidget {
  const SuccessfulPopup({super.key});

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
              'Payout successful'.tr,
              style: SkillBuddyTypography.fromColor(
                skillBuddyTheme.graphite,
              ).kTitle,
            ),
            const Gap(15),
            Text(
              'Your payment has been successfully processed, and your funds are en route to your wallet'
                  .tr,
              style: SkillBuddyTypography.fromColor(
                skillBuddyTheme.graphite,
              ).kParagraph,
            ),
            const Gap(15),
            SkillBuddyButton(
              text: 'Back to dashboard'.tr,
              onTap: () {
                Get.back<void>();
              },
            ),
            const Gap(10),
          ],
        ),
      ),
    );
  }
}
