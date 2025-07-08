import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../service/theme_service.dart';
import '../../../theme/theme.dart';
import '../../../theme/typography.dart';
import '../../../util/util.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({required this.onChanged, super.key});
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    final CustomTheme skillBuddyTheme = ThemeService().theme;

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Card(
        elevation: 0,
        color: skillBuddyTheme.seashell,
        child: TextField(
          onChanged: onChanged,
          decoration: InputDecoration(
            isDense: true,
            prefixIcon: Icon(
              Icons.search,
              size: getRelativeWidth(30),
              color: skillBuddyTheme.graphite,
            ),
            hintText: 'Search any courses'.tr,
            hintStyle: SkillBuddyTypography.fromColor(
              skillBuddyTheme.graphite,
            ).kParagraph,
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}
