import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../model/content/course.dart';
import '../../../service/theme_service.dart';
import '../../../theme/theme.dart';
import '../../../theme/typography.dart';
import '../../../util/util.dart';
import '../../../widget/popups/popup_manager.dart';
import '../controller/my_courses_controller.dart';

class MyCourseCard extends StatelessWidget {
  const MyCourseCard({
    required this.course,
    required this.progress,
    super.key,
    this.onTap,
    this.onOptionsTap,
    this.onFavoriteTap,
  });

  final Course course;
  final double progress;
  final VoidCallback? onTap;
  final VoidCallback? onOptionsTap;
  final VoidCallback? onFavoriteTap;

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.put(ThemeService()).theme;
    final MyCoursesController controller = Get.find<MyCoursesController>();

    final Color adjustedProgressGradient = Color.fromRGBO(
      (theme.electric.r * 255 - 80).toInt(),
      (theme.electric.g * 255 - 80).toInt(),
      (theme.electric.b * 255 - 80).toInt(),
      1,
    );

    return Stack(
      children: <Widget>[
        Material(
          borderRadius: BorderRadius.circular(8),
          color: theme.seashell,
          elevation: 2,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: EdgeInsets.all(getRelativeWidth(6)),
              child: IntrinsicHeight(
                child: Stack(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Expanded(
                          flex: 4,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: course.image.isEmpty
                                ? ExtendedImage.asset(
                                    'asset/images/placeholder.png',
                                    fit: BoxFit.cover,
                                  )
                                : ExtendedImage.network(
                                    course.image,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        Gap(getRelativeWidth(16)),
                        Expanded(
                          flex: 10,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 16),
                                      child: Text(
                                        course.name,
                                        style: SkillBuddyTypography.fromColor(
                                          theme.graphite,
                                        ).kParagraphSemiBold,
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Gap(getRelativeHeight(8)),
                              GestureDetector(
                                onTap: () =>
                                    PopupManager.openCompanyInfoPopup(course),
                                child: Row(
                                  children: <Widget>[
                                    Material(
                                      shape: const CircleBorder(),
                                      elevation: 2,
                                      color: Colors.transparent,
                                      child: ClipOval(
                                        child: Container(
                                          width: getRelativeHeight(22),
                                          height: getRelativeHeight(22),
                                          color:
                                              theme.linen, // Background color
                                          child: course.company.logo.isEmpty
                                              ? Image.asset(
                                                  'asset/images/logo_SkillBuddy.png',
                                                  fit: BoxFit.fitWidth,
                                                )
                                              : Image.network(
                                                  course.company.logo,
                                                  fit: BoxFit.fitWidth,
                                                ),
                                        ),
                                      ),
                                    ),
                                    Gap(getRelativeWidth(6)),
                                    Text(
                                      course.company.name,
                                      style: SkillBuddyTypography.fromColor(
                                        theme.slate,
                                      ).kTextAdditional,
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                ),
                              ),
                              Gap(getRelativeHeight(10)),
                              Text(
                                course.description,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: SkillBuddyTypography.fromColor(
                                  theme.graphite,
                                ).kTextAdditional,
                                textAlign: TextAlign.left,
                              ),
                              Gap(getRelativeHeight(10)),
                              IntrinsicHeight(
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Expanded(
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                          color: theme.linen,
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: ShaderMask(
                                            shaderCallback: (Rect bounds) =>
                                                LinearGradient(
                                              colors: <Color>[
                                                theme.electric,
                                                adjustedProgressGradient,
                                                adjustedProgressGradient,
                                                theme.electric,
                                              ],
                                            ).createShader(bounds),
                                            blendMode: BlendMode.srcATop,
                                            child: LinearProgressIndicator(
                                              value: course.progress / 100,
                                              backgroundColor:
                                                  Colors.transparent,
                                              valueColor:
                                                  const AlwaysStoppedAnimation<
                                                      Color?>(
                                                Colors.white,
                                              ),
                                              minHeight: 4,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Gap(getRelativeHeight(12)),
                                    Text(
                                      '${course.progress.round()}%',
                                      style: SkillBuddyTypography.fromColor(
                                        theme.slate,
                                      ).kTextAdditional,
                                      textAlign: TextAlign.left,
                                    ),
                                    Gap(getRelativeHeight(6)),
                                  ],
                                ),
                              ),
                              Gap(getRelativeHeight(10)),
                              Row(
                                children: <Widget>[
                                  SvgPicture.asset(
                                    'asset/icons/people.svg',
                                    colorFilter: ColorFilter.mode(
                                      theme.electric,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                  Gap(getRelativeWidth(6)),
                                  Text(
                                    course.enrolledUsers.toString(),
                                    style: SkillBuddyTypography.fromColor(
                                      theme.slate,
                                    ).kTextAdditional,
                                    textAlign: TextAlign.left,
                                  ),
                                  Gap(getRelativeHeight(24)),
                                  Image.asset(
                                    'asset/icons/bonk.png',
                                    width: 20,
                                    height: 20,
                                    fit: BoxFit.cover,
                                  ),
                                  Gap(getRelativeWidth(6)),
                                  Text(
                                    course.rewardAmount.toString(),
                                    style: SkillBuddyTypography.fromColor(
                                      theme.slate,
                                    ).kTextAdditional,
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: PopupMenuButton<String>(
            color: theme.greyish,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            icon: Icon(
              Icons.more_vert,
              color: Get.find<ThemeService>().theme.graphite,
            ),
            onSelected: (String value) {
              switch (value) {
                case 'Remove course':
                  controller.removeCourse(course);
                case 'Progress reset':
                  controller.resetProgress(course);
                case 'Share':
                  controller.shareCourse(course);
              }
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  padding: EdgeInsets.symmetric(
                    horizontal: getRelativeWidth(20),
                    vertical: getRelativeHeight(8),
                  ),
                  height: 20,
                  value: 'Remove course',
                  child: Text(
                    'Remove course'.tr,
                    style: SkillBuddyTypography.fromColor(
                      theme.graphite,
                    ).kParagraph,
                  ),
                ),
                PopupMenuItem<String>(
                  padding: EdgeInsets.symmetric(
                    horizontal: getRelativeWidth(20),
                    vertical: getRelativeHeight(10),
                  ),
                  height: 20,
                  value: 'Progress reset',
                  child: Text(
                    'Progress reset'.tr,
                    style: SkillBuddyTypography.fromColor(
                      theme.graphite,
                    ).kParagraph,
                  ),
                ),
                PopupMenuItem<String>(
                  padding: EdgeInsets.symmetric(
                    horizontal: getRelativeWidth(20),
                    vertical: getRelativeHeight(8),
                  ),
                  height: 20,
                  value: 'Share',
                  child: Text(
                    'Share'.tr,
                    style: SkillBuddyTypography.fromColor(
                      theme.graphite,
                    ).kParagraph,
                  ),
                ),
              ];
            },
          ),
        ),
      ],
    );
  }
}
