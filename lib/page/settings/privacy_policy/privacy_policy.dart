import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../service/theme_service.dart';
import '../../../theme/theme.dart';
import '../../../theme/typography.dart';
import '../../../util/util.dart';
import '../../../widget/skillbuddy_scaffold.dart';
import 'controller/privacy_policy_controller.dart';

class PrivacyPolicyPage extends GetView<PrivacyPolicyController> {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.put(ThemeService()).theme;
    Get.put(PrivacyPolicyController());
    return SkillBuddyScaffold(
      backgroundColor: theme.linen,
      title: 'Privacy Policy',
      backButton: true,
      body: Column(
        children: <Widget>[
          Gap(getRelativeHeight(18)),
          Expanded(
            child: ListView.separated(
              itemCount: controller.privacyPolicyInfo.length,
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
                      controller.privacyPolicyInfo[i].title,
                      style: SkillBuddyTypography.fromColor(theme.graphite)
                          .kParagraphSemiBold,
                    ),
                    Gap(getRelativeHeight(9)),
                    Text(
                      controller.privacyPolicyInfo[i].description,
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
