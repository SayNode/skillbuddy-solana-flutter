import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../service/theme_service.dart';
import '../../../theme/theme.dart';
import '../../../theme/typography.dart';
import '../../../util/util.dart';
import '../../../widget/skillbuddy_button.dart';
import '../../../widget/skillbuddy_scaffold.dart';
import 'controller/report_a_problem_controller.dart';

class ReportAProblemPage extends GetView<ReportAProblemController> {
  const ReportAProblemPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.put(ThemeService()).theme;
    Get.put(ReportAProblemController());
    return SkillBuddyScaffold(
      backButton: true,
      backgroundColor: theme.linen,
      title: 'Report a problem'.tr,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Gap(getRelativeHeight(18)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: getRelativeWidth(18)),
              child: TextField(
                textInputAction: TextInputAction.done,
                controller: controller.textController,
                maxLines: 15,
                style:
                    SkillBuddyTypography.fromColor(theme.graphite).kParagraph,
                onChanged: (String text) => controller.validateText(text),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: theme.graphite,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: theme.graphite,
                      width: 2,
                    ),
                  ),
                  hintText: "Describe the issue you're having with the app".tr,
                  hintStyle:
                      SkillBuddyTypography.fromColor(theme.slate).kParagraph,
                ),
              ),
            ),
            Gap(getRelativeHeight(18)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: getRelativeWidth(18)),
              child: Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: controller.addPhoto,
                  child: Padding(
                    padding: EdgeInsets.all(getRelativeWidth(8)),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.add_a_photo_outlined,
                          size: 25,
                          color: theme.slate,
                        ),
                        Gap(getRelativeWidth(14)),
                        Text(
                          'Add a photo/screenshot'.tr,
                          style: SkillBuddyTypography.fromColor(theme.slate)
                              .kParagraph,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Obx(
              () => controller.photoBytes.value != null
                  ? SizedBox(
                      width: getRelativeWidth(200),
                      height: getRelativeHeight(200),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: getRelativeWidth(18),
                            right: getRelativeWidth(18),
                            top: getRelativeHeight(18),
                            bottom: getRelativeHeight(18),
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Image.memory(
                              controller.photoBytes.value!,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ),
            Gap(getRelativeHeight(38)),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getRelativeWidth(18),
              ),
              child: Obx(
                () => SkillBuddyButton(
                  text: 'Submit feedback'.tr,
                  onTap: controller.submit,
                  locked: !controller.textValid.value,
                ),
              ),
            ),
            Gap(
              getRelativeHeight(24),
            ),
            Text(
              'or contact us'.tr,
              style: SkillBuddyTypography.fromColor(theme.graphite)
                  .kParagraphSemiBold,
            ),
            Gap(
              getRelativeHeight(14),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getRelativeWidth(18),
              ),
              child: SkillBuddyButton(
                text: 'Connect to Discord'.tr,
                onTap: controller.openDiscordWebsite,
                leading: const Icon(
                  Icons.discord,
                  size: 25,
                  color: Colors.white,
                ),
              ),
            ),
            Gap(
              getRelativeHeight(95),
            ),
          ],
        ),
      ),
    );
  }
}
