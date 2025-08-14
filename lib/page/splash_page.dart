import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../service/api_service.dart';
import '../service/auth_service.dart';
import '../service/storage/storage_service.dart';
import '../service/user_state_service.dart';
import 'create_account_and_login/login_page.dart';
import 'create_account_and_login/login_simplified.dart';
import 'home/home_page.dart';
import 'loading/loading_page.dart';
import 'onboarding/onboarding/onboarding_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LoadingPage(
      title: 'Trying to log you in...',
      job: () async {
        try {
          final StorageService storage = Get.find<StorageService>();
          final String? exsitingEmail =
              await storage.secure.readString('email');
          final bool biometricEnabled =
              storage.shared.readBool('biometrics') ?? false;
          final bool onboardingComplete =
              storage.shared.readBool('onboarding_complete') ?? false;

          final String token = await storage.secure.readString('token') ?? '';

          if (!onboardingComplete) {
            await Get.off<void>(() => const OnboardingPage());
            return;
          }

          if (token == '') {
            await Get.off<void>(() => const LoginPage());
            return;
          }

          Future<void> navigateAfterLogin(
            StorageService storage,
            String? exsitingEmail,
          ) async {
            if (exsitingEmail != null && exsitingEmail.isNotEmpty) {
              final String username =
                  await storage.secure.readString('username') ?? '';
              await Get.off<void>(() => SimpleLoginPage(username: username));
            } else {
              await Get.off<void>(() => const LoginPage());
            }
          }

          Future<void> handleLogin(
            StorageService storage,
            String? exsitingEmail,
            bool biometricEnabled,
          ) async {
            if (biometricEnabled) {
              final bool biometricSuccess =
                  await Get.find<AuthService>().biometricLogin();
              if (!biometricSuccess) {
                await navigateAfterLogin(storage, exsitingEmail);
                return;
              }
            }
            final ApiResponse response =
                await Get.find<UserStateService>().get();
            if (response.success) {
              await Get.off<void>(() => const HomePage());
            } else {
              await navigateAfterLogin(storage, exsitingEmail);
            }
          }

          await handleLogin(storage, exsitingEmail, biometricEnabled);
        } catch (error) {
          Get.log('Error in SplashPage: $error');
        }
      },
    );
  }
}
