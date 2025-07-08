import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../service/theme_service.dart';
import '../../../theme/theme.dart';
import '../../../theme/typography.dart';
import '../../../util/util.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    required this.xp,
    this.color,
    this.level,
    super.key,
  });
  final String? level;
  final Color? color;
  final int xp;

  @override
  Widget build(BuildContext context) {
    final CustomTheme skillBuddyTheme = ThemeService().theme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
            left: getRelativeWidth(15),
            bottom: getRelativeHeight(10),
          ),
          child: Text(
            level ?? 'XP this week'.tr,
            style: SkillBuddyTypography.fromColor(
              skillBuddyTheme.graphite,
            ).kParagraphSemiBold,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: getRelativeWidth(15)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: SizedBox(
                  height: getRelativeHeight(20),
                  // width: getRelativeWidth(274),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: xp % 100 == 0 ? 0 : (xp % 100) / 100,
                      backgroundColor: skillBuddyTheme.seashell,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        skillBuddyTheme.electric,
                      ),
                      minHeight: 20,
                    ),
                  ),
                ),
              ),
              Gap(
                getRelativeWidth(10),
              ),
              Padding(
                padding: EdgeInsets.only(right: getRelativeWidth(20)),
                child: RichText(
                  text: TextSpan(
                    style: SkillBuddyTypography.fromColor(
                      skillBuddyTheme.slate,
                    ).kParagraphSemiBold,
                    children: <InlineSpan>[
                      TextSpan(
                        text: (xp % 100).toString(),
                        style: TextStyle(color: skillBuddyTheme.electric),
                      ),
                      const TextSpan(text: '/100 XP'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
