import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/user_model.dart';
import '../../../service/api_service.dart';
import '../../../service/auth_service.dart';
import '../../../service/storage/storage_service.dart';
import '../../../service/theme_service.dart';
import '../../../service/user_state_service.dart';
import '../../../theme/theme.dart';
import '../../home/home_page.dart';
import '../../onboarding/interest_selection/interest_selection_page.dart';
import '../login_page.dart';

class CreateAccountController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final RxBool isChecked = false.obs;
  RxString emailError = ''.obs;
  RxString passwordError = ''.obs;
  RxString usernameError = ''.obs;
  RxString nonFieldError = ''.obs;
  final Uri termsUrl = Uri.parse('https://www.skillbuddy.io/privacypolicy');
  final Uri privacyUrl = Uri.parse('https://www.skillbuddy.io/privacypolicy');
  final CustomTheme skillBuddyTheme = ThemeService().theme;
  final AuthService authService = Get.put(AuthService());
  final RxBool showPassword = false.obs;

  bool validateEmail() {
    emailError.value = '';
    // Regular expression for basic email format validation
    final RegExp emailRegex =
        RegExp(r'^[\w\-\+]+(\.[\w\-\+]+)*@([\w-]+\.)+[a-zA-Z]{2,15}$');

    if (!emailRegex.hasMatch(emailController.text)) {
      emailError.value = 'Please enter a valid email address';
      return false;
    }
    return true; // Return an empty string if the email is valid
  }

  bool validatePassword() {
    // Regular expressions for password validation
    final RegExp uppercaseRegex = RegExp('[A-Z]');
    final RegExp lowercaseRegex = RegExp('[a-z]');
    final RegExp digitRegex = RegExp('[0-9]');

    // Check for password length
    if (passwordController.text.length < 8) {
      passwordError.value = 'Password must be at least 8 characters';
      return false;
    }
    // Check for at least one uppercase letter, one lowercase letter, and one number
    else if (!uppercaseRegex.hasMatch(passwordController.text) ||
        !lowercaseRegex.hasMatch(passwordController.text) ||
        !digitRegex.hasMatch(passwordController.text)) {
      passwordError.value =
          'Password must include at least one uppercase letter, one lowercase letter, and one number';
      return false;
    }
    // Password is valid
    else {
      passwordError.value = '';
      return true;
    }
  }

  Future<void> register() async {
    if (validateEmail() && validatePassword()) {
      final ApiResponse response = await authService.registration(
        emailController.text,
        passwordController.text,
        nameController.text,
        biometrics: false,
      );
      if (response.success) {
        final User user = Get.find<UserStateService>().user.value;
        // store username and email
        final StorageService storageService = Get.find<StorageService>();
        await storageService.secure.write('email', user.email);
        await storageService.secure.write('username', user.name);

        if (user.areasOfInterest.isEmpty) {
          unawaited(Get.offAll<Widget>(() => const InterestSelectionPage()));
        } else {
          unawaited(Get.offAll<Widget>(() => const HomePage()));
        }
      } else {
        final Map<String, dynamic> error = response.result?['error'];
        if (error.containsKey('email')) {
          emailError.value = (error['email'] as List<dynamic>)[0];
        } else {
          emailError.value = '';
        }
        if (error.containsKey('password1')) {
          passwordError.value = (error['password1'] as List<dynamic>)[0];
        } else {
          passwordError.value = '';
        }
        if (error.containsKey('username')) {
          usernameError.value = (error['username'] as List<dynamic>)[0];
        } else {
          usernameError.value = '';
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

  Future<void> goToSignIn() async {
    await Get.off<void>(
      () => const LoginPage(),
    );
  }
}
