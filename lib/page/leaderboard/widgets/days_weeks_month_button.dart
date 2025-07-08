import 'package:flutter/material.dart';

import '../../../service/theme_service.dart';
import '../../../theme/theme.dart';
import '../../../theme/typography.dart';
import '../../../util/util.dart';

class DaysWeeksMonthsButton extends StatelessWidget {
  const DaysWeeksMonthsButton({
    required this.text,
    required this.textColor,
    required this.color,
    required this.onTap,
    super.key,
  });

  final String text;
  final Color textColor;
  final Color color;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    final CustomTheme skillBuddyTheme = ThemeService().theme;

    return InkWell(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          border: Border.all(color: skillBuddyTheme.seashell), // Border color
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: getRelativeHeight(8)),
          child: Center(
            child: Text(
              text,
              style:
                  SkillBuddyTypography.fromColor(textColor).kParagraphSemiBold,
            ),
          ),
        ),
      ),
    );
  }
}
