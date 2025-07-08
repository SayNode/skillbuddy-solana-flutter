import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../service/theme_service.dart';
import '../../../theme/theme.dart';
import '../../../theme/typography.dart';
import '../../../util/util.dart';
import '../../../widget/skillbuddy_button.dart';
import '../../../widget/skillbuddy_scaffold.dart';
import 'controller/delete_account_controller.dart';

class DeleteAccountPage extends GetView<DeleteAccountController> {
  const DeleteAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.put(ThemeService()).theme;
    Get.put(DeleteAccountController());
    return SkillBuddyScaffold(
      backButton: true,
      title: 'Delete account'.tr,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: getRelativeWidth(18)),
        child: Column(
          children: <Widget>[
            Gap(getRelativeHeight(18)),
            Text(
              "We're sorry to see you go! If you wish to delete your account, please be aware of the following:"
                  .tr,
              style: SkillBuddyTypography.fromColor(theme.graphite)
                  .kParagraphSemiBold,
            ),
            Gap(getRelativeHeight(9)),
            Expanded(
              child: ListView.separated(
                itemCount: controller.deleteInfo.length,
                separatorBuilder: (BuildContext context, int i) =>
                    Gap(getRelativeHeight(9)),
                itemBuilder: (BuildContext context, int i) => Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: getRelativeHeight(9),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        controller.deleteInfo[i].title,
                        style: SkillBuddyTypography.fromColor(theme.graphite)
                            .kParagraphSemiBold,
                      ),
                      Gap(getRelativeHeight(9)),
                      Text(
                        controller.deleteInfo[i].description,
                        style: SkillBuddyTypography.fromColor(theme.graphite)
                            .kTextAdditional,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Spacer(),
            SkillBuddyButton(
              text: 'Oops, I changed my mind'.tr,
              onTap: controller.back,
            ),
            Center(
              child: Obx(
                () => TextButton(
                  onPressed: controller.timer.value > 0
                      ? null
                      : controller.deleteAccount,
                  style: ButtonStyle(
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  child: Text(
                    '${'Delete my account'.tr}${controller.timer.value > 0 ? ' ${'(wait @seconds seconds...)'.trParams(<String, String>{
                            'seconds': controller.timer.value.toString(),
                          })}' : ''}',
                    style: SkillBuddyTypography.fromColor(
                      controller.timer.value > 0 ? theme.grey : theme.graphite,
                    ).kParagraphSemiBold,
                  ),
                ),
              ),
            ),
            Gap(getRelativeHeight(9)),
          ],
        ),
      ),
    );
  }
}
