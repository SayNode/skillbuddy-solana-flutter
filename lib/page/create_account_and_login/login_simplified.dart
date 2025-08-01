import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart' as rive; // Alias Rive import

import '../../service/theme_service.dart';
import '../../theme/theme.dart';
import '../../theme/typography.dart';
import '../../util/util.dart';
import '../../widget/header_subheader.dart';
import '../../widget/skillbuddy_button.dart';
import '../../widget/skillbuddy_scaffold.dart';
import '../../widget/skillbuddy_textfield.dart';
import 'controller/login_controller.dart';
import 'controller/simple_login_controller.dart';
import 'forgot_password/forgot_password.dart';
import 'login_page.dart';

class SimpleLoginPage extends GetView<SimpleLoginController> {
  const SimpleLoginPage({
    required this.username,
    super.key,
  });

  final String username;

  @override
  Widget build(BuildContext context) {
    final CustomTheme skillBuddyTheme = ThemeService().theme;
    Get.put(LoginController());
    return SkillBuddyScaffold(
      useSafeArea: false,
      body: SingleChildScrollView(
        child: IntrinsicHeight(
          child: Stack(
            children: <Widget>[
              SizedBox(
                height: getRelativeHeight(250),
                child: Column(
                  children: <Widget>[
                    Gap(getRelativeHeight(100)),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: getRelativeWidth(20)),
                        child: Image.asset(
                          'asset/images/logo_SkillBuddy.png',
                          scale: 7,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: getRelativeHeight(360),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: getRelativeWidth(210),
                    top: getRelativeHeight(30),
                  ),
                  child: const rive.RiveAnimation.asset(
                    'asset/animations/first_crane.riv',
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: getRelativeWidth(20),
                  left: getRelativeWidth(20),
                  top: getRelativeHeight(250),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Gap(getRelativeHeight(20)),
                    HeaderAndSubHeader(
                      header: '${'Welcome Back'.tr}\n$username',
                      subHeader: '',
                      arrowBack: false,
                    ),
                    Gap(getRelativeHeight(30)),
                    Obx(
                      () => SkillBuddyTextField(
                        title: 'Password'.tr,
                        obscureText: !controller.showPassword.value,
                        hintText: 'Password'.tr,
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
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: controller.passwordError.value.isNotEmpty
                              ? Obx(
                                  () => Text(
                                    controller.passwordError.value,
                                    style: SkillBuddyTypography.fromColor(
                                      skillBuddyTheme.red,
                                    ).kParagraph,
                                  ),
                                )
                              : Container(),
                        ),
                        const Gap(8),
                        Material(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: () => Get.to<Widget>(ForgotPassword.new),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              child: Text(
                                'Forgot password?'.tr,
                                style: SkillBuddyTypography.fromColor(
                                  skillBuddyTheme.electric,
                                ).kParagraph,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Gap(getRelativeHeight(25)),
                    SkillBuddyButton(
                      text: 'Log in'.tr,
                      onTap: () async {
                        await controller.login();
                      },
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
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: '',
                          style: SkillBuddyTypography.fromColor(
                            skillBuddyTheme.slate,
                          ).kParagraphSemiBold,
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Change account'.tr,
                              style: SkillBuddyTypography.fromColor(
                                skillBuddyTheme.electric,
                              ).kParagraphSemiBold,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () =>
                                    Get.offAll<void>(() => const LoginPage()),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Gap(40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
