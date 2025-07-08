import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/exception/content_fetch_exception.dart';
import '../../../service/reward_claim_and_payout_services.dart';
import '../../../service/user_state_service.dart';
import '../popup_manager.dart';

class DonatePopupController extends GetxController {
  final int userToken = Get.find<UserStateService>().user.value.token;
  RxString error = ''.obs;
  RxString amountText = ''.obs;
  TextEditingController amountController = TextEditingController();
  RxBool loading = false.obs;

  @override
  void onInit() {
    amountController.addListener(() {
      amountText.value = amountController.value.text;
    });
    super.onInit();
  }

  Future<void> confirmDonation(String charityAddress, int satsAmount) async {
    if (satsAmount == 0) {
      error.value = 'Please enter a valid amount'.tr;
      return;
    }
    error.value = '';
    if (int.parse(amountController.value.text) >
        Get.find<UserStateService>().user.value.token) {
      error.value = 'You do not have enough sats'.tr;
    } else {
      error.value = '';
      try {
        error.value = '';
        loading.value = true;
        await Get.find<RewardClaimAndPayoutService>()
            .donateSelectedCharity(charityAddress, satsAmount);
        await Get.find<UserStateService>().get();
        Get.back<void>();
        PopupManager.donatePayoutSuccessPopup();
      } on ContentFetchException catch (e) {
        error.value = e.message;
        Get
          ..snackbar('Error', e.message)
          ..back<void>();
      } catch (e) {
        error.value = e.toString();
        Get
          ..snackbar('Error', e.toString())
          ..back<void>();
      }
    }
  }
}
