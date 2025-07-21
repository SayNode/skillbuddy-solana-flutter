import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../service/theme_service.dart';
import '../../service/user_state_service.dart';
import '../../theme/theme.dart';
import '../../theme/typography.dart';
import '../../util/util.dart';
import '../skillbuddy_button.dart';
import '../skillbuddy_textfield.dart';
import 'controller/donate_controller.dart';

class DonatePopup extends GetView<DonatePopupController> {
  const DonatePopup({required this.charityAddress, super.key});

  final String charityAddress;

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
              'Donation Amount'.tr,
              style: SkillBuddyTypography.fromColor(
                skillBuddyTheme.graphite,
              ).kTitle,
            ),
            const Gap(10),
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Please enter the amount of Bonk you'd like to \ndonate. Every contribution makes a \ndifference!"
                        .tr,
                    textAlign: TextAlign.start,
                    style: SkillBuddyTypography.fromColor(
                      skillBuddyTheme.graphite,
                    ).kParagraph,
                  ),
                  Gap(getRelativeHeight(10)),
                  RichText(
                    text: TextSpan(
                      children: <InlineSpan>[
                        TextSpan(
                          text: 'Available: ',
                          style: SkillBuddyTypography.fromColor(
                            skillBuddyTheme.graphite,
                          ).kParagraph,
                        ),
                        TextSpan(
                          text: Get.find<UserStateService>()
                              .user
                              .value
                              .token
                              .toString(),
                          style: SkillBuddyTypography.fromColor(
                            skillBuddyTheme.graphite,
                          ).kParagraphSemiBold,
                        ),
                        TextSpan(
                          text: ' Bonk',
                          style: SkillBuddyTypography.fromColor(
                            skillBuddyTheme.graphite,
                          ).kParagraphSemiBold,
                        ),
                      ],
                    ),
                  ),
                  Gap(getRelativeHeight(10)),
                  SkillBuddyTextField(
                    hintText: 'Enter bonk here'.tr,
                    onChanged: (String value) {
                      // controller.updateText();
                    },
                    controller: controller.amountController,
                    keyBoardType: TextInputType.number,
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(right: 4),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: skillBuddyTheme
                                .seashell, // Blue color for the buttons
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              controller.amountController.text =
                                  controller.userToken.toString();
                            },
                            child: Text(
                              'Max',
                              style: SkillBuddyTypography.fromColor(
                                skillBuddyTheme.slate,
                              ).kParagraph,
                            ),
                          ),
                        ),
                        Gap(getRelativeWidth(2)),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: skillBuddyTheme
                                .seashell, // Blue color for the buttons
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              controller.amountController.text =
                                  (controller.userToken / 2).round().toString();
                            },
                            child: Text(
                              '50%',
                              style: SkillBuddyTypography.fromColor(
                                skillBuddyTheme.slate,
                              ).kParagraph,
                            ),
                          ),
                        ),
                        Gap(
                          getRelativeWidth(16),
                        ),
                      ],
                    ),
                  ),
                  Obx(
                    () => controller.error.value.isEmpty
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Center(
                              child: Text(
                                controller.error.value,
                                style: SkillBuddyTypography.fromColor(
                                  skillBuddyTheme.red,
                                ).kParagraph,
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
            Obx(
              () => controller.error.value.isEmpty
                  ? const Gap(30)
                  : const SizedBox(),
            ),
            Obx(
              () => SkillBuddyButton(
                text: 'Confirm'.tr,
                onTap: () => controller.donate(),
                locked: controller.loading.value ||
                    controller.amountText.value.isEmpty,
              ),
            ),
            const Gap(10),
          ],
        ),
      ),
    );
  }
}
