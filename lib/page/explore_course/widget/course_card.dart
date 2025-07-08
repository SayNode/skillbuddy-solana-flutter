import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../model/content/course.dart';
import '../../../service/theme_service.dart';
import '../../../theme/theme.dart';
import '../../../theme/typography.dart';
import '../../../widget/popups/popup_manager.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({
    required this.course,
    super.key,
    this.onTap,
  });
  final Course course;
  final dynamic Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final CustomTheme skillBuddyTheme = ThemeService().theme;
    return Container(
      width: Get.size.width * 0.65,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: skillBuddyTheme.seashell,
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: course.image.isEmpty
                    ? ExtendedImage.asset(
                        'asset/images/logo_SkillBuddy.png',
                      )
                    : ExtendedImage.network(
                        course.image,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            const Gap(12),
            Text(
              course.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: SkillBuddyTypography.fromColor(skillBuddyTheme.graphite)
                  .kParagraphSemiBold
                  .copyWith(fontSize: 16),
            ),
            const Gap(8),
            GestureDetector(
              onTap: () => PopupManager.openCompanyInfoPopup(course),
              child: Row(
                children: <Widget>[
                  ClipOval(
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: skillBuddyTheme.linen,
                      child: course.company.logo.isEmpty
                          ? Image.asset('asset/images/logo_SkillBuddy.png')
                          : Image.network(
                              course.company.logo,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  const Gap(8),
                  Text(
                    course.company.name,
                    style: SkillBuddyTypography.fromColor(skillBuddyTheme.slate)
                        .kTextAdditional,
                  ),
                ],
              ),
            ),
            const Gap(12),
            Text(
              course.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: SkillBuddyTypography.fromColor(skillBuddyTheme.graphite)
                  .kParagraph,
            ),
            const Gap(12),
            const Spacer(),
            Row(
              children: <Widget>[
                SvgPicture.asset(
                  height: 15,
                  'asset/icons/people.svg',
                  colorFilter: ColorFilter.mode(
                    skillBuddyTheme.graphite == skillBuddyTheme.linen
                        ? skillBuddyTheme.linen
                        : skillBuddyTheme.electric,
                    BlendMode.srcIn,
                  ),
                ),
                const Gap(4),
                Text(
                  course.enrolledUsers
                      .toString(), //replace with number of people
                  style: SkillBuddyTypography.fromColor(
                    skillBuddyTheme.graphite,
                  ).kTextAdditional,
                ),
                const Gap(20),
                SvgPicture.asset(
                  'asset/icons/satoshi_icon.svg',
                  width: 14,
                  height: 14,
                ),
                const Gap(4),
                Text(
                  course.rewardAmount.toString(),
                  style: SkillBuddyTypography.fromColor(
                    skillBuddyTheme.graphite,
                  ).kTextAdditional,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
