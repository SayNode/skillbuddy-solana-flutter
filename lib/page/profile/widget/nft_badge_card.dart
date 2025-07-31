import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../service/theme_service.dart';
import '../../../theme/theme.dart';
import '../../../theme/typography.dart';
import '../../../util/util.dart';

enum NftBadgeStatus { locked, unlocked, redeeming, redeemed }

class NftBadgeCard extends StatelessWidget {
  const NftBadgeCard({
    required this.title,
    required this.status,
    required this.onTap,
    required this.nft,
    super.key,
  });

  final String title;
  final NftBadgeStatus status;
  final VoidCallback onTap;
  final String nft;

  @override
  Widget build(BuildContext context) {
    final CustomTheme skillBuddyTheme = ThemeService().theme;

    if (status == NftBadgeStatus.locked) {
      return Container(
        padding: EdgeInsets.symmetric(
          vertical: getRelativeHeight(8),
          horizontal: getRelativeWidth(10),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: skillBuddyTheme.grey,
          ),
        ),
        child: Row(
          children: <Widget>[
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    nft,
                    width: getRelativeWidth(50),
                    height: getRelativeWidth(50),
                    fit: BoxFit.cover,
                    color: skillBuddyTheme.linen.withValues(alpha: 0.5),
                    colorBlendMode: BlendMode.darken,
                  ),
                ),
                Icon(Icons.lock, color: skillBuddyTheme.graphite, size: 24),
              ],
            ),
            Gap(getRelativeWidth(10)),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AutoSizeText(
                    title,
                    style: SkillBuddyTypography.fromColor(
                      skillBuddyTheme.graphite.withAlpha(150),
                    ).kParagraphSemiBold,
                    maxLines: 2,
                  ),
                  Text(
                    'Locked',
                    style: SkillBuddyTypography.fromColor(
                      skillBuddyTheme.red.withAlpha(200),
                    ).kTextAdditional,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: getRelativeHeight(8),
          horizontal: getRelativeWidth(10),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: skillBuddyTheme.grey,
          ),
        ),
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                nft,
                width: getRelativeWidth(50),
                height: getRelativeWidth(50),
                fit: BoxFit.cover,
              ),
            ),
            Gap(getRelativeWidth(10)),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AutoSizeText(
                    title,
                    style: SkillBuddyTypography.fromColor(
                      skillBuddyTheme.graphite,
                    ).kParagraphSemiBold,
                    maxLines: 2,
                  ),
                  Text(
                    status == NftBadgeStatus.locked
                        ? 'Locked'
                        : status == NftBadgeStatus.unlocked
                            ? 'Unlocked'
                            : status == NftBadgeStatus.redeeming
                                ? 'Redeeming ...'
                                : 'Redeemed',
                    style: SkillBuddyTypography.fromColor(
                      status == NftBadgeStatus.locked
                          ? skillBuddyTheme.red
                          : status == NftBadgeStatus.unlocked
                              ? skillBuddyTheme.green
                              : skillBuddyTheme.electric,
                    ).kTextAdditional,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
