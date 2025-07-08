import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../service/api_service.dart';
import '../../../service/auth_service.dart';
import '../../../service/storage/storage_service.dart';
import '../../home/home_page.dart';
import '../login_page.dart';

class SimpleLoginController extends GetxController {
  final AuthService authService = Get.find<AuthService>();
  final StorageService storageService = Get.find<StorageService>();

  final TextEditingController passwordController = TextEditingController();
  final RxString nonFieldError = ''.obs;
  final RxString passwordError = ''.obs;

  final RxBool showPassword = false.obs;

  Future<void> login() async {
    final String? email = await storageService.secure.readString('email');

    //This case should not happen, but it is here to prevent the app from crashing just in case
    if (email == null) {
      unawaited(Get.offAll<void>(() => const LoginPage()));
      return;
    }

    final ApiResponse response = await authService.login(
      email,
      passwordController.text,
    );
    if (response.success) {
      await storageService.secure
          .write('token', response.result!['access_token']);
      unawaited(Get.offAll<Widget>(() => const HomePage()));
    } else {
      final Map<String, dynamic> error = response.result?['error'];

      if (error.containsKey('password')) {
        passwordError.value = (error['password'] as List<dynamic>)[0];
      } else {
        passwordError.value = '';
      }
      if (error.containsKey('non_field_errors')) {
        nonFieldError.value = (error['non_field_errors'] as List<dynamic>)[0];
      } else if (error.containsKey('error')) {
        nonFieldError.value = error['error'].toString();
      } else {
        nonFieldError.value = '';
      }
    }
  }
}
