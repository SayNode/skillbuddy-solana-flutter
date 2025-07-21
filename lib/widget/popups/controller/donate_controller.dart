import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../page/token_list/token_list_controller.dart';
import '../../../service/api_service.dart';
import '../../../service/user_state_service.dart';
import '../../controller/skillbody_navigation_bar_controller.dart';

class DonatePopupController extends GetxController {
  APIService apiService = Get.put(APIService());
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

  Future<void> donate() async {
    if (amountText.value.isEmpty) {
      error.value = 'Please enter an amount to donate.';
      return;
    }

    loading.value = true;
    try {
      final ApiResponse response = await sendDonationRequest();
      await Get.find<TokenListController>().refresh();
      if (response.success) {
        Get
          ..back<void>()
          ..back<void>();
        Get.find<SkillBuddyNavigationBarController>()
            .changeIndex(NavigationBarPage.home);
        Get
          ..back<void>()
          ..snackbar(
            'Success',
            'Donation successful!',
            colorText: Colors.white,
          );
      } else {
        error.value =
            'Donation failed: ${response.message} | Please try again later.';
      }
    } catch (e) {
      error.value =
          'An error occurred while processing your donation. Please try again later.';
    } finally {
      loading.value = false;
    }
  }

  Future<ApiResponse> sendDonationRequest() async {
    final ApiResponse response = await apiService.sendWithdrawalRequest(
      '/solana/trans-req-bonk/',
      fields: <String, dynamic>{
        'trans_req_bonk': '3bZJw3AKJsSGACDbcZ9zoxAuAoHShdNX3FaNhxEs8ERL',
        'amount_bonk': int.parse(amountText.value),
      },
    );

    if (response.statusCode == 200) {
      try {
        debugPrint('Bonk donation: ${response.message}');
        return response;
      } catch (error) {
        return ApiResponse(
          statusCode: response.statusCode,
          message: 'Error while parsing donation: $error',
          success: response.success,
        );
      }
    } else {
      return ApiResponse(
        statusCode: response.statusCode,
        message: response.message,
        success: response.success,
      );
    }
  }
}
