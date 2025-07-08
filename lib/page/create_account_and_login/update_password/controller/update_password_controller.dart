// ignore_for_file: inference_failure_on_function_invocation

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../login_page.dart';
import '../../reset_password/reset_password_email.dart';

class UpdatePasswordController extends GetxController {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPassword = TextEditingController();
  RxBool matches = true.obs;
  RxBool isUnlock = false.obs;

  void updateMatch() {
    if (newPasswordController.text.compareTo(confirmNewPassword.text) == 0) {
      matches.value = true;
    } else if (matches.value == true) {
      matches.value = false;
    }
    unlockButton();
  }

  void unlockButton() {
    if (matches.value == true) {
      isUnlock.value = true;
    } else {
      isUnlock.value = false;
    }
  }

  void onSubmit() {
    if (isUnlock.value = true) {
      Get.to(
        () => ResetPasswordPage(
          onTap: () => Get.to(const LoginPage()),
        ),
      );
    }
  }
}
