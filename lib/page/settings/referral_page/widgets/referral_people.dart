import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../service/theme_service.dart';
import '../../../../theme/theme.dart';
import '../../../../theme/typography.dart';
import '../../../../util/util.dart';

enum ReferralStatus { accepted, rejected, accountCreated }

class ReferralPeople extends StatelessWidget {
  const ReferralPeople({
    required this.imageUrl,
    required this.name,
    required this.subtitle,
    required this.status,
    super.key,
  });
  final String imageUrl;
  final String name;
  final String subtitle;
  final ReferralStatus status;
  @override
  Widget build(BuildContext context) {
    final CustomTheme skillBuddyTheme = ThemeService().theme;
    Color statusColor;
    switch (status) {
      case ReferralStatus.accepted:
        statusColor = skillBuddyTheme.green;
      case ReferralStatus.rejected:
        statusColor = skillBuddyTheme.red;
      case ReferralStatus.accountCreated:
        statusColor = skillBuddyTheme.graphite;
    }
    return Padding(
      padding: EdgeInsets.only(bottom: getRelativeHeight(30)),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            foregroundImage: AssetImage(imageUrl),
            backgroundColor: skillBuddyTheme.grey,
            radius: 26,
          ),
          const Gap(10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                name,
                style: SkillBuddyTypography.fromColor(
                  skillBuddyTheme.graphite,
                ).kParagraphSemiBold,
              ),
              Text(
                subtitle,
                style: SkillBuddyTypography.fromColor(
                  skillBuddyTheme.slate,
                ).kTextAdditional,
              ),
            ],
          ),
          const Spacer(),
          Text(
            status.toString().split('.').last.replaceAllMapped(
                  RegExp(r'(\b[a-z])'),
                  (Match match) => match.group(0)!.toUpperCase(),
                ),
            style: SkillBuddyTypography.fromColor(statusColor).kTextAdditional,
          ),
          const Gap(20),
        ],
      ),
    );
  }
}
