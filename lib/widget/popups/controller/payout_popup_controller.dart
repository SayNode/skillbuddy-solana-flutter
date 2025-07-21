import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../page/solana/solana_service.dart';
import '../../../page/token_list/token_list_controller.dart';
import '../../../service/api_service.dart';
import '../../../service/reward_claim_and_payout_services.dart';
import '../popup_manager.dart';

class PayoutPopupController extends GetxController {
  final RewardClaimAndPayoutService rewardClaimAndPayoutService =
      Get.find<RewardClaimAndPayoutService>();
  final TextEditingController lightningInvoiceController =
      TextEditingController();
  final SolanaService solanaService = Get.find<SolanaService>();
  final RxBool isWalletConnected = false.obs;
  final RxInt userPayoutAmount = 1.obs;
  final RxString payoutResponse = ''.obs;

  @override
  void onInit() {
    super.onInit();
    isWalletConnected.value = solanaService.authToken.isNotEmpty;
  }

  Future<void> authorizeWallet() async {
    PopupManager.openLoadingPopup();
    isWalletConnected.value = false;

    await solanaService.authorizeWallet();

    if (solanaService.authToken.isNotEmpty) {
      isWalletConnected.value = true;
    }

    Get.back<void>();
  }

  Future<void> deauthorizeWallet() async {
    PopupManager.openLoadingPopup();

    await solanaService.deauthorizeWallet();

    if (solanaService.authToken.isEmpty) {
      isWalletConnected.value = false;
    }

    Get.back<void>();
  }

  Future<void> sendBonkWithdrawalRequest() async {
    bool withdrawalSuccessful = false;
    PopupManager.openLoadingPopup();

    try {
      final ApiResponse response =
          await rewardClaimAndPayoutService.withdrawBonk(
        solanaService.walletAddress.value ?? '',
        userPayoutAmount.value,
      );

      if (response.success) {
        await Get.find<TokenListController>().refresh();
        Get.back<void>();
        withdrawalSuccessful = true;
      } else {
        await Get.find<TokenListController>().refresh();
        Get.back<void>();
        withdrawalSuccessful = false;
      }
    } catch (e) {
      await Get.find<TokenListController>().refresh();
      withdrawalSuccessful = false;

      // Handle any error that occurs during the API call
      Get
        ..back<void>() // Close the loading popup
        ..snackbar(
          'Error'.tr,
          'Withdrawal failed. Please try again. $e',
          duration: const Duration(seconds: 8),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
    }

    payoutResponse.value = withdrawalSuccessful
        ? 'Withdrawal successful'.tr
        : 'Withdrawal failed'.tr;
  }
}
