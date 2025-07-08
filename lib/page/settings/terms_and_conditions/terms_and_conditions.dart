import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../service/theme_service.dart';
import '../../../theme/theme.dart';
import '../../../theme/typography.dart';
import '../../../util/util.dart';
import '../../../widget/skillbuddy_scaffold.dart';
import 'controller/terms_and_conditions_controller.dart';

class TermsAndConditionsPage extends GetView<TermsAndConditionsController> {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.put(ThemeService()).theme;
    Get.put(TermsAndConditionsController());
    return SkillBuddyScaffold(
      backgroundColor: theme.linen,
      title: 'Terms and conditions',
      backButton: true,
      body: Column(
        children: <Widget>[
          Gap(getRelativeHeight(18)),
          Expanded(
            child: ListView.separated(
              itemCount: controller.termsAndConditionsInfo.length,
              separatorBuilder: (BuildContext context, int i) =>
                  Gap(getRelativeHeight(9)),
              itemBuilder: (BuildContext context, int i) => Padding(
                padding: EdgeInsets.fromLTRB(
                  getRelativeWidth(18),
                  0,
                  getRelativeWidth(18),
                  getRelativeHeight(18),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      controller.termsAndConditionsInfo[i].title,
                      style: SkillBuddyTypography.fromColor(theme.graphite)
                          .kParagraphSemiBold,
                    ),
                    Gap(getRelativeHeight(9)),
                    Text(
                      controller.termsAndConditionsInfo[i].description,
                      style: SkillBuddyTypography.fromColor(theme.graphite)
                          .kTextAdditional,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
