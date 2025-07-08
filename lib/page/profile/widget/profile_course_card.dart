import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../model/content/course.dart';
import '../../../service/theme_service.dart';
import '../../../theme/theme.dart';
import '../../../theme/typography.dart';
import '../../../util/util.dart';

class ProfileCourseCard extends StatelessWidget {
  const ProfileCourseCard({
    required this.course,
    this.onTap,
    super.key,
  });
  final Course course;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final CustomTheme skillBuddyTheme = ThemeService().theme;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          children: <Widget>[
            Container(
              width: getRelativeWidth(65),
              height: getRelativeHeight(49),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: skillBuddyTheme.graphite,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  course.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Gap(20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    course.name,
                    style:
                        SkillBuddyTypography.fromColor(skillBuddyTheme.graphite)
                            .kParagraphSemiBold,
                  ),
                  AutoSizeText(
                    course.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: SkillBuddyTypography.fromColor(skillBuddyTheme.slate)
                        .kTextAdditional,
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
