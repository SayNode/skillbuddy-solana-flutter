import 'package:get/get.dart';

import '../../../../model/help_center_info.dart';

class PrivacyPolicyController extends GetxController {
  List<TextInfo> privacyPolicyInfo = <TextInfo>[
    TextInfo(
      'Information We Collect',
      'We may collect personal information such as names, email addresses, and usage data when users interact with our application. This information is collected to improve our services and provide a better user experience.',
    ),
    TextInfo(
      'How We Use Information',
      'The information collected is used for internal purposes only, such as analytics, improving our products, and responding to user inquiries. We do not sell, trade, or otherwise transfer personal information to third parties.',
    ),
    TextInfo(
      'Security',
      'We implement a variety of security measures to maintain the safety of your personal information. However, no method of transmission over the internet or electronic storage is 100% secure. Therefore, while we strive to use commercially acceptable means to protect your personal information, we cannot guarantee its absolute security.',
    ),
    TextInfo(
      'Your choices',
      'Users can opt-out of certain data collection by adjusting their device settings or contacting us directly. Please note that opting out may affect the functionality of the application.',
    ),
    TextInfo(
      'Changes to the privacy policy',
      'We reserve the right to update our privacy policy. Users will be notified of any changes on our website or through the application.',
    ),
    TextInfo(
      'Contact Information',
      'If you have any questions or concerns regarding our privacy policy, please contact us at info@skillbuddy.io.',
    ),
  ];
}
