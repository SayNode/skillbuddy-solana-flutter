import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../service/theme_service.dart';
import '../../../theme/theme.dart';
import '../../../theme/typography.dart';
import '../../../util/util.dart';
import '../../../widget/skillbuddy_button.dart';
import '../../../widget/skillbuddy_scaffold.dart';
import '../create_account_page.dart';
import '../forgot_password/controller/forgot_password_controller.dart';

class ResetPasswordPage extends GetView<ForgotPasswordController> {
  const ResetPasswordPage({
    super.key,
    this.email,
    this.onTap,
  });
  final String? email;
  final dynamic Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final CustomTheme skillBuddyTheme = ThemeService().theme;
    return SkillBuddyScaffold(
      title: '',
      backButton: true,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: getRelativeHeight(16),
            horizontal: getRelativeWidth(15),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Gap(getRelativeHeight(200)),
                Obx(
                  () => Text(
                    controller.emailIsSent.value
                        ? 'Email is sent'.tr
                        : controller.unknownEmailError.value.isEmpty
                            ? 'Email is being sent'.tr
                            : 'An error occured'.tr,
                    textAlign: TextAlign.center,
                    style: SkillBuddyTypography.fromColor(
                      skillBuddyTheme.graphite,
                    ).kTitle,
                  ),
                ),
                const Gap(15),
                Obx(
                  () => RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: SkillBuddyTypography.fromColor(
                        skillBuddyTheme.slate,
                      ).kParagraph,
                      children: <InlineSpan>[
                        TextSpan(
                          text: controller.emailIsSent.value
                              ? 'You have just received an email with a code to reset your password to '
                                  .tr
                              : controller.unknownEmailError.value.isEmpty
                                  ? 'We are sending an email to '.tr
                                  : "Can't send email to ".tr,
                        ),
                        if (email != null)
                          TextSpan(
                            text: '$email ',
                            style: SkillBuddyTypography.fromColor(
                              skillBuddyTheme.electric,
                            ).kParagraph,
                          ),
                      ],
                    ),
                  ),
                ),
                Gap(getRelativeHeight(10)),
                Obx(
                  () => controller.unknownEmailError.isNotEmpty
                      ? Text(
                          controller.unknownEmailError.value,
                          style: SkillBuddyTypography.fromColor(
                            skillBuddyTheme.red,
                          ).kParagraph,
                          textAlign: TextAlign.center,
                        )
                      : Container(),
                ),
                const Gap(100),
                Obx(
                  () => !controller.emailIsSent.value &&
                          controller.unknownEmailError.isEmpty
                      ? SpinKitCircle(
                          color: skillBuddyTheme.electric,
                          size: getRelativeWidth(180),
                        )
                      : Container(),
                ),
                const Spacer(),
                Obx(
                  () => SkillBuddyButton(
                    text: 'Continue'.tr,
                    // ignore: inference_failure_on_function_invocation
                    onTap: controller.unknownEmailError.isNotEmpty
                        ? () => Get.to<void>(const CreateAccountPage())
                        : onTap,
                  ),
                ),
                Gap(getRelativeHeight(30)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
