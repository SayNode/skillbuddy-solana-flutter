import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../service/theme_service.dart';
import '../../../theme/theme.dart';
import '../../../theme/typography.dart';
import '../../../widget/skillbuddy_scaffold.dart';
import '../referral_page/widgets/referral_card.dart';
import 'controller/wallet_controller.dart';

class WalletAddressBook extends GetView<WalletController> {
  const WalletAddressBook({super.key});

  @override
  Widget build(BuildContext context) {
    final WalletController controller = Get.put(WalletController());
    final CustomTheme skillBuddyTheme = ThemeService()
        .theme; // Update this line with your theme service instantiation

    return SkillBuddyScaffold(
      title: 'Wallet address book'.tr,
      body: Column(
        children: <Widget>[
          const Gap(15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '803dC6f02feCeF1Cf5B14...',
                style: SkillBuddyTypography.fromColor(
                  skillBuddyTheme.graphite,
                ).kParagraph,
              ),
              const Gap(40),
              ReferralCard(
                title: 'Copy'.tr,
                icon: 'asset/icons/copy_icon1.svg',
                onTap: controller.copyToClipboard,
                iconWidth: 12,
                gapSize: 5,
                smallText: true,
                width: 60,
                height: 25,
                radius: 7,
              ),
              const Gap(12),
              ReferralCard(
                title: 'Share'.tr,
                icon: 'asset/icons/share_icon2.svg',
                onTap: () => controller.shareWalletAddress(
                  'https://play.google.com/store/apps/details?id=io.wizzer.academy',
                ),
                iconWidth: 12,
                gapSize: 5,
                smallText: true,
                width: 60,
                height: 25,
                radius: 7,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
