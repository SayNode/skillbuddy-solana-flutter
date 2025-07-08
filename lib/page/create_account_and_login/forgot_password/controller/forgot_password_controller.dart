// ignore_for_file: inference_failure_on_function_invocation

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../service/api_service.dart';
import '../../../../service/auth_service.dart';
import '../../../../widget/password_updated_page.dart';
import '../../reset_password/reset_password_email.dart';
import '../enter_new_password_page.dart';
import '../password_reset_code_page.dart';

class ForgotPasswordController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final AuthService authService = Get.find<AuthService>();
  RxBool matches = true.obs;
  RxBool hasError = false.obs;
  RxString createPasswordError = ''.obs;
  RxString unknownEmailError = ''.obs;
  RxBool emailIsSent = false.obs;
  RxBool codeIsInValid = false.obs;

  final RxBool isValid = false.obs;
  final RxBool showPassword = false.obs;

  String? validator(String? text) {
    isValid.value = text!.isEmail;
    return isValid.value ? null : 'Please enter correct email'.tr;
  }

  Future<void> onSubmit() async {
    emailIsSent.value = false;

    unawaited(
      Get.to<Widget>(
        () => ResetPasswordPage(
          email: emailController.text,
          onTap: () => Get.to<void>(const PasswordResetCodePage()),
        ),
      ),
    );

    final ApiResponse authResponse =
        await authService.resetPassword(emailController.text);
    emailIsSent.value = authResponse.success;

    if (emailIsSent.value == true) {
      unknownEmailError.value = '';
      Future<void>.delayed(const Duration(milliseconds: 2000), () {
        Get.to<void>(const PasswordResetCodePage());
      });
    } else {
      // ignore: always_specify_types
      if (authResponse.result!.isNotEmpty) {
        // ignore: always_specify_types
        authResponse.result?.forEach((String key, value) {
          // ignore: avoid_dynamic_calls
          final Map<String, dynamic> result = value as Map<String, dynamic>;
          // ignore: cascade_invocations, always_specify_types
          result.forEach((String key, value) {
            // ignore: avoid_dynamic_calls
            unknownEmailError.value = value[0] as String;
          });
        });
      } else {
        unknownEmailError.value =
            'Error occurred. This is usually due to the email not being registered or the account was a apple or google login'
                .tr;
      }
    }
  }

  Future<void> validateCode(String recoveryCode) async {
    codeIsInValid.value = !(await authService.verifyCode(recoveryCode)).success;

    if (!codeIsInValid.value) {
      unawaited(Get.to<void>(const EnterNewPasswordPage()));
    }
  }

  void updateMatch() {
    if (newPasswordController.text.compareTo(confirmPasswordController.text) ==
            0 &&
        confirmPasswordController.text.isNotEmpty) {
      matches.value = true;
      createPasswordError.value = '';
    } else if (matches.value == true) {
      createPasswordError.value = 'Passwords do not match'.tr;
      matches.value = false;
    }
  }

  Future<void> onPasswordChangeSubmit() async {
    createPasswordError.value = '';

    final ApiResponse result = await authService.changePasswordAfterReset(
      newPasswordController.text,
      confirmPasswordController.text,
    );

    if (result.success) {
      unawaited(Get.offAll<void>(const PasswordUpdatedPage()));
    } else {
      // ignore: always_specify_types
      result.result?.forEach((String key, value) {
        createPasswordError.value = (value as List<dynamic>)[0];
      });
    }
  }
}
