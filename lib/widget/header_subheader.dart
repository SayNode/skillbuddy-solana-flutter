import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../service/theme_service.dart';
import '../theme/theme.dart';
import '../theme/typography.dart';

class HeaderAndSubHeader extends StatelessWidget {
  const HeaderAndSubHeader({
    required this.header,
    required this.subHeader,
    this.isCentered = false,
    this.arrowBack = true,
    super.key,
  });
  final String header;
  final String subHeader;
  final bool isCentered;
  final bool arrowBack;
  @override
  Widget build(BuildContext context) {
    final CustomTheme skillBuddyTheme = ThemeService().theme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Gap(20),
        Row(
          children: <Widget>[
            if (arrowBack)
              Material(
                shape: const CircleBorder(),
                child: InkWell(
                  onTap: () => Get.back<void>(),
                  customBorder: const CircleBorder(),
                  child: const Icon(
                    Icons.arrow_back,
                    size: 24,
                  ),
                ),
              )
            else
              const SizedBox(),
            const Gap(4),
            Text(
              header,
              style: SkillBuddyTypography.fromColor(
                skillBuddyTheme.graphite,
              ).kTitle,
              textAlign: isCentered ? TextAlign.center : TextAlign.start,
            ),
          ],
        ),
        const Gap(8),
        Text(
          subHeader,
          style: SkillBuddyTypography.fromColor(
            skillBuddyTheme.slate,
          ).kParagraph,
          textAlign: isCentered ? TextAlign.center : TextAlign.start,
        ),
      ],
    );
  }
}
