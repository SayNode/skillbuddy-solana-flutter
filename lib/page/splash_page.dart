import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../service/auth_service.dart';
import '../service/storage/storage_service.dart';
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
        final StorageService storage = Get.find<StorageService>();
        final String? exsitingEmail = await storage.secure.readString('email');
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

        if (biometricEnabled) {
          // biometric enabled
          final bool biometricSuccess =
              await Get.find<AuthService>().biometricLogin();
          if (biometricSuccess) {
            // biometric login success
            final bool silentLoginSuccess =
                (await Get.find<AuthService>().silentLogin()).success;
            if (!silentLoginSuccess) {
              // silent login failed
              if (exsitingEmail != '' && exsitingEmail != null) {
                // has user data in storage
                final String username =
                    await storage.secure.readString('username') ?? '';
                await Get.off<void>(() => SimpleLoginPage(username: username));
              } else {
                await Get.off<void>(() => const LoginPage());
              }
            } else {
              await Get.off<void>(() => const HomePage());
            }
          } else {
            // biometric login failed
            if (exsitingEmail != '' && exsitingEmail != null) {
              // has user data in storage
              final String username =
                  await storage.secure.readString('username') ?? '';
              await Get.off<void>(() => SimpleLoginPage(username: username));
            } else {
              await Get.off<void>(() => const LoginPage());
            }
          }
        } else {
          // biometric disabled
          final bool silentLoginSuccess =
              (await Get.find<AuthService>().silentLogin()).success;
          if (!silentLoginSuccess) {
            // silent login failed
            if (exsitingEmail != '' && exsitingEmail != null) {
              // has user data in storage
              final String username =
                  await storage.secure.readString('username') ?? '';
              await Get.off<void>(() => SimpleLoginPage(username: username));
            } else {
              await Get.off<void>(() => const LoginPage());
            }
          } else {
            await Get.off<void>(() => const HomePage());
          }
        }
      },
    );
  }
}
