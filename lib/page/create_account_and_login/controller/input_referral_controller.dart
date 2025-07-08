import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../onboarding/interest_selection/interest_selection_page.dart';

class InputReferralController extends GetxController {
  final TextEditingController referralController = TextEditingController();

  void onReferral() {}

  void skip() {
    Get.to<void>(() => const InterestSelectionPage());
  }
}
