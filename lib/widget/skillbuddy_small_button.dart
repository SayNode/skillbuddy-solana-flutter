import 'package:flutter/material.dart';
import '../service/theme_service.dart';

import '../theme/theme.dart';
import '../theme/typography.dart';
import '../util/util.dart';

class SkillBuddySmallButton extends StatelessWidget {
  const SkillBuddySmallButton({
    required this.onTap,
    required this.text,
    this.buttonColor,
    this.textColor,
    super.key,
  });
  final VoidCallback onTap;
  final String text;
  final Color? buttonColor;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    final CustomTheme skillBuddyTheme = ThemeService().theme;

    return InkWell(
      highlightColor: buttonColor ?? skillBuddyTheme.electric,
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: getRelativeHeight(5),
        ),
        width: getRelativeWidth(80),
        // height: getRelativeHeight(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: buttonColor ?? skillBuddyTheme.electric,
        ),
        child: Center(
          child: Text(
            text,
            style: SkillBuddyTypography.fromColor(
              textColor ?? skillBuddyTheme.linen,
            ).kTextAdditional,
          ),
        ),
      ),
    );
  }
}
