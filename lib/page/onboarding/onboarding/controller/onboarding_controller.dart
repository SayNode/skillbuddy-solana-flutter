import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../service/storage/storage_service.dart';
import '../../../create_account_and_login/create_account_page.dart';

class OnboardingController extends GetxController {
  final RxInt currentPage = 0.obs;
  final PageController pageViewController = PageController();
  final List<String> onboardingPageTitles = <String>[
    'earn while you learn'.tr,
    'unlock your potential'.tr,
    'learn with ease'.tr,
  ];
  final List<String> onboardingPageDescriptions = <String>[
    'Complete courses, earn. Yes, you heard it right! The more you learn, the more you earn. Welcome to a future where education pays off.'
        .tr,
    'Dive into a world of tech mastery and blockchain brilliance with SkillBuddy. Learn, earn, and level up your skills.'
        .tr,
    'Dive into our user-friendly platform for a seamless tech education experience.'
        .tr,
  ];
  final List<String> riveAnimations = <String>[
    'asset/animations/first_intro_crane.riv',
    'asset/animations/Speaking_Crane.riv',
    'asset/animations/sun_clouds_crane.riv',
  ];
  void skip() {
    Get.find<StorageService>().shared.writeBool('onboarding_complete', true);
    Get.to<void>(() => const CreateAccountPage());
  }

  void animateTo(int index) {
    currentPage.value = index;
    pageViewController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void jumpTo(int index) {
    currentPage.value = index;
    pageViewController.jumpToPage(index);
  }

  void proceed() {
    if (currentPage.value < onboardingPageTitles.length - 1) {
      animateTo(currentPage.value + 1);
    } else {
      Get.find<StorageService>().shared.writeBool('onboarding_complete', true);
      Get.to<void>(() => const CreateAccountPage());
    }
  }
}
