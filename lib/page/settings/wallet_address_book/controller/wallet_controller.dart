import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as path;
import 'package:share_plus/share_plus.dart';

import '../../../../service/theme_service.dart';
import '../../../../theme/theme.dart';

class WalletController extends GetxController {
  final CustomTheme skillBuddyTheme = ThemeService().theme;

  void copyToClipboard() {
    ///TODO: Replace with actual wallet address
    Clipboard.setData(const ClipboardData(text: '803dC6f02feCeF1Cf5B14...'));
    Get.snackbar(
      'Copied'.tr,
      'Referral code copied to clipboard'.tr,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: skillBuddyTheme.seashell,
      colorText: skillBuddyTheme.graphite,
    );
  }

  Future<void> shareWalletAddress(String url) async {
    final String code = path.basename(url);
    await logEvent(code);

    await Share.share(
      ///TODO: Replace with actual wallet address and test on real devices
      '''
      Here is my wallet address!
      $url 
      send me money!
      Play Store: https://play.google.com/store/apps/details?id=io.wizzer.academy 
      App Store: https://apps.apple.com/ch/app/yzer-learn-bitcoin-finance/id6443545393
      ''',
    );
  }

  Future<void> logEvent(String walletAddress) async {
    await FirebaseAnalytics.instance.logEvent(
      name: 'share_wallet',
      parameters: <String, Object>{
        'content_type': 'wallet',
        'code': walletAddress,
      },
    );
  }
}
