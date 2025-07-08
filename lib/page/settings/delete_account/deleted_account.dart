import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../service/theme_service.dart';
import '../../../theme/theme.dart';
import '../../../theme/typography.dart';
import '../../../util/util.dart';
import '../../../widget/skillbuddy_button.dart';
import '../../../widget/skillbuddy_scaffold.dart';
import 'controller/delete_account_controller.dart';

class DeletedAccountPage extends GetView<DeleteAccountController> {
  const DeletedAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.put(ThemeService()).theme;
    Get.put(DeleteAccountController());
    return SkillBuddyScaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: getRelativeWidth(18)),
        child: Column(
          children: <Widget>[
            const Spacer(),
            Text(
              'Your account has been successfully deleted'.tr,
              textAlign: TextAlign.center,
              style: SkillBuddyTypography.fromColor(theme.graphite).kTitle,
            ),
            Gap(getRelativeHeight(14)),
            Text(
              "We appreciate the time you spent with us. If you ever decide to return, you're always welcome.\nIf you have any feedback or need assistance, please don't hesitate to reach out to our support team."
                  .tr,
              textAlign: TextAlign.center,
              style: SkillBuddyTypography.fromColor(theme.slate).kParagraph,
            ),
            Gap(getRelativeHeight(27)),
            Text(
              'With love, SkillBuddy Team'.tr,
              textAlign: TextAlign.center,
              style: SkillBuddyTypography.fromColor(theme.slate).kParagraph,
            ),
            const Spacer(
              flex: 2,
            ),
            SkillBuddyButton(
              text: 'Login'.tr,
              onTap: controller.goToLogin,
            ),
            TextButton(
              onPressed: null,
              child: Text(
                '',
                style: SkillBuddyTypography.fromColor(
                  Colors.transparent,
                ).kParagraphSemiBold,
              ),
            ),
            Gap(getRelativeHeight(9)),
          ],
        ),
      ),
    );
  }
}
