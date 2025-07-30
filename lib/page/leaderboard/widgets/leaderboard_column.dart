import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../../service/theme_service.dart';
import '../../../theme/theme.dart';
import '../../../theme/typography.dart';
import '../../../util/util.dart';

class LeaderboardColumn extends StatelessWidget {
  const LeaderboardColumn({
    required this.onTap,
    required this.position,
    required this.name,
    required this.avatar,
    required this.xp,
    super.key,
  });

  final void Function()? onTap;
  final int position;
  final String name;
  final int xp;
  final String avatar;

  @override
  Widget build(BuildContext context) {
    final CustomTheme skillBuddyTheme = ThemeService().theme;
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: getRelativeWidth(100),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (position == 1)
              Padding(
                padding: EdgeInsets.only(bottom: getRelativeHeight(8)),
                child: SvgPicture.asset(
                  'asset/icons/crown_blue_icon.svg',
                  width: getRelativeWidth(30),
                  height: getRelativeHeight(30),
                ),
              )
            else
              Text(
                position.toString(),
                style: SkillBuddyTypography.fromColor(skillBuddyTheme.electric)
                    .kTitle,
              ),
            Gap(getRelativeHeight(6)),
            DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: skillBuddyTheme.electric,
              ),
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: ClipOval(
                  child: avatar.isEmpty
                      ? Image.asset(
                          'asset/images/avatar_default.png',
                          width: getRelativeWidth(60),
                          height: getRelativeWidth(60),
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          avatar,
                          width: getRelativeWidth(60),
                          height: getRelativeWidth(60),
                          fit: BoxFit.cover,
                          errorBuilder: (
                            BuildContext context,
                            Object error,
                            StackTrace? stackTrace,
                          ) =>
                              Image.asset('asset/images/avatar_default.png'),
                        ),
                ),
              ),
            ),
            Gap(getRelativeHeight(8)),
            Text(
              name,
              style: SkillBuddyTypography.fromColor(skillBuddyTheme.graphite)
                  .kParagraphSemiBold,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Gap(getRelativeHeight(2)),
            Text(
              '$xp XP',
              style: SkillBuddyTypography.fromColor(skillBuddyTheme.electric)
                  .kParagraph,
            ),
          ],
        ),
      ),
    );
  }
}
