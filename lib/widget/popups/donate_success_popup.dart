import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../service/theme_service.dart';
import '../../theme/theme.dart';
import '../../theme/typography.dart';
import '../../util/util.dart';
import '../skillbuddy_button.dart';

class DonatePayoutSuccessPopup extends StatelessWidget {
  const DonatePayoutSuccessPopup({super.key});

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
              'Your rewards have made \n a difference!'.tr,
              style: SkillBuddyTypography.fromColor(
                skillBuddyTheme.graphite,
              ).kTitle,
              textAlign: TextAlign.center,
            ),
            Gap(getRelativeHeight(10)),
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Thank you for donating your rewards to the\nHuman Rights Foundation! Your contribution supports the fight for freedom and human \nrights worldwide.'
                        .tr,
                    textAlign: TextAlign.center,
                    style: SkillBuddyTypography.fromColor(
                      skillBuddyTheme.graphite,
                    ).kParagraph,
                  ),
                  Gap(getRelativeHeight(10)),
                ],
              ),
            ),
            SkillBuddyButton(
              text: 'Back to dashboard'.tr,
              onTap: () {
                Get.back<void>();
              },
            ),
            Gap(getRelativeHeight(20)),
          ],
        ),
      ),
    );
  }
}
