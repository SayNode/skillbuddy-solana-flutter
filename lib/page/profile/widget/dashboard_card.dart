import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../../service/theme_service.dart';
import '../../../theme/theme.dart';
import '../../../theme/typography.dart';
import '../../../util/util.dart';

class DashBoardCard extends StatelessWidget {
  const DashBoardCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    this.clickable = false,
    super.key,
  });
  final String title;
  final String subtitle;
  final String icon;
  final bool clickable;
  @override
  Widget build(BuildContext context) {
    final CustomTheme skillBuddyTheme = ThemeService().theme;
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: getRelativeHeight(5),
        horizontal: getRelativeWidth(5),
      ),
      padding: EdgeInsets.only(
        top: getRelativeHeight(10),
        bottom: getRelativeHeight(10),
        left: getRelativeWidth(10),
      ),
      width: getRelativeWidth(190),

      // height: getRelativeHeight(50),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: skillBuddyTheme.grey,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              SvgPicture.asset(icon),
              Gap(getRelativeWidth(10)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    AutoSizeText(
                      title,
                      style: SkillBuddyTypography.fromColor(
                        skillBuddyTheme.graphite,
                      ).kParagraphSemiBold,
                      maxLines: 1,
                      minFontSize: 10,
                    ),
                    AutoSizeText(
                      subtitle,
                      style: SkillBuddyTypography.fromColor(
                        skillBuddyTheme.slate,
                      ).kTextAdditional,
                      maxLines: 1,
                      minFontSize: 8,
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (clickable)
            Positioned(
              right: 0,
              child: Icon(
                Icons.chevron_right,
                color: skillBuddyTheme.grey,
              ),
            ),
        ],
      ),
    );
  }
}
