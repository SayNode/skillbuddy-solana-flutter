import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../service/theme_service.dart';
import '../../../../theme/theme.dart';
import '../../../../theme/typography.dart';
import '../../../../util/util.dart';
import 'rounde_square_avatar.dart';

class ReferralHistorySection extends StatelessWidget {
  const ReferralHistorySection({
    required this.image,
    required this.title,
    required this.subtitle,
    required this.arrowPress,
    this.showArrow = false,
    this.arrowUp = false,
    super.key,
  });
  final String image;
  final String title;
  final String subtitle;
  final bool showArrow;
  // ignore: inference_failure_on_function_return_type
  final Function() arrowPress;
  final bool arrowUp;
  @override
  Widget build(BuildContext context) {
    final CustomTheme skillBuddyTheme = ThemeService().theme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: arrowPress,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            getRelativeWidth(20),
            getRelativeHeight(12),
            0,
            getRelativeHeight(12),
          ),
          child: Row(
            children: <Widget>[
              RoundedSquareAvatar(
                imageUrl: image,
                size: 50,
              ),
              const Gap(10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: SkillBuddyTypography.fromColor(
                      skillBuddyTheme.graphite,
                    ).kParagraphSemiBold,
                  ),
                  Text(
                    subtitle,
                    style: SkillBuddyTypography.fromColor(
                      skillBuddyTheme.slate,
                    ).kParagraph,
                  ),
                ],
              ),
              const Spacer(),
              if (showArrow)
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Icon(
                    arrowUp
                        ? Icons.keyboard_arrow_down
                        : Icons.keyboard_arrow_up,
                  ),
                )
              else
                Container(),
            ],
          ),
        ),
      ),
    );
  }
}
