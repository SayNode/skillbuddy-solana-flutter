import 'package:get/get.dart';

import '../../../../model/help_center_info.dart';

class HelpCenterController extends GetxController {
  List<TextInfo> helpCenterInfo = <TextInfo>[
    TextInfo(
      'I earned rewards—what now?',
      'Great job! Go to the “Wallet” section to redeem them. You can use Bitcoin Lightning to send rewards to a wallet of your choice. Alternatively, you can donate them to an NGO and support a good cause.',
    ),
    TextInfo(
      'I don’t have a wallet—what now?',
      'No problem! You can set up any Bitcoin Lightning wallet to receive your rewards.',
    ),
    TextInfo(
      'How can I invite friends to SkillBuddy.io?',
      'Use the share function within the app to invite your friends.',
    ),
    TextInfo(
      'How do I report an issue or give feedback?',
      'Go to the “Help Center” section in the app’s settings to contact our support team or submit feedback.',
    ),
    TextInfo(
      'Can I delete my account?',
      'Yes, you can delete your account from the settings menu. This action is permanent.',
    ),
  ];
}
