// ignore_for_file: inference_failure_on_function_return_type

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../../../service/theme_service.dart';
import '../../../../theme/theme.dart';
import '../../../../theme/typography.dart';
import '../../../../util/util.dart';

class ReferralCard extends StatelessWidget {
  const ReferralCard({
    required this.title,
    required this.icon,
    required this.onTap,
    this.width = 190,
    this.height = 60,
    this.iconWidth = 25,
    this.gapSize = 10,
    this.radius = 10,
    this.smallText = false,
    super.key,
  });
  final String title;
  final String icon;
  final Function() onTap;
  final double width;
  final double height;
  final double iconWidth;
  final double gapSize;
  final bool smallText;
  final double radius;
  @override
  Widget build(BuildContext context) {
    final CustomTheme skillBuddyTheme = ThemeService().theme;

    return InkWell(
      onTap: onTap.call,
      borderRadius: BorderRadius.circular(radius),
      child: Container(
        width: getRelativeWidth(width),
        height: getRelativeHeight(height),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(color: skillBuddyTheme.grey),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              icon,
              width: getRelativeWidth(iconWidth),
              fit: BoxFit.scaleDown,
            ),
            Gap(gapSize),
            Text(
              title,
              style: smallText
                  ? SkillBuddyTypography.fromColor(
                      skillBuddyTheme.graphite,
                    ).kTextAdditional
                  : SkillBuddyTypography.fromColor(
                      skillBuddyTheme.graphite,
                    ).kParagraph,
            ),
          ],
        ),
      ),
    );
  }
}
