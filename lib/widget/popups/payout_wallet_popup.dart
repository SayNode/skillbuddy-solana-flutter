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
import 'popup_manager.dart';

class PayoutWalletPopup extends GetView<PayoutPopupController> {
  const PayoutWalletPopup({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomTheme skillBuddyTheme = ThemeService().theme;
    final PayoutPopupController controller = Get.put(PayoutPopupController());
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
                      '• In the space provided below, input your wallet address.'
                          .tr,
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
                            'Double-check to ensure accuracy. A correct address is crucial for a successful payment'
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
                      '• Redeem your reward'.tr,
                      style: SkillBuddyTypography.fromColor(
                        skillBuddyTheme.graphite,
                      ).kParagraph,
                    ),
                  ),
                  const Gap(15),
                  SkillBuddyTextField(
                    hintText: 'Enter your wallet address:'.tr,
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
                onTap: () {
                  Get.back<void>();
                  PopupManager.openSuccessPopup();
                },
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
