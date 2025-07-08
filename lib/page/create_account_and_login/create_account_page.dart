import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../service/theme_service.dart';
import '../../theme/theme.dart';
import '../../theme/typography.dart';
import '../../util/util.dart';
import '../../widget/header_subheader.dart';
import '../../widget/skillbuddy_button.dart';
import '../../widget/skillbuddy_scaffold.dart';
import '../../widget/skillbuddy_textfield.dart';
import 'controller/create_account_controller.dart';
import 'widgets/google_apple_buttons.dart';

class CreateAccountPage extends GetView<CreateAccountController> {
  const CreateAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomTheme skillBuddyTheme = ThemeService().theme;
    Get.put(CreateAccountController());
    return SkillBuddyScaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: getRelativeWidth(15)),
        child: SingleChildScrollView(
          child: IntrinsicHeight(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                HeaderAndSubHeader(
                  header: 'Get Started: Sign Up'.tr,
                  subHeader: 'Create an account to get started'.tr,
                  arrowBack: false,
                ),
                Gap(getRelativeHeight(56)),
                SkillBuddyTextField(
                  hintText: 'Enter a name'.tr,
                  title: 'Name'.tr,
                  controller: controller.nameController,
                  maxLength: 20,
                ),
                Gap(getRelativeHeight(12)),
                SkillBuddyTextField(
                  hintText: 'name@gmail.com'.tr,
                  title: 'Email address'.tr,
                  controller: controller.emailController,
                ),
                Obx(
                  () => controller.emailError.value.isNotEmpty
                      ? Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            controller.emailError.value,
                            style: SkillBuddyTypography.fromColor(
                              skillBuddyTheme.red,
                            ).kParagraph,
                          ),
                        )
                      : Container(),
                ),
                Gap(getRelativeHeight(12)),
                Obx(
                  () => SkillBuddyTextField(
                    obscureText: !controller.showPassword.value,
                    hintText: 'Create a password'.tr,
                    title: 'Password'.tr,
                    controller: controller.passwordController,
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
                Gap(getRelativeHeight(4)),
                Obx(
                  () => controller.passwordError.value.isNotEmpty
                      ? Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            controller.passwordError.value,
                            style: SkillBuddyTypography.fromColor(
                              skillBuddyTheme.red,
                            ).kParagraph,
                          ),
                        )
                      : Container(),
                ),
                Gap(getRelativeHeight(16)),
                Row(
                  children: <Widget>[
                    Obx(
                      () => SizedBox(
                        height: 20,
                        width: 20,
                        child: Checkbox(
                          activeColor: skillBuddyTheme.electric,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          value: controller.isChecked.value,
                          onChanged: (bool? value) {
                            controller.isChecked.value =
                                !controller.isChecked.value;
                          },
                        ),
                      ),
                    ),
                    Gap(getRelativeWidth(10)),
                    SizedBox(
                      width: getRelativeWidth(360),
                      child: RichText(
                        text: TextSpan(
                          style: SkillBuddyTypography.fromColor(
                            skillBuddyTheme.slate,
                          ).kParagraph,
                          children: <InlineSpan>[
                            TextSpan(
                              text: "I've read and agree with the ".tr,
                            ),
                            _buildLinkTextSpan(
                              text: 'Terms and Conditions'.tr,
                              onTap: () => launchUrlLink(controller.termsUrl),
                            ),
                            TextSpan(
                              text: ' and the '.tr,
                            ),
                            _buildLinkTextSpan(
                              text: 'Privacy Policy'.tr,
                              onTap: () => launchUrlLink(controller.privacyUrl),
                            ),
                            const TextSpan(
                              text: '.',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Gap(getRelativeHeight(25)),
                Obx(
                  () => SkillBuddyButton(
                    text: 'Create an account'.tr,
                    locked: !controller.isChecked.value,
                    onTap: () => controller.register(),
                  ),
                ),
                Gap(getRelativeHeight(4)),
                Obx(
                  () {
                    return Padding(
                      padding: EdgeInsets.only(top: getRelativeHeight(10)),
                      child: Text(
                        controller.nonFieldError.value,
                        style: SkillBuddyTypography.fromColor(
                          skillBuddyTheme.red,
                        ).kParagraph,
                      ),
                    );
                  },
                ),
                Gap(getRelativeHeight(20)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      width: getRelativeWidth(113),
                      child: Divider(color: skillBuddyTheme.grey),
                    ),
                    Text(
                      'or register with'.tr,
                      style: SkillBuddyTypography.fromColor(
                        skillBuddyTheme.graphite,
                      ).kParagraph,
                    ),
                    SizedBox(
                      width: getRelativeWidth(113),
                      child: Divider(color: skillBuddyTheme.grey),
                    ),
                  ],
                ),
                Gap(getRelativeHeight(32)),
                const GoogleAppleButtons(),
                Gap(getRelativeHeight(16)),
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: 'Already have an account? '.tr,
                      style: SkillBuddyTypography.fromColor(
                        skillBuddyTheme.slate,
                      ).kParagraphSemiBold,
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Log in'.tr,
                          style: SkillBuddyTypography.fromColor(
                            skillBuddyTheme.electric,
                          ).kParagraphSemiBold,
                          recognizer: TapGestureRecognizer()
                            ..onTap = controller.goToSignIn,
                        ),
                      ],
                    ),
                  ),
                ),
                const Gap(10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

TextSpan _buildLinkTextSpan({
  required String text,
  required VoidCallback onTap,
}) {
  final CustomTheme skillBuddyTheme = ThemeService().theme;

  return TextSpan(
    text: text,
    style: SkillBuddyTypography.fromColor(
      skillBuddyTheme.electric,
    ).kParagraph,
    recognizer: TapGestureRecognizer()..onTap = onTap,
  );
}
