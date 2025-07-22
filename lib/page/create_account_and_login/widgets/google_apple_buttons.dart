import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../service/theme_service.dart';
import '../../../theme/theme.dart';
import '../../../theme/typography.dart';
import '../../../util/util.dart';
import '../../loading/loading_page.dart';
import '../controller/apple_google_controller.dart';

class GoogleAppleButtons extends GetView<AppleGoogleController> {
  const GoogleAppleButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final CustomTheme skillBuddyTheme = ThemeService().theme;
    Get.put(AppleGoogleController());
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => Get.to<void>(
                () => LoadingPage(
                  title: 'Logging in...',
                  job: controller.googleSignInPressed,
                ),
              ),
              style: ButtonStyle(
                backgroundColor:
                    WidgetStateProperty.all<Color>(Colors.transparent),
                surfaceTintColor:
                    WidgetStateProperty.all<Color>(skillBuddyTheme.linen),
                shape: WidgetStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: skillBuddyTheme.grey),
                  ),
                ),
                fixedSize: WidgetStateProperty.all<Size>(
                  Size(
                    getRelativeWidth(180),
                    getRelativeHeight(56),
                  ),
                ),
              ),
              child: SvgPicture.asset('asset/icons/google.svg'),
            ),
            if (Theme.of(context).platform == TargetPlatform.iOS)
              ElevatedButton(
                onPressed: () => controller.appleSignInPressed(),
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStateProperty.all<Color>(Colors.transparent),
                  surfaceTintColor:
                      WidgetStateProperty.all<Color>(skillBuddyTheme.linen),
                  shape: WidgetStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: skillBuddyTheme.grey),
                    ),
                  ),
                  fixedSize: WidgetStateProperty.all<Size>(
                    Size(
                      getRelativeWidth(180),
                      getRelativeHeight(56),
                    ),
                  ),
                ),
                child: SvgPicture.asset(
                  'asset/icons/apple.svg',
                ),
              ),
          ],
        ),
        const Gap(10),
        Obx(
          () => controller.error.value.isNotEmpty &&
                  controller.error.value != '{}'
              ? Text(
                  controller.error.value,
                  style: SkillBuddyTypography.fromColor(
                    skillBuddyTheme.red,
                  ).kParagraph,
                )
              : const SizedBox(),
        ),
      ],
    );
  }
}
