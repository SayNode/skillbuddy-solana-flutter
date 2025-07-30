import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../../service/theme_service.dart';
import '../../../theme/theme.dart';
import '../../../theme/typography.dart';
import '../../../util/util.dart';

class SettingsToggle extends StatelessWidget {
  const SettingsToggle({
    required this.icon,
    required this.title,
    required this.onChange,
    required this.value,
    super.key,
    this.color,
  });
  final String icon;
  final String title;
  final bool value;
  final Color? color;
  // ignore: avoid_positional_boolean_parameters
  final void Function(bool value) onChange;

  @override
  Widget build(BuildContext context) {
    final CustomTheme skillBuddyTheme = ThemeService()
        .theme; // Update this line with your theme service instantiation

    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.only(
          // top: getRelativeHeight(10),
          // bottom: getRelativeHeight(10),
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
            CupertinoSwitch(
              value: value,
              onChanged: onChange,
              onLabelColor: skillBuddyTheme.electric,
            ),
          ],
        ),
      ),
    );
  }
}
