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
import 'controller/update_password_controller.dart';

class UpdatePasswordPage extends GetView<UpdatePasswordController> {
  const UpdatePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(UpdatePasswordController());
    final CustomTheme theme = Get.put(ThemeService()).theme;
    String errorMessage;
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
              SkillBuddyTextField(
                title: 'New password'.tr,
                hintText: 'Create new password'.tr,
                obscureText: true,
                controller: controller.newPasswordController,
              ),
              Gap(getRelativeHeight(30)),
              SkillBuddyTextField(
                title: 'Confirm new password'.tr,
                hintText: 'Confirm new password'.tr,
                obscureText: true,
                controller: controller.confirmNewPassword,
                onChanged: (String value) {
                  controller.updateMatch();
                },
              ),
              Obx(() {
                errorMessage = (!controller.matches.value
                    ? "Passwords don't match".tr
                    : '');
                return Column(
                  children: <Widget>[
                    const Gap(
                      5,
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
              }),
              const Spacer(),
              Obx(
                () => SkillBuddyButton(
                  text: 'Change password'.tr,
                  // ignore: inference_failure_on_function_invocation
                  onTap: controller.onSubmit,
                  locked: !controller.isUnlock.value,
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
