import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../service/api_service.dart';
import '../../../service/auth_service.dart';
import '../../../service/storage/storage_service.dart';
import '../../../service/user_state_service.dart';
import '../../home/home_page.dart';
import '../create_account_page.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService authService = Get.put(AuthService());
  final StorageService storageService =
      Get.put<StorageService>(StorageService());
  final RxString emailError = ''.obs;
  final RxString passwordError = ''.obs;
  final RxString usernameError = ''.obs;
  final RxString nonFieldError = ''.obs;
  final RxBool showPassword = false.obs;

  bool validateEmail() {
    emailError.value = '';
    // Regular expression for basic email format validation
    final RegExp emailRegex =
        RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');

    if (emailRegex.hasMatch(emailController.text)) {
      return true;
    }
    emailError.value = 'Enter a valid email address';
    return false;
  }

  void route() {
    Get.offAll<Widget>(() => const HomePage());
  }

  Future<void> login() async {
    if (validateEmail()) {
      final ApiResponse response = await authService.login(
        emailController.text,
        passwordController.text,
      );
      if (response.success) {
        await storageService.secure
            .write('token', response.result!['access_token']);
        await storageService.secure.write('email', emailController.text);
        final String username = Get.find<UserStateService>().user.value.name;
        await storageService.secure.write('username', username);
        route();
      } else {
        final Map<String, dynamic> error = response.result?['error'];

        if (error.containsKey('email')) {
          emailError.value = (error['email'] as List<dynamic>)[0];
        } else {
          emailError.value = '';
        }
        if (error.containsKey('password')) {
          passwordError.value = (error['password'] as List<dynamic>)[0];
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

  Future<void> goToSignUp() async {
    await Get.off<void>(
      () => const CreateAccountPage(),
    );
  }
}
