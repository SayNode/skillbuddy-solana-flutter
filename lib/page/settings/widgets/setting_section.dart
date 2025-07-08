import 'package:flutter/material.dart';

import '../../../service/theme_service.dart';
import '../../../theme/theme.dart';
import '../../../theme/typography.dart';
import '../../../util/util.dart';

class SettingsSection extends StatelessWidget {
  const SettingsSection({
    required this.title,
    required this.list,
    super.key,
  });
  final String title;
  final List<Widget> list;
  @override
  Widget build(BuildContext context) {
    final CustomTheme skillBuddyTheme = ThemeService().theme;
    return Padding(
      padding: EdgeInsets.only(
        top: getRelativeHeight(15),
        bottom: getRelativeHeight(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getRelativeWidth(20)),
            child: Text(
              title,
              style: SkillBuddyTypography.fromColor(
                skillBuddyTheme.slate,
              ).kParagraph,
            ),
          ),
          SizedBox(height: getRelativeHeight(10)),
          Column(
            children: list,
          ),
        ],
      ),
    );
  }
}
