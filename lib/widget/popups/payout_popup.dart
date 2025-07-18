// ignore_for_file: inference_failure_on_function_invocation

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../page/solana/solana_service.dart';
import '../../service/theme_service.dart';
import '../../service/user_state_service.dart';
import '../../theme/theme.dart';
import '../../theme/typography.dart';
import '../../util/util.dart';
import '../controller/skillbody_navigation_bar_controller.dart';
import '../skillbuddy_button.dart';
import 'controller/payout_popup_controller.dart';

class PayoutPopup extends GetView<PayoutPopupController> {
  const PayoutPopup({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomTheme skillBuddyTheme = ThemeService().theme;
    final SolanaService solanaService = Get.find<SolanaService>();

    return Obx(() {
      return controller.isWalletConnected.value
          ? SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getRelativeWidth(20),
                  vertical: getRelativeHeight(8),
                ),
                child: Obx(
                  () => Column(
                    children: <Widget>[
                      const Gap(35),
                      Text(
                        'Withdraw your Bonk'.tr,
                        style: SkillBuddyTypography.fromColor(
                          skillBuddyTheme.graphite,
                        ).kTitle,
                      ),
                      const Gap(15),
                      Text(
                        '${solanaService.connectedAccountLabel.value} successfully connected'
                            .tr,
                        textAlign: TextAlign.center,
                        style: SkillBuddyTypography.fromColor(
                          skillBuddyTheme.green,
                        ).kParagraph,
                      ),
                      const Gap(30),
                      Obx(() {
                        return controller.payoutResponse.value.isEmpty
                            ? SizedBox(
                                width: context.width * 0.7,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          'Available Bonk:'.tr,
                                          style: SkillBuddyTypography.fromColor(
                                            skillBuddyTheme.graphite,
                                          ).kParagraph,
                                        ),
                                        Text(
                                          '${Get.find<UserStateService>().user.value.token}',
                                          style: SkillBuddyTypography.fromColor(
                                            skillBuddyTheme.graphite,
                                          ).kParagraph,
                                        ),
                                      ],
                                    ),
                                    Slider(
                                      value: controller.userPayoutAmount.value
                                                  .toDouble() >=
                                              1
                                          ? controller.userPayoutAmount.value
                                              .toDouble()
                                          : 1,
                                      onChanged: (double value) {
                                        controller.userPayoutAmount.value =
                                            value.toInt();
                                      },
                                      min: 1,
                                      max: Get.find<UserStateService>()
                                          .user
                                          .value
                                          .token
                                          .toDouble(),
                                      divisions: Get.find<UserStateService>()
                                          .user
                                          .value
                                          .token,
                                      label: controller.userPayoutAmount.value
                                          .toString(),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Column(
                                children: <Widget>[
                                  Text(
                                    '${controller.payoutResponse.value}. Requested amount ${controller.userPayoutAmount.value} Bonk'
                                        .tr,
                                    style: SkillBuddyTypography.fromColor(
                                      skillBuddyTheme.graphite,
                                    ).kParagraph,
                                    textAlign: TextAlign.center,
                                  ),
                                  const Gap(20),
                                  SkillBuddyButton(
                                    text: controller.payoutResponse.value
                                            .contains('failed')
                                        ? 'OK'.tr
                                        : 'Close'.tr,
                                    onTap: () {
                                      if (controller.payoutResponse.value
                                          .contains('failed')) {
                                        Get.back<void>();
                                        return;
                                      }
                                      Get
                                        ..back<void>()
                                        ..back<void>();
                                      Get.find<
                                              SkillBuddyNavigationBarController>()
                                          .changeIndex(NavigationBarPage.home);
                                      controller.payoutResponse.value = '';
                                    },
                                  ),
                                ],
                              );
                      }),
                      const Gap(30),
                      Obx(() {
                        return controller.payoutResponse.value.isEmpty
                            ? Column(
                                children: <Widget>[
                                  SkillBuddyButton(
                                    text:
                                        'Withdraw ${controller.userPayoutAmount.value} Bonk'
                                            .tr,
                                    onTap: () =>
                                        controller.sendBonkWithdrawalRequest(),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      await controller.deauthorizeWallet();
                                      Get.back<void>();
                                    },
                                    child: Text('Disconnect wallet'.tr),
                                  ),
                                ],
                              )
                            : const SizedBox();
                      }),
                      const Gap(10),
                    ],
                  ),
                ),
              ),
            )
          : SizedBox(
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
                      'Withdraw your Bonk'.tr,
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
                            'Begin the withdrawal process by connecting your Solana compatible wallet'
                                .tr,
                            textAlign: TextAlign.start,
                            style: SkillBuddyTypography.fromColor(
                              skillBuddyTheme.graphite,
                            ).kParagraph,
                          ),
                        ],
                      ),
                    ),
                    const Gap(30),
                    SkillBuddyButton(
                      text: 'Connect wallet'.tr,
                      onTap: controller.authorizeWallet,
                    ),
                    const Gap(10),
                  ],
                ),
              ),
            );
    });
  }
}
