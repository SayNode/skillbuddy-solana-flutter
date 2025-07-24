import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../service/theme_service.dart';
import '../../service/user_state_service.dart';
import '../../theme/theme.dart';
import '../../theme/typography.dart';
import '../../util/constants.dart';
import '../../util/util.dart';
import '../../widget/popups/popup_manager.dart';
import '../../widget/skillbuddy_scaffold.dart';
import 'change_password/change_password_page.dart';
import 'controller/settings_controller.dart';
import 'delete_account/delete_account.dart';
import 'help_center/help_center.dart';
import 'privacy_policy/privacy_policy.dart';
import 'report_a_problem/report_a_problem.dart';
import 'terms_and_conditions/terms_and_conditions.dart';
import 'widgets/setting_section.dart';
import 'widgets/settings_links.dart';
import 'widgets/settings_toggle.dart';

class SettingsPage extends GetView<SettingsController> {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomTheme skillBuddyTheme = ThemeService().theme;
    Get.put(SettingsController());
    return SkillBuddyScaffold(
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.only(
            top: getRelativeHeight(30),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: getRelativeWidth(5)),
                child: Row(
                  children: <Widget>[
                    IconButton(
                      onPressed: Get.back<void>,
                      icon: Icon(Icons.close, color: skillBuddyTheme.graphite),
                    ),
                    Text(
                      'Settings & more'.tr,
                      style: SkillBuddyTypography.fromColor(
                        skillBuddyTheme.graphite,
                      ).kTitle,
                    ),
                  ],
                ),
              ),
              SizedBox(height: getRelativeHeight(20)),
              if (SkillBuddyConstants.devMode)
                GestureDetector(
                  onLongPress: () => Get.dialog<void>(
                    Dialog(
                      backgroundColor: skillBuddyTheme.seashell,
                      child:
                          //Todo remove when in production
                          Obx(
                        () => ListView(
                          children: <Widget>[
                            controller.infoTile(
                              'Api link',
                              SkillBuddyConstants.apiDomain,
                            ),
                            controller.infoTile(
                              'App name',
                              controller.packageInfo.value.appName,
                            ),
                            controller.infoTile(
                              'Package name',
                              controller.packageInfo.value.packageName,
                            ),
                            controller.infoTile(
                              'App version',
                              controller.packageInfo.value.version,
                            ),
                            controller.infoTile(
                              'Build number',
                              controller.packageInfo.value.buildNumber,
                            ),
                            controller.infoTile(
                              'Build signature',
                              controller.packageInfo.value.buildSignature,
                            ),
                            controller.infoTile(
                              'Installer store',
                              controller.packageInfo.value.installerStore ??
                                  'not available',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  child: const SettingsSection(
                    title:
                        'Press and hold here for build details(remove in production)',
                    list: <Widget>[],
                  ),
                )
              else
                const SizedBox(),
              SettingsSection(
                title: 'App settings'.tr,
                list: <Widget>[
                  Obx(() {
                    if (Get.find<UserStateService>().user.value.isVerified) {
                      return const SizedBox();
                    } else {
                      return SettingsLink(
                        icon: 'asset/icons/verify user.svg',
                        title: 'Verify User'.tr,
                        onTap: () => controller.verifyUser(),
                      );
                    }
                  }),
                  Obx(
                    () => SettingsLink(
                      icon: 'asset/icons/bell_icon.svg',
                      title: 'Notifications'.tr,
                      switchRequired: true,
                      // Provide the current value and update callback.
                      switchValue: controller.isNotificationsEnabled.value,
                      onChanged: (bool value) {
                        controller.toggleNotifications(value);
                      },
                      onTap: () {},
                    ),
                  ),
                  SettingsLink(
                    icon: 'asset/icons/change_icon.svg',
                    title: 'Change Password'.tr,
                    onTap: () => Get.to<void>(() => const ChangePasswordPage()),
                  ),
                  Obx(
                    () => SettingsToggle(
                      icon: 'asset/icons/Biometric login.svg',
                      title: 'Biometric login'.tr,
                      value: controller.isBiometricEnabled.value,
                      onChange: (bool value) {
                        controller.toggleBiometricLogin(value);
                      },
                    ),
                  ),
                ],
              ),
              SettingsSection(
                title: 'Help'.tr,
                list: <Widget>[
                  SettingsLink(
                    icon: 'asset/icons/error_icon.svg',
                    title: 'Report a problem'.tr,
                    onTap: () => Get.to<void>(() => const ReportAProblemPage()),
                  ),
                  SettingsLink(
                    icon: 'asset/icons/help_icon.svg',
                    title: 'Help Center'.tr,
                    onTap: () => Get.to<void>(() => const HelpCenterPage()),
                  ),
                  SettingsLink(
                    icon: 'asset/icons/privacy_icon.svg',
                    title: 'Privacy Policy'.tr,
                    onTap: () => Get.to<void>(() => const PrivacyPolicyPage()),
                  ),
                  SettingsLink(
                    icon: 'asset/icons/terms_icon.svg',
                    title: 'Terms and Conditions'.tr,
                    onTap: () =>
                        Get.to<void>(() => const TermsAndConditionsPage()),
                  ),
                  SettingsLink(
                    icon: 'asset/icons/logout.svg',
                    title: 'Logout'.tr,
                    onTap: controller.logout,
                  ),
                  SettingsLink(
                    icon: 'asset/icons/delete_icon.svg',
                    title: 'Delete account'.tr,
                    onTap: () => <void>{
                      if (controller.user.isTenant)
                        PopupManager.openTenentAccountDeletePopup()
                      else
                        Get.to<void>(() => const DeleteAccountPage()),
                    },
                    color: skillBuddyTheme.red,
                  ),
                ],
              ),
              const Gap(60),
              Center(
                child: Obx(
                  () => Text(
                    'SkillBuddy ${controller.buildVersion}',
                    style: SkillBuddyTypography.fromColor(
                      skillBuddyTheme.grey,
                    ).kParagraph,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
