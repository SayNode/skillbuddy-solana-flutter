import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../model/user_model.dart';
import '../../../service/auth_service.dart';
import '../../../service/logger_service.dart';
import '../../../service/messaging_service.dart';
import '../../../service/storage/storage_service.dart';
import '../../../service/theme_service.dart';
import '../../../service/user_state_service.dart';
import '../../../theme/theme.dart';
import '../../../theme/typography.dart';
import '../../create_account_and_login/login_page.dart';
import '../../loading/loading_page.dart';

class SettingsController extends GetxController with WidgetsBindingObserver {
  final CustomTheme skillBuddyTheme = ThemeService().theme;
  final AuthService authService = Get.put(AuthService());
  final StorageService storageService =
      Get.put<StorageService>(StorageService());
  final LocalAuthentication auth = LocalAuthentication();
  RxBool isBiometricEnabled = false.obs;
  RxBool isNotificationsEnabled = false.obs;
  RxBool socialLogin = false.obs;
  final User user = Get.find<UserStateService>().user.value;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  Rx<PackageInfo> packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  ).obs;

  Future<void> _initPackageInfo() async {
    packageInfo.value = await PackageInfo.fromPlatform();
  }

  void toggleBiometric({bool? value}) {
    isBiometricEnabled.value = value ?? false;
    storageService.shared.writeBool('biometrics', value ?? false);
  }

  Widget infoTile(String title, String subtitle) {
    return ListTile(
      title: Text(
        title,
        style: SkillBuddyTypography.fromColor(
          skillBuddyTheme.graphite,
        ).kParagraphSemiBold,
      ),
      subtitle: Text(
        subtitle.isEmpty ? 'Not set' : subtitle,
        style: SkillBuddyTypography.fromColor(
          skillBuddyTheme.graphite,
        ).kTextAdditional,
      ),
    );
  }

  String get buildVersion =>
      '${packageInfo.value.version}+${packageInfo.value.buildNumber}';

  @override
  void onInit() {
    WidgetsBinding.instance.addObserver(this);
    _checkNotificationStatus();
    _initPackageInfo();
    super.onInit();
    isBiometricEnabled.value =
        storageService.shared.readBool('biometrics') ?? false;
    if (!user.isVerified) {
      Get.find<UserStateService>().get();
    }
    socialLogin.value = storageService.shared.readBool('socialLogin') ?? false;
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkNotificationStatus(); // Recheck when returning from settings
    }
  }

  Future<void> _checkNotificationStatus() async {
    final bool granted = await Permission.notification.status.isGranted;
    isNotificationsEnabled.value = granted;
    // Check if the token is already present.
    final String existingToken =
        Get.find<UserStateService>().user.value.firebasePushNotificationToken;
    if (granted && (existingToken.isEmpty)) {
      await Get.find<MessagingService>().init();
    }
  }

  Future<void> toggleNotifications(bool value) async {
    if (value) {
      // User wants to enable notifications
      _showNotificationsDialog(
        title: 'Enable Notifications'.tr,
        message:
            'To receive notifications, please enable them in your device settings.'
                .tr,
      );
    } else {
      // User wants to disable notifications
      _showNotificationsDialog(
        title: 'Disable Notifications'.tr,
        message:
            'To turn off notifications, please disable them in your device settings.'
                .tr,
      );
    }
  }

  void _showNotificationsDialog({
    required String title,
    required String message,
  }) {
    Get.dialog<void>(
      AlertDialog(
        title: Text(title.tr),
        content: Text(message.tr),
        actions: <Widget>[
          TextButton(
            onPressed: () => Get.back<void>(),
            child: Text('Cancel'.tr),
          ),
          TextButton(
            onPressed: () {
              Get.back<void>();
              openAppSettings();
            },
            child: Text('Settings'.tr),
          ),
        ],
      ),
    );
  }

  // ignore: avoid_positional_boolean_parameters
  Future<void> toggleBiometricLogin(bool value) async {
    if (value) {
      final bool canCheckBiometrics = await auth.canCheckBiometrics;
      final bool isBiometricSupported = await auth.isDeviceSupported();
      final List<BiometricType> availableBiometrics =
          await auth.getAvailableBiometrics();

      if (canCheckBiometrics &&
          isBiometricSupported &&
          availableBiometrics.isNotEmpty) {
        try {
          final bool didAuthenticate = await auth.authenticate(
            localizedReason: 'Please authenticate to login',
            options: const AuthenticationOptions(
              stickyAuth: true,
              biometricOnly: true,
            ),
          );
          if (didAuthenticate) {
            await storageService.shared.writeBool('biometrics', value);
            isBiometricEnabled.value = value;
          } else {
            await storageService.shared.writeBool('biometrics', false);
            isBiometricEnabled.value = false;
          }
        } on PlatformException catch (e) {
          LoggerService().log(e as String?);
          await storageService.shared.writeBool('biometrics', false);
          isBiometricEnabled.value = false;
        }
      } else {
        _showSettingsDialog();
        isBiometricEnabled.value = false;
      }
    } else {
      await storageService.shared.writeBool('biometrics', false);
      isBiometricEnabled.value = false;
    }
  }

  void _showSettingsDialog() {
    Get.dialog<void>(
      AlertDialog(
        title: Text('Permission Required'.tr),
        content: Text(
          'Biometric permission is required. Please enable it in the device settings.'
              .tr,
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => <void>{
              Get.back<void>(),
            },
            child: Text('Cancel'.tr),
          ),
          TextButton(
            onPressed: () {
              Get.back<void>();
              openAppSettings();
            },
            child: Text('Settings'.tr),
          ),
        ],
      ),
    );
  }

  Future<void> openAppSettings() async {
    String url = '';
    if (Platform.isAndroid) {
      const MethodChannel platform = MethodChannel('flutter_app_settings');
      try {
        await platform.invokeListMethod<void>('openAppSettings');
      } on PlatformException catch (e) {
        debugPrint('Error: ${e.message}');
      }
      url = 'package:com.android.settings';
    } else if (Platform.isIOS) {
      url = 'app-settings:';
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        LoggerService().log('Could not launch $url');
      }
    }
  }

  Future<void> logout() async {
    await Get.off<void>(
      () => LoadingPage(
        title: 'Logging out...'.tr,
        job: () async {
          await storageService.secure.delete('email');
          await storageService.secure.delete('username');
          await storageService.shared.delete('socialLogin');
          await authService.logout();

          await Get.offAll<void>(() => const LoginPage());
        },
      ),
    );
  }

  Future<void> verifyUser() async {
    await Get.find<UserStateService>().verification();
  }
}
