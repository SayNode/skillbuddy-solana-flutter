import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as path;
import 'package:share_plus/share_plus.dart';

import '../../../../service/theme_service.dart';
import '../../../../theme/theme.dart';

class ReferralPageController extends GetxController {
  final CustomTheme skillBuddyTheme = ThemeService().theme;
  final RxBool showReferralsSent = false.obs;

  void copyToClipboard() {
    ///TODO: Replace with actual referral code
    Clipboard.setData(const ClipboardData(text: 'FAKE4745'));
    Get.snackbar(
      'Copied'.tr,
      'Referral code copied to clipboard'.tr,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: skillBuddyTheme.seashell,
      colorText: skillBuddyTheme.graphite,
    );
  }

  Future<void> shareReferralCode(String url) async {
    final String code = path.basename(url);
    await logEvent(code);

    await Share.share(
      ///TODO: Replace with actual referral code and test on real devices
      '''
      Use my referral code for more xp!
      $url 
      Download SkillBuddy now!
      Play Store: https://play.google.com/store/apps/details?id=io.wizzer.academy 
      App Store: https://apps.apple.com/ch/app/yzer-learn-bitcoin-finance/id6443545393
      ''',
    );
  }

  Future<void> logEvent(String code) async {
    await FirebaseAnalytics.instance.logEvent(
      name: 'share_code',
      parameters: <String, Object>{
        'content_type': 'code',
        'code': code,
      },
    );
  }
}
