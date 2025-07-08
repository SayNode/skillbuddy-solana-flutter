import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../service/theme_service.dart';
import '../../theme/theme.dart';
import '../../theme/typography.dart';
import '../../util/util.dart';
import '../skillbuddy_button.dart';

class TenantAccountDeletePopup extends StatelessWidget {
  const TenantAccountDeletePopup({super.key});

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
              "Can't delete account".tr,
              textAlign: TextAlign.center,
              style: SkillBuddyTypography.fromColor(
                skillBuddyTheme.graphite,
              ).kTitle,
            ),
            const Gap(15),
            Text(
              'This account is linked to your tenant profile. Use the tenant interface to manage it.'
                  .tr,
              textAlign: TextAlign.center,
              style: SkillBuddyTypography.fromColor(
                skillBuddyTheme.graphite,
              ).kParagraph,
            ),
            const Gap(15),
            SkillBuddyButton(
              text: 'Understood'.tr,
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
