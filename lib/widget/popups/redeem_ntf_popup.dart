// ignore_for_file: inference_failure_on_function_invocation

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../page/profile/widget/nft_badge_card.dart';
import '../../page/solana/solana_service.dart';
import '../../service/theme_service.dart';
import '../../theme/theme.dart';
import '../../theme/typography.dart';
import '../../util/util.dart';
import '../skillbuddy_button.dart';
import 'controller/redeem_ntf_popup_controller.dart';

class RedeemNFTPopup extends GetView<RedeemNFTPopupController> {
  const RedeemNFTPopup({
    required this.nftNumber,
    required this.status,
    super.key,
  });

  final int nftNumber;
  final NftBadgeStatus status;

  @override
  Widget build(BuildContext context) {
    final CustomTheme skillBuddyTheme = ThemeService().theme;
    final SolanaService solanaService = Get.find<SolanaService>();

    if (status == NftBadgeStatus.redeemed) {
      return SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getRelativeWidth(20),
            vertical: getRelativeHeight(20),
          ),
          child: Column(
            children: <Widget>[
              const Gap(35),
              Text(
                'NFT Redeemed'.tr,
                style: SkillBuddyTypography.fromColor(
                  skillBuddyTheme.graphite,
                ).kTitle,
              ),
              const Gap(15),
              SizedBox(
                width: double.infinity,
                child: Column(
                  spacing: 10,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        nftNumber == 1
                            ? 'asset/images/nfts/explorer.jpg'
                            : 'asset/images/nfts/journey.jpg',
                        height: 150,
                        // color: skillBuddyTheme.linen.withValues(alpha: 0.6),
                        // colorBlendMode: BlendMode.darken,
                      ),
                    ),
                    Text(
                      'This NFT has been successfully redeemed.'.tr,
                      textAlign: TextAlign.center,
                      style: SkillBuddyTypography.fromColor(
                        skillBuddyTheme.graphite,
                      ).kParagraph,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

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
                          ? '${solanaService.connectedAccountLabel.value} successfully connected'
                              .tr
                          : 'Begin the redemption process by connecting your Solana compatible wallet'
                              .tr,
                      textAlign: TextAlign.center,
                      style: SkillBuddyTypography.fromColor(
                        controller.isWalletConnected.value
                            ? skillBuddyTheme.green
                            : skillBuddyTheme.graphite,
                      ).kParagraph,
                    ),
                  ],
                ),
              ),
              const Gap(30),
              SkillBuddyButton(
                text: controller.isWalletConnected.value
                    ? 'Redeem now'.tr
                    : 'Connect wallet'.tr,
                onTap: controller.isWalletConnected.value
                    ? () => controller.redeemNFT(nftNumber)
                    : () => controller.authorizeWallet(),
              ),
              Obx(
                () => controller.isWalletConnected.value
                    ? TextButton(
                        onPressed: () async {
                          await controller.deauthorizeWallet();
                          Get.back<void>();
                        },
                        child: Text('Disconnect wallet'.tr),
                      )
                    : const Gap(10),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
