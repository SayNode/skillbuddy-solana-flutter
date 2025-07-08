import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../page/token_list/token_list_controller.dart';
import '../../../service/api_service.dart';
import '../../../service/reward_claim_and_payout_services.dart';
import '../popup_manager.dart';

class PayoutPopupController extends GetxController {
  final RewardClaimAndPayoutService rewardClaimAndPayoutService =
      Get.find<RewardClaimAndPayoutService>();
  final TextEditingController lightningInvoiceController =
      TextEditingController();

  RxBool isInvoiceValid = false.obs;
  void updateText() {
    final String text = lightningInvoiceController.value.text;

    if (text.isNotEmpty) {
      isInvoiceValid.value = true;
    } else {
      isInvoiceValid.value = false;
    }
  }

  Future<void> getPayoutMessage() async {
    Get.back<void>();
    PopupManager.openLoadingPopup();

    try {
      final ApiResponse response =
          await rewardClaimAndPayoutService.getPayoutMessage(
        lightningInvoiceController.value.text,
      );

      if (response.success == true) {
        await Get.find<TokenListController>().refresh();

        Get.back<void>();
        PopupManager.openSuccessPopup();
      } else {
        Get
          ..back<void>()
          ..snackbar(
            'Error'.tr,
            '${response.message}',
            duration: const Duration(seconds: 8),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
      }
    } catch (e) {
      await Get.find<TokenListController>().refresh();
      // Handle any error that occurs during the API call
      Get
        ..back<void>() // Close the loading popup
        ..snackbar(
          'Error'.tr,
          'Failed to retrieve payout message. Please try again.$e',
          duration: const Duration(seconds: 8),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
    }
  }
}
