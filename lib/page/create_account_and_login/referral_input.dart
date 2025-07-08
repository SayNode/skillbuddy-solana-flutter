import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../service/theme_service.dart';
import '../../theme/theme.dart';
import '../../theme/typography.dart';
import '../../util/util.dart';
import '../../widget/header_subheader.dart';
import '../../widget/skillbuddy_button.dart';
import '../../widget/skillbuddy_scaffold.dart';
import '../../widget/skillbuddy_textfield.dart';
import 'controller/input_referral_controller.dart';

class InputReferralPage extends GetView<InputReferralController> {
  const InputReferralPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomTheme skillBuddyTheme = ThemeService().theme;

    Get.put(InputReferralController());
    return SkillBuddyScaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: getRelativeWidth(15)),
        child: Column(
          children: <Widget>[
            HeaderAndSubHeader(
              header: 'Input Referral code'.tr,
              subHeader: 'Earn exciting bonuses with our referral program'.tr,
            ),
            Gap(getRelativeHeight(70)),
            SkillBuddyTextField(
              controller: controller.referralController,
            ),
            const Spacer(),
            SkillBuddyButton(
              text: 'Confirm'.tr,
              onTap: controller.onReferral,
            ),
            TextButton(
              onPressed: controller.skip,
              child: Text(
                'Skip'.tr,
                style: SkillBuddyTypography.fromColor(
                  skillBuddyTheme.electric,
                ).kParagraph,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
