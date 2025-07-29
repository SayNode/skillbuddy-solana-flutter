// ignore_for_file: inference_failure_on_function_invocation

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

// import '../../page/solana/solana_service.dart';
import '../../service/theme_service.dart';
import '../../theme/theme.dart';
import '../../theme/typography.dart';
import '../../util/util.dart';
import '../skillbuddy_button.dart';
import 'controller/redeem_ntf_popup_controller.dart';

class RedeemNFTPopup extends GetView<RedeemNFTPopupController> {
  const RedeemNFTPopup({required this.nftNumber, super.key});

  final int nftNumber;

  @override
  Widget build(BuildContext context) {
    final CustomTheme skillBuddyTheme = ThemeService().theme;
    // final SolanaService solanaService = Get.find<SolanaService>();

    return Obx(
      () => SizedBox(
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
                'Redeem your NFT'.tr,
                style: SkillBuddyTypography.fromColor(
                  skillBuddyTheme.graphite,
                ).kTitle,
              ),
              const Gap(15),
              SizedBox(
                width: double.infinity,
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      controller.isWalletConnected.value
                          ? 'Your wallet is connected: ${controller.walletAddress.value}'
                              .tr
                          : 'Begin the redemption process by connecting your Solana compatible wallet'
                              .tr,
                      textAlign: TextAlign.center,
                      style: SkillBuddyTypography.fromColor(
                        skillBuddyTheme.graphite,
                      ).kParagraph,
                    ),
                  ],
                ),
              ),
              const Gap(30),
              SkillBuddyButton(
                text: controller.isWalletConnected.value
                    ? 'Redeem'.tr
                    : 'Connect wallet'.tr,
                onTap: controller.isWalletConnected.value
                    ? () => controller.authorizeWallet()
                    : () => controller.redeemNFT(nftNumber),
              ),
              const Gap(10),
            ],
          ),
        ),
      ),
    );
  }
}
