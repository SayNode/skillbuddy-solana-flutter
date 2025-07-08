// ignore_for_file: inference_failure_on_function_return_type

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../service/api_service.dart';
import '../../../../service/auth_service.dart';
import '../../../../widget/password_updated_page.dart';

class ChangePasswordController extends GetxController {
  final AuthService authService = Get.find<AuthService>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPassword = TextEditingController();
  RxBool isValid = false.obs;
  final Rx<GlobalKey<FormState>> changePasswordFormKey =
      GlobalKey<FormState>().obs;
  RxBool hidePassword = true.obs;
  RxBool matches = true.obs;
  RxBool invalidPassword = false.obs;
  RxBool isUnlock = false.obs;
  RxString errorMessage = ''.obs;

  Future<void> onPasswordChangeSubmit() async {
    final ApiResponse authResponse = await authService.changePassword(
      passwordController.text,
      newPasswordController.text,
      confirmNewPassword.text,
    );

    if (authResponse.success) {
      unawaited(Get.to<void>(const PasswordUpdatedPage()));
    } else {
      // Safely access the nested error structure
      final Map<String, dynamic>? error =
          authResponse.result?['error'] as Map<String, dynamic>?;
      if (error != null && error.containsKey('old_password')) {
        // Access the list inside the 'old_password' key
        final List<dynamic> oldPasswordErrors =
            error['old_password'] as List<dynamic>;
        if (oldPasswordErrors.isNotEmpty) {
          errorMessage.value = oldPasswordErrors[0]
              as String; // Safely extract the error message
        }
      } else {
        errorMessage.value =
            authResponse.message ?? 'An unknown error occurred';
      }
    }
  }

  void setShowPassword() {
    hidePassword.value = !hidePassword.value;
  }

  void updateMatch() {
    if (newPasswordController.value.text
            .compareTo(confirmNewPassword.value.text) ==
        0) {
      matches.value = true;
    } else if (matches.value == true) {
      matches.value = false;
    }
    unlockButton();
  }

  void passwordStrength() {
    if (newPasswordController.value.text.length <= 5) {
      invalidPassword.value = true;
    } else {
      invalidPassword.value = false;
    }
    unlockButton();
  }

  void validate(String value) {
    if (passwordController.value.text.isNotEmpty &&
        newPasswordController.value.text.isNotEmpty &&
        confirmNewPassword.value.text.isNotEmpty) {
      isValid.value = true;
    } else {
      isValid.value = false;
    }
    unlockButton();
  }

  void unlockButton() {
    if (isValid.value =
        // ignore: unrelated_type_equality_checks
        true && matches.value == true && invalidPassword == false) {
      isUnlock.value = true;
    } else {
      isUnlock.value = false;
    }
  }
}
