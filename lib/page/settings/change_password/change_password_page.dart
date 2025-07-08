import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../service/theme_service.dart';
import '../../../theme/theme.dart';
import '../../../theme/typography.dart';
import '../../../util/util.dart';
import '../../../widget/skillbuddy_button.dart';
import '../../../widget/skillbuddy_scaffold.dart';
import '../../../widget/skillbuddy_textfield.dart';
import 'controller/change_password_controller.dart';

class ChangePasswordPage extends GetView<ChangePasswordController> {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ChangePasswordController controller =
        Get.put(ChangePasswordController());
    final CustomTheme theme = Get.put(ThemeService()).theme;
    String errorMessage;
    return SkillBuddyScaffold(
      backButton: true,
      title: 'Change Password'.tr,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: getRelativeWidth(20)),
        child: Form(
          key: controller.changePasswordFormKey.value,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Obx(
                  () => SkillBuddyTextField(
                    obscureText: controller.hidePassword.value,
                    title: 'Current password'.tr,
                    hintText: 'Confirm Current password'.tr,
                    controller: controller.passwordController,
                    suffixIcon: GestureDetector(
                      onTap: controller.setShowPassword,
                      child: Obx(
                        () => Icon(
                          controller.hidePassword.value
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: theme.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Obx(
                  () => SkillBuddyTextField(
                    obscureText: controller.hidePassword.value,
                    title: 'New Password'.tr,
                    hintText: 'Create new password'.tr,
                    controller: controller.newPasswordController,
                    suffixIcon: GestureDetector(
                      onTap: controller.setShowPassword,
                      child: Obx(
                        () => Icon(
                          controller.hidePassword.value
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: theme.grey,
                        ),
                      ),
                    ),
                    onChanged: (String value) {
                      controller
                        ..passwordStrength()
                        ..updateMatch();
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Obx(
                  () => SkillBuddyTextField(
                    obscureText: controller.hidePassword.value,
                    title: 'Confirm new password'.tr,
                    hintText: 'Confirm new password'.tr,
                    controller: controller.confirmNewPassword,
                    suffixIcon: GestureDetector(
                      onTap: controller.setShowPassword,
                      child: Obx(
                        () => Icon(
                          controller.hidePassword.value
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: theme.grey,
                        ),
                      ),
                    ),
                    onChanged: (String value) {
                      controller.updateMatch();
                    },
                  ),
                ),
              ),
              Obx(
                () {
                  errorMessage = controller.matches.value
                      ? (controller.invalidPassword.value
                          ? 'Password not strong enough'.tr
                          : '')
                      : "Passwords don't match".tr;

                  return Column(
                    children: <Widget>[
                      const Gap(
                        15,
                      ),
                      Obx(
                        () => controller.errorMessage.value.isNotEmpty
                            ? Container(
                                margin: const EdgeInsets.only(bottom: 15),
                                child: Text(
                                  controller.errorMessage.value,
                                  style: SkillBuddyTypography.fromColor(
                                    theme.red,
                                  ).kParagraph,
                                ),
                              )
                            : const SizedBox(),
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              errorMessage,
                              style: SkillBuddyTypography.fromColor(
                                theme.red,
                              ).kParagraph,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
              const Spacer(flex: 4),
              Obx(
                () => SkillBuddyButton(
                  text: 'Change password'.tr,
                  onTap: () {
                    controller.onPasswordChangeSubmit();
                  },
                  locked: !controller.isUnlock.value,
                ),
              ),
              const Gap(
                60,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
