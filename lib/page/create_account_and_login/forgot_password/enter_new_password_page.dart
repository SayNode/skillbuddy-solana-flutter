import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../service/theme_service.dart';
import '../../../theme/theme.dart';
import '../../../theme/typography.dart';
import '../../../util/util.dart';
import '../../../widget/header_subheader.dart';
import '../../../widget/skillbuddy_button.dart';
import '../../../widget/skillbuddy_scaffold.dart';
import '../../../widget/skillbuddy_textfield.dart';
import 'controller/forgot_password_controller.dart';

class EnterNewPasswordPage extends GetView<ForgotPasswordController> {
  const EnterNewPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomTheme skillBuddyTheme = ThemeService().theme;

    return SkillBuddyScaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: getRelativeHeight(16),
          horizontal: getRelativeWidth(15),
        ),
        child: Center(
          child: Column(
            children: <Widget>[
              HeaderAndSubHeader(
                header: 'Create a new password'.tr,
                subHeader:
                    'Choose a strong and secure password to keep your account safe'
                        .tr,
              ),
              Gap(getRelativeHeight(70)),
              Obx(
                () => SkillBuddyTextField(
                  title: 'New password'.tr,
                  hintText: 'Create new password'.tr,
                  obscureText: !controller.showPassword.value,
                  controller: controller.newPasswordController,
                  onChanged: (String value) {
                    controller.updateMatch();
                  },
                  suffixIcon: GestureDetector(
                    onTap: () => controller.showPassword.toggle(),
                    child: Icon(
                      controller.showPassword.value
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: skillBuddyTheme.slate,
                    ),
                  ),
                ),
              ),
              Gap(getRelativeHeight(30)),
              Obx(
                () => SkillBuddyTextField(
                  title: 'Confirm new password'.tr,
                  hintText: 'Confirm new password'.tr,
                  obscureText: !controller.showPassword.value,
                  controller: controller.confirmPasswordController,
                  onChanged: (String value) {
                    controller.updateMatch();
                  },
                  suffixIcon: IconButton(
                    onPressed: () => controller.showPassword.toggle(),
                    icon: Icon(
                      color: skillBuddyTheme.slate,
                      controller.showPassword.value
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                  ),
                ),
              ),
              Gap(getRelativeHeight(20)),
              Obx(
                () => controller.createPasswordError.value.isNotEmpty
                    ? Text(
                        controller.createPasswordError.value,
                        style: SkillBuddyTypography.fromColor(
                          skillBuddyTheme.red,
                        ).kParagraphSemiBold,
                      )
                    : const SizedBox(),
              ),
              const Spacer(),
              Obx(
                () => SkillBuddyButton(
                  text: 'Change password'.tr,
                  onTap: () => controller.onPasswordChangeSubmit(),
                  locked: !controller.matches.value,
                ),
              ),
              Gap(getRelativeHeight(30)),
            ],
          ),
        ),
      ),
    );
  }
}
