import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../service/api_service.dart';
import '../../../service/auth_service.dart';
import '../../home/home_page.dart';
import '../../onboarding/interest_selection/interest_selection_page.dart';

class AppleGoogleController extends GetxController {
  RxString error = ''.obs;

  final AuthService authService = Get.put(AuthService());

  Future<void> googleSignInPressed() async {
    final ApiResponse response = await authService.googleSignIn();
    if (response.success) {
      if (response.result!['is_signup']) {
        unawaited(Get.offAll<Widget>(() => const InterestSelectionPage()));
      } else {
        unawaited(Get.offAll<Widget>(() => const HomePage()));
      }
    } else {
      final Map<String, dynamic> errorResponse = response.result?['error'];

      if (errorResponse.containsKey('email')) {
        error.value = (errorResponse['email'] as List<dynamic>)[0];
      } else {
        error.value = '';
      }
      if (errorResponse.containsKey('password')) {
        error.value = (errorResponse['password'] as List<dynamic>)[0];
      } else {
        error.value = '';
      }
      if (errorResponse.containsKey('username')) {
        error.value = (errorResponse['username'] as List<dynamic>)[0];
      } else {
        error.value = '';
      }
      if (errorResponse.containsKey('non_field_errors')) {
        error.value = (errorResponse['non_field_errors'] as List<dynamic>)[0];
      } else if (errorResponse.containsKey('error')) {
        error.value = errorResponse['error'].toString();
      } else {
        error.value = '';
      }
      Get.back<void>();
    }
  }

  Future<void> appleSignInPressed() async {
    final ApiResponse response = await authService.appleSignIn();
    if (response.success) {
      if (response.result!['is_signup']) {
        unawaited(Get.offAll<Widget>(() => const InterestSelectionPage()));
      } else {
        unawaited(Get.offAll<Widget>(() => const HomePage()));
      }
    } else if (response.message!
        .contains('The operation couldn’t be completed')) {
      // When user cancels the sign-in process
      return;
    } else {
      // Handle other errors
      final Map<String, dynamic> errorResponse = response.result?['error'];
      if (errorResponse.containsKey('email')) {
        error.value = (errorResponse['email'] as List<dynamic>)[0];
      } else {
        error.value = '';
      }
      if (errorResponse.containsKey('password')) {
        error.value = (errorResponse['password'] as List<dynamic>)[0];
      } else {
        error.value = '';
      }
      if (errorResponse.containsKey('username')) {
        error.value = (errorResponse['username'] as List<dynamic>)[0];
      } else {
        error.value = '';
      }
      if (errorResponse.containsKey('non_field_errors')) {
        error.value = (errorResponse['non_field_errors'] as List<dynamic>)[0];
      } else if (errorResponse.containsKey('error')) {
        error.value = errorResponse['error'].toString();
      } else {
        error.value = '';
      }
    }
  }
}
