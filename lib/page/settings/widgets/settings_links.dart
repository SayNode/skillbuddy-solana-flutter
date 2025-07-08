import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../../service/theme_service.dart';
import '../../../theme/theme.dart';
import '../../../theme/typography.dart';
import '../../../util/util.dart';

class SettingsLink extends StatelessWidget {
  const SettingsLink({
    required this.icon,
    required this.title,
    required this.onTap,
    super.key,
    this.switchRequired = false,
    this.switchValue = false,
    this.onChanged,
    this.color,
  });
  final String icon;
  final String title;
  final bool switchRequired;
  final void Function() onTap;
  final Color? color;
  final bool switchValue;
  final void Function(bool)? onChanged;

  @override
  Widget build(BuildContext context) {
    final CustomTheme skillBuddyTheme = ThemeService()
        .theme; // Update this line with your theme service instantiation

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.only(
            top: getRelativeHeight(10),
            bottom: getRelativeHeight(10),
            left: getRelativeWidth(28),
            right: getRelativeWidth(16),
          ),
          child: Row(
            children: <Widget>[
              SvgPicture.asset(
                icon,
                width: getRelativeWidth(25),
                fit: BoxFit.scaleDown,
                colorFilter: ColorFilter.mode(
                  color ?? skillBuddyTheme.graphite,
                  BlendMode.srcIn,
                ),
              ),
              Gap(getRelativeWidth(7)),
              Text(
                title,
                style: SkillBuddyTypography.fromColor(
                  color ?? skillBuddyTheme.graphite,
                ).kParagraph,
              ),
              const Spacer(),
              if (switchRequired)
                CupertinoSwitch(
                  value: switchValue,
                  onChanged: onChanged,
                  onLabelColor: skillBuddyTheme.electric,
                )
              else
                const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
