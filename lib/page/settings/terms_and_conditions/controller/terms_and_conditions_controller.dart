import 'package:get/get.dart';

import '../../../../model/help_center_info.dart';

class TermsAndConditionsController extends GetxController {
  List<TextInfo> termsAndConditionsInfo = <TextInfo>[
    TextInfo(
      'Acceptance of terms',
      'By accessing or using our app, you agree to comply with and be bound by these Terms and Conditions.',
    ),
    TextInfo(
      'User responsibilities',
      '• Users must provide accurate and complete information during account creation.\n• Respect the rights and privacy of other users.\n• Prohibited activities include unauthorized access, data mining, and any form of harassment.',
    ),
    TextInfo(
      'Intellectual property',
      '• All content provided by the app is protected by copyright and intellectual property laws.\n• Users may not reproduce, distribute, or create derivative works without permission.',
    ),
    TextInfo(
      'Limitation of liability',
      'The app is provided "as is," and we are not liable for any damages or losses resulting from its use.',
    ),
    TextInfo(
      'Changes to terms',
      'We reserve the right to modify these terms at any time. Users will be notified of changes, and continued use implies acceptance.',
    ),
  ];
}
