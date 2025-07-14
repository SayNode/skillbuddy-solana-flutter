import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../service/theme_service.dart';
import '../../theme/theme.dart';
import '../../theme/typography.dart';
import '../../widget/skillbuddy_scaffold.dart';
import 'solana_service.dart';
import 'solana_wallet_controller.dart';

class SolanaWalletPage extends GetView<SolanaWalletController> {
  const SolanaWalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SolanaWalletController());

    final SolanaService solanaService = Get.find<SolanaService>();
    final CustomTheme theme = Get.put(ThemeService()).theme;

    return SkillBuddyScaffold(
      title: 'Solana Wallet',
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Obx(
              () => Row(
                children: <Widget>[
                  Text(
                    'Network: ${solanaService.network.value == SolanaNetwork.mainnet ? 'Mainnet' : 'Testnet'}',
                    style: SkillBuddyTypography.fromColor(theme.graphite)
                        .kParagraphSemiBold20,
                  ),
                  Switch(
                    value: solanaService.network.value == SolanaNetwork.mainnet,
                    activeColor: Colors.red,
                    onChanged: (bool value) {
                      controller.toggleNetwork();
                    },
                  ),
                ],
              ),
            ),
            const Gap(25),
            Center(
              child: TextButton(
                onPressed: controller.authorizeWallet,
                style: TextButton.styleFrom(
                  backgroundColor: theme.electric,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
                child: Text(
                  'Authorize Wallet',
                  style: SkillBuddyTypography.fromColor(theme.graphite)
                      .kParagraphSemiBold20,
                ),
              ),
            ),
            const Gap(25),
            Obx(
              () {
                return Text(
                  'Public Key: ${solanaService.walletAddress}',
                  style: SkillBuddyTypography.fromColor(theme.graphite)
                      .kParagraphSemiBold20,
                );
              },
            ),
            const Gap(25),
            Obx(
              () {
                return Text(
                  'Connected account label: ${solanaService.connectedAccountLabel.value}',
                  style: SkillBuddyTypography.fromColor(theme.graphite)
                      .kParagraphSemiBold20,
                );
              },
            ),
            const Gap(25),
            Center(
              child: TextButton(
                onPressed: controller.deauthorizeWallet,
                style: TextButton.styleFrom(
                  backgroundColor: theme.electric,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
                child: Text(
                  'Deauthorize Wallet',
                  style: SkillBuddyTypography.fromColor(theme.graphite)
                      .kParagraphSemiBold20,
                ),
              ),
            ),
            const Gap(25),
            Center(
              child: TextButton(
                onPressed: solanaService.getBalanceSOL,
                style: TextButton.styleFrom(
                  backgroundColor: theme.electric,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
                child: Text(
                  'Get balance',
                  style: SkillBuddyTypography.fromColor(theme.graphite)
                      .kParagraphSemiBold20,
                ),
              ),
            ),
            Obx(
              () => Text(
                'Wallet balance: ${solanaService.walletBalance.value ?? 0.0} SOL',
                style: SkillBuddyTypography.fromColor(theme.graphite)
                    .kParagraphSemiBold20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
