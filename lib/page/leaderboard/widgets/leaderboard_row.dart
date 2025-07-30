import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../service/theme_service.dart';
import '../../../theme/theme.dart';
import '../../../theme/typography.dart';
import '../../../util/util.dart';

class LeaderboardRow extends StatelessWidget {
  const LeaderboardRow({
    required this.position,
    required this.onTap,
    required this.avatar,
    required this.name,
    required this.dayStreak,
    required this.xp,
    super.key,
  });

  final void Function()? onTap;
  final int position;
  final String name;
  final String avatar;
  final int dayStreak;
  final int xp;

  @override
  Widget build(BuildContext context) {
    final CustomTheme skillBuddyTheme = ThemeService().theme;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: getRelativeHeight(14)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Gap(getRelativeWidth(20)),
            SizedBox(
              width: 20,
              child: Text(
                '$position',
                style: SkillBuddyTypography.fromColor(skillBuddyTheme.slate)
                    .kParagraphSemiBold,
                textAlign: TextAlign.end,
              ),
            ),
            Gap(getRelativeWidth(20)),
            CircleAvatar(
              radius: 20,
              child: ClipOval(
                child: avatar.isEmpty
                    ? Image.asset('asset/images/avatar_default.png')
                    : Image.network(
                        avatar,
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
            Gap(getRelativeWidth(20)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    name,
                    style:
                        SkillBuddyTypography.fromColor(skillBuddyTheme.graphite)
                            .kParagraphSemiBold,
                  ),
                  Text(
                    '$dayStreak day streak'.tr,
                    style: SkillBuddyTypography.fromColor(skillBuddyTheme.slate)
                        .kTextAdditional,
                  ),
                ],
              ),
            ),
            Text(
              '$xp XP',
              style: SkillBuddyTypography.fromColor(skillBuddyTheme.graphite)
                  .kParagraphSemiBold,
            ),
            Gap(getRelativeWidth(20)),
          ],
        ),
      ),
    );
  }
}
