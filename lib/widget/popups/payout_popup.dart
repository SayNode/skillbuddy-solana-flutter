// ignore_for_file: inference_failure_on_function_invocation

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../service/theme_service.dart';
import '../../theme/theme.dart';
import '../../theme/typography.dart';
import '../../util/util.dart';
import '../skillbuddy_button.dart';
import '../skillbuddy_textfield.dart';
import 'controller/payout_popup_controller.dart';

class PayoutPopup extends GetView<PayoutPopupController> {
  const PayoutPopup({super.key});

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
              'Payout'.tr,
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
                    'You must:'.tr,
                    textAlign: TextAlign.start,
                    style: SkillBuddyTypography.fromColor(
                      skillBuddyTheme.graphite,
                    ).kParagraph,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getRelativeWidth(10),
                    ),
                    child: Text(
                      '• Use a lightning wallet'.tr,
                      style: SkillBuddyTypography.fromColor(
                        skillBuddyTheme.graphite,
                      ).kParagraph,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getRelativeWidth(10),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '• ',
                          style: SkillBuddyTypography.fromColor(
                            skillBuddyTheme.graphite,
                          ).kParagraph,
                        ),
                        Expanded(
                          child: Text(
                            'Create an invoice for the amount you want to redeem (if the amount is more than your balance, it will not work)'
                                .tr,
                            style: SkillBuddyTypography.fromColor(
                              skillBuddyTheme.graphite,
                            ).kParagraph,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getRelativeWidth(10),
                    ),
                    child: Text(
                      '• Enter your invoice below & redeem!'.tr,
                      style: SkillBuddyTypography.fromColor(
                        skillBuddyTheme.graphite,
                      ).kParagraph,
                    ),
                  ),
                  const Gap(15),
                  SkillBuddyTextField(
                    hintText: 'Enter lightning invoice'.tr,
                    controller: controller.lightningInvoiceController,
                    onChanged: (String value) {
                      controller.updateText();
                    },
                  ),
                  const Gap(15),
                ],
              ),
            ),
            Obx(
              () => SkillBuddyButton(
                text: 'Redeem'.tr,
                onTap: controller.getPayoutMessage,
                locked: !controller.isInvoiceValid.value,
              ),
            ),
            const Gap(10),
          ],
        ),
      ),
    );
  }
}
