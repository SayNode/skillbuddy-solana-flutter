import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../page/profile/controller/profile_controller.dart';
import '../../../page/solana/solana_service.dart';

import '../../../service/reward_claim_and_payout_services.dart';
import '../../../service/user_state_service.dart';
import '../popup_manager.dart';

class RedeemNFTPopupController extends GetxController {
  final RewardClaimAndPayoutService rewardClaimAndPayoutService =
      Get.find<RewardClaimAndPayoutService>();

  final SolanaService solanaService = Get.find<SolanaService>();
  final RxBool isWalletConnected = false.obs;
  final RxString walletAddress = ''.obs;

  @override
  void onInit() {
    super.onInit();
    isWalletConnected.value = solanaService.authToken.isNotEmpty;
    walletAddress.value = solanaService.walletAddress.value ?? '';
  }

  Future<void> authorizeWallet() async {
    PopupManager.openLoadingPopup();
    isWalletConnected.value = false;

    await solanaService.authorizeWallet();

    if (solanaService.authToken.isNotEmpty &&
        solanaService.walletAddress.value != null) {
      isWalletConnected.value = true;
    }
    Get.back<void>();
  }

  Future<void> deauthorizeWallet() async {
    PopupManager.openLoadingPopup(title: 'Disconnecting wallet');

    await solanaService.deauthorizeWallet();

    if (solanaService.authToken.isEmpty) {
      isWalletConnected.value = false;
    }

    Get.back<void>();
  }

  Future<void> redeemNFT(int nftNumber) async {
    PopupManager.openLoadingPopup(title: 'Redeeming NFT');

    try {
      final bool success = await rewardClaimAndPayoutService.redeemNFT(
        solanaService.walletAddress.value!,
        nftNumber,
      );
      Get.back<void>();
      if (success) {
        await Get.find<UserStateService>().get();
        Get.find<ProfileController>().updateNFTStatus();
        Get
          ..snackbar(
            'NFT Redeemed',
            'Your NFT has been successfully redeemed.',
            colorText: Colors.green,
          )
          ..back<void>()
          ..back<void>();
        // PopupManager.openSuccessPopup();
      } else {
        Get
          ..back<void>()
          ..snackbar(
            'Redemption failed'.tr,
            'Please try again later'.tr,
            colorText: Colors.redAccent,
          );
      }
    } catch (e) {
      Get
        ..snackbar(
          'Redemption failed'.tr,
          e.toString(),
          colorText: Colors.redAccent,
        )
        ..back<void>();
    }
  }
}
