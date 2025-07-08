import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../service/theme_service.dart';
import '../../../theme/theme.dart';
import '../../../theme/typography.dart';
import '../../../util/util.dart';
import '../../../widget/expandable_tile.dart';
import '../../../widget/skillbuddy_scaffold.dart';
import 'controller/help_center_controller.dart';

class HelpCenterPage extends GetView<HelpCenterController> {
  const HelpCenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.put(ThemeService()).theme;
    Get.put(HelpCenterController());
    return SkillBuddyScaffold(
      backButton: true,
      backgroundColor: theme.linen,
      title: 'Help Center',
      body: Column(
        children: <Widget>[
          Gap(getRelativeHeight(18)),
          Expanded(
            child: ListView.separated(
              itemCount: controller.helpCenterInfo.length,
              separatorBuilder: (BuildContext context, int i) =>
                  Gap(getRelativeHeight(9)),
              itemBuilder: (BuildContext context, int i) => ExpandableTile(
                padding: EdgeInsets.symmetric(
                  horizontal: getRelativeWidth(9),
                ),
                header: Text(
                  controller.helpCenterInfo[i].title,
                  style: SkillBuddyTypography.fromColor(theme.graphite)
                      .kParagraphSemiBold,
                ),
                body: Text(
                  controller.helpCenterInfo[i].description,
                  textAlign: TextAlign.left,
                  style: SkillBuddyTypography.fromColor(theme.graphite)
                      .kTextAdditional,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
