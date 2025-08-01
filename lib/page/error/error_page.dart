/// This file has been generated by Flutter Architect.
/// Flutter Architect is a tool that generates boilerplate code for your Flutter projects.
/// Flutter Architect was created @SayNode Operations AG by Yann Marti and Francesco Romeo
/// https://saynode.ch
///
library;

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../service/theme_service.dart';
import '../../theme/theme.dart';
import '../../theme/typography.dart';
import '../../util/util.dart';
import '../../widget/skillbuddy_button.dart';
import '../../widget/skillbuddy_scaffold.dart';
import 'controller/error_controller.dart';

class ErrorPage extends GetView<ErrorController> {
  const ErrorPage({required this.error, super.key});

  final Object error;

  @override
  Widget build(BuildContext context) {
    Get.put(ErrorController());
    final CustomTheme skillBuddyTheme = Get.put(ThemeService()).theme;
    return SkillBuddyScaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: getRelativeHeight(20)),
        child: Column(
          children: <Widget>[
            Gap(getRelativeHeight(100)),
            Text(
              'Oops! Page not found'.tr,
              style: SkillBuddyTypography.fromColor(
                skillBuddyTheme.graphite,
              ).kTitle,
            ),
            const Gap(15),
            Text(
              "Looks like we couldn't reach this page. Please check your connection and re-open the app"
                  .tr,
              style: SkillBuddyTypography.fromColor(
                skillBuddyTheme.slate,
              ).kParagraph,
              textAlign: TextAlign.center,
            ),
            Gap(getRelativeHeight(100)),
            Image.asset('asset/images/stork_error.png'),
            Gap(getRelativeHeight(100)),
            SkillBuddyButton(
              text: 'Back to home'.tr,
              color: skillBuddyTheme.graphite,
              textColor: skillBuddyTheme.linen,
              onTap: () {
                Get.offAllNamed<dynamic>('/');
              },
            ),
          ],
        ),
      ),
    );
  }
}
