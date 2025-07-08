import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../service/theme_service.dart';
import '../../../theme/theme.dart';
import '../../../theme/typography.dart';
import '../../../util/util.dart';
import '../../../widget/skillbuddy_button.dart';
import '../../../widget/skillbuddy_chip.dart';
import '../../../widget/skillbuddy_scaffold.dart';
import 'controller/time_selection_controller.dart';

class TimeSelectionPage extends GetView<TimeSelectionController> {
  const TimeSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.put(ThemeService()).theme;
    Get.put(TimeSelectionController());
    return SkillBuddyScaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getRelativeWidth(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Gap(getRelativeHeight(36)),
            Text(
              'How much time would you like to spend on your daily growth?'.tr,
              style: SkillBuddyTypography.fromColor(theme.graphite).kTitle,
            ),
            Gap(getRelativeHeight(18)),
            Text(
              'Choose your learning adventure: decide your study time'.tr,
              style: SkillBuddyTypography.fromColor(theme.slate).kParagraph,
            ),
            const Spacer(),
            Column(
              children: <Widget>[
                for (int i = 0; i < controller.timeSelections.length; i++)
                  Obx(
                    () => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: SkillBuddyChip(
                        onTap: () => controller.setTimeSelectionIndex(i),
                        selected: controller.timeSelectionIndex.value == i,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 10,
                          ),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  '@minutes minutes'.trParams(<String, String>{
                                    'minutes': controller
                                        .timeSelections[i].minutes
                                        .toString(),
                                  }),
                                  textAlign: TextAlign.start,
                                  style: SkillBuddyTypography.fromColor(
                                    theme.graphite,
                                  ).kParagraph,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '@lessonsAMonth lessons a month'
                                      .trParams(<String, String>{
                                    'lessonsAMonth': controller
                                        .timeSelections[i].lessonsAMonth
                                        .toString(),
                                  }),
                                  textAlign: TextAlign.end,
                                  style: SkillBuddyTypography.fromColor(
                                    theme.slate,
                                  ).kParagraph,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const Spacer(flex: 4),
            Obx(
              () => SkillBuddyButton(
                text: 'Next'.tr,
                onTap: controller.next,
                locked: !controller.validTimeSelection,
              ),
            ),
            Center(
              child: TextButton(
                onPressed: controller.skip,
                style: ButtonStyle(
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                child: Text(
                  'Skip for now'.tr,
                  style: SkillBuddyTypography.fromColor(theme.slate).kParagraph,
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
