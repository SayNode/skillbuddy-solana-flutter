import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/content/course.dart';
import '../../page/explore_course/controller/discover_courses_controller.dart';
import '../../service/theme_service.dart';
import '../../theme/theme.dart';
import '../../theme/typography.dart';
import '../../util/util.dart';

class CompanyInfoPopup extends StatelessWidget {
  const CompanyInfoPopup({required this.course, super.key});

  final Course course;

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final CustomTheme skillBuddyTheme = ThemeService().theme;
    final DiscoverCoursesController controller =
        Get.find<DiscoverCoursesController>();
    final List<Course> availableCoursesByCompany = controller.suggestions
        .where(
          (Course element) =>
              element.company.name == course.company.name && element.activated,
        )
        .toList();

    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getRelativeWidth(20),
          vertical: getRelativeHeight(8),
        ),
        child: Column(
          children: <Widget>[
            Gap(getRelativeHeight(30)),
            if (course.company.logo.isEmpty)
              const SizedBox()
            else
              Image.network(course.company.logo, width: 100),
            Gap(getRelativeHeight(20)),
            Text(
              course.company.name,
              style: SkillBuddyTypography.fromColor(
                skillBuddyTheme.electric,
              ).kTitle,
            ),
            Gap(getRelativeHeight(20)),
            if (course.company.description.isNotEmpty)
              Text(
                course.company.description,
                style: SkillBuddyTypography.fromColor(
                  skillBuddyTheme.graphite,
                ).kParagraph,
              ),
            Gap(getRelativeHeight(15)),
            if (course.company.coursesByCompany.isEmpty)
              const SizedBox()
            else
              Text(
                'Courses by ${course.company.name}',
                style: SkillBuddyTypography.fromColor(
                  skillBuddyTheme.electric,
                ).kParagraphSemiBold,
              ),
            Gap(getRelativeHeight(10)),
            if (availableCoursesByCompany.isEmpty)
              const SizedBox()
            else
              ListView.builder(
                itemBuilder: (BuildContext context, int index) => Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: getRelativeHeight(5),
                  ),
                  child: Row(
                    children: <Widget>[
                      SvgPicture.asset('asset/icons/Rectangle 195.svg'),
                      Gap(getRelativeWidth(10)),
                      InkWell(
                        onTap: () {
                          Get.back<void>();
                          final Course course =
                              availableCoursesByCompany[index];
                          controller.goToCourseDetails(
                            course,
                          );
                        },
                        child: SizedBox(
                          width: getRelativeWidth(200),
                          child: Text(
                            availableCoursesByCompany[index].name,
                            style: SkillBuddyTypography.fromColor(
                              skillBuddyTheme.graphite,
                            ).kParagraph,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: availableCoursesByCompany.length,
              ),
            Gap(getRelativeHeight(5)),
            if (course.company.website.isEmpty &
                course.company.discord.isEmpty &
                course.company.twitter.isEmpty)
              const SizedBox()
            else
              Text(
                'Connect with ${course.company.name}',
                style: SkillBuddyTypography.fromColor(
                  skillBuddyTheme.electric,
                ).kParagraphSemiBold,
              ),
            Gap(getRelativeHeight(10)),
            Column(
              children: <Widget>[
                if (course.company.website.isEmpty)
                  const SizedBox()
                else
                  InkWell(
                    onTap: () => _launchUrl(course.company.website),
                    child: IconBulletPoints(
                      text: 'Website',
                      icon: MdiIcons.fromString('web'),
                    ),
                  ),
                if (course.company.discord.isEmpty)
                  const SizedBox()
                else
                  InkWell(
                    onTap: () => _launchUrl(course.company.discord),
                    child: const IconBulletPoints(
                      text: 'Discord',
                      icon: Icons.discord,
                    ),
                  ),
                if (course.company.twitter.isEmpty)
                  const SizedBox()
                else
                  InkWell(
                    onTap: () => _launchUrl(course.company.twitter),
                    child: IconBulletPoints(
                      text: 'Twitter',
                      icon: MdiIcons.fromString('twitter'),
                    ),
                  ),
              ],
            ),
            Gap(getRelativeHeight(10)),
          ],
        ),
      ),
    );
  }
}

// These are the widgets used in the popup and are not going to be used again in the app hence why i have left them at the bottom of the page
class IconBulletPoints extends StatelessWidget {
  const IconBulletPoints({
    required this.text,
    required this.icon,
    super.key,
  });

  final IconData? icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final CustomTheme skillBuddyTheme = ThemeService().theme;

    return Row(
      children: <Widget>[
        Icon(
          icon,
          color: skillBuddyTheme.graphite,
        ),
        Gap(getRelativeWidth(10)),
        Text(
          text,
          style: SkillBuddyTypography.fromColor(
            skillBuddyTheme.graphite,
          ).kParagraph,
        ),
      ],
    );
  }
}

class BulletPoints extends StatelessWidget {
  const BulletPoints({
    required this.text,
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    final CustomTheme skillBuddyTheme = ThemeService().theme;

    return Padding(
      padding: EdgeInsets.only(bottom: getRelativeHeight(10)),
      child: Row(
        children: <Widget>[
          SvgPicture.asset('asset/icons/Rectangle 195.svg'),
          Gap(getRelativeWidth(10)),
          Flexible(
            child: Text(
              text,
              style: SkillBuddyTypography.fromColor(
                skillBuddyTheme.graphite,
              ).kParagraph,
              maxLines: 2,
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}
