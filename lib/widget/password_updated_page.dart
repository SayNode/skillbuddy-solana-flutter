import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../page/create_account_and_login/login_page.dart';
import '../service/theme_service.dart';
import '../theme/theme.dart';
import '../theme/typography.dart';
import '../util/util.dart';
import 'skillbuddy_button.dart';
import 'skillbuddy_scaffold.dart';

class PasswordUpdatedPage extends StatelessWidget {
  const PasswordUpdatedPage({super.key});

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
              Gap(getRelativeHeight(150)),
              Text(
                'Password successfully updated'.tr,
                style: SkillBuddyTypography.fromColor(
                  skillBuddyTheme.graphite,
                ).kTitle,
                textAlign: TextAlign.center,
              ),
              const Gap(8),
              Text(
                "You're all set! Your account is now secured with a new password"
                    .tr,
                style: SkillBuddyTypography.fromColor(
                  skillBuddyTheme.slate,
                ).kParagraph,
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              SkillBuddyButton(
                text: 'Log in'.tr,
                onTap: () => Get.offAll<void>(const LoginPage()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
