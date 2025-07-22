import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../model/last_visited_lesson.dart';
import '../../service/content_service.dart';
import '../../service/theme_service.dart';
import '../../theme/theme.dart';
import '../../theme/typography.dart';
import '../../util/util.dart';
import '../../widget/popups/popup_manager.dart';
import '../../widget/see_more_widget.dart';
import '../../widget/skillbuddy_scaffold.dart';
import 'controller/course_controller.dart';

class CoursePage extends GetView<CourseDetailsController> {
  const CoursePage({
    required this.courseId,
    this.lastVisitedLesson,
    super.key,
    this.autoOpenFirstLesson = false,
  });
  final int courseId;
  final bool autoOpenFirstLesson;
  final LastVisitedLesson? lastVisitedLesson;

  @override
  Widget build(BuildContext context) {
    final CustomTheme skillBuddyTheme = ThemeService().theme;
    Get.put(
      CourseDetailsController(
        courseId,
        lastVisitedLesson: lastVisitedLesson,
        autoOpenFirstLesson: autoOpenFirstLesson,
      ),
    );

    // Fetch user enrolled courses initially
    controller.getUserEnrolledCourses();
    return PopScope(
      onPopInvokedWithResult: (bool didPop, dynamic result) =>
          Get.find<ContentService>().myCourses.reload(),
      child: SkillBuddyScaffold(
        backButton: true,
        title: 'Course details'.tr,
        body: Obx(
          () => !controller.loading.value
              ? Stack(
                  children: <Widget>[
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Gap(getRelativeHeight(8)),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: getRelativeWidth(16),
                            ),
                            child: SizedBox(
                              height: getRelativeHeight(206),
                              child: Stack(
                                children: <Widget>[
                                  Positioned.fill(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child:
                                          controller.course.value.image.isEmpty
                                              ? Image.asset(
                                                  'asset/images/logo_SkillBuddy.png',
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.network(
                                                  controller.course.value.image,
                                                  fit: BoxFit.cover,
                                                ),
                                    ),
                                  ),
                                  Positioned.fill(
                                    child: Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 12,
                                          bottom: 12,
                                        ),
                                        child: Material(
                                          shape: const StadiumBorder(),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 5,
                                              horizontal: 10,
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Image.asset(
                                                  'asset/images/people_blue.png',
                                                  width: getRelativeWidth(20),
                                                ),
                                                const Gap(5),
                                                Text(
                                                  controller.course.value
                                                      .enrolledUsers
                                                      .toString(),
                                                  style: SkillBuddyTypography
                                                          .fromColor(
                                                    skillBuddyTheme.linen,
                                                  ).kTextAdditional.copyWith(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                ),
                                                const Gap(15),
                                                Image.asset(
                                                  'asset/icons/bonk.png',
                                                  width: 20,
                                                  height: 20,
                                                ),
                                                const Gap(5),
                                                Text(
                                                  controller
                                                      .course.value.rewardAmount
                                                      .toString(),
                                                  style: SkillBuddyTypography
                                                          .fromColor(
                                                    skillBuddyTheme.linen,
                                                  ).kTextAdditional.copyWith(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Gap(getRelativeHeight(28)),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: getRelativeWidth(16),
                            ),
                            child: Text(
                              controller.course.value.name,
                              style: SkillBuddyTypography.fromColor(
                                skillBuddyTheme.graphite,
                              ).kTitle,
                            ),
                          ),
                          Gap(getRelativeHeight(14)),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: getRelativeWidth(16),
                            ),
                            child: GestureDetector(
                              onTap: () => PopupManager.openCompanyInfoPopup(
                                controller.course.value,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  if (controller
                                      .course.value.company.logo.isEmpty)
                                    Image.asset(
                                      'asset/images/logo_SkillBuddy.png',
                                      width: getRelativeWidth(24),
                                    )
                                  else
                                    Image.network(
                                      controller.course.value.company.logo,
                                      width: getRelativeWidth(24),
                                    ),
                                  const Gap(10),
                                  Text(
                                    controller.course.value.company.name.tr,
                                    style: SkillBuddyTypography.fromColor(
                                      skillBuddyTheme.graphite,
                                    ).kTextAdditional,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Gap(getRelativeHeight(14)),
                          Obx(
                            () => controller.isEnrolled.value
                                ? Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: getRelativeWidth(16),
                                    ),
                                    child: IntrinsicHeight(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: <Widget>[
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 3,
                                              ),
                                              child: LinearProgressIndicator(
                                                value: controller.progress
                                                        .toDouble() /
                                                    100,
                                                backgroundColor:
                                                    skillBuddyTheme.seashell,
                                                color: skillBuddyTheme.electric,
                                                minHeight: 4,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(
                                                  skillBuddyTheme.electric,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Gap(getRelativeHeight(12)),
                                          Text(
                                            '${controller.progress.round()}%',
                                            style:
                                                SkillBuddyTypography.fromColor(
                                              skillBuddyTheme.slate,
                                            ).kParagraph,
                                            textAlign: TextAlign.left,
                                          ),
                                          Gap(getRelativeHeight(6)),
                                        ],
                                      ),
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          ),
                          Gap(getRelativeHeight(8)),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: getRelativeWidth(16),
                            ),
                            child: Text(
                              'Overview'.tr,
                              style: SkillBuddyTypography.fromColor(
                                skillBuddyTheme.graphite,
                              ).kParagraphSemiBold,
                            ),
                          ),
                          Gap(getRelativeHeight(6)),
                          Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: getRelativeWidth(16),
                            ),
                            child: SeeMoreWidget(
                              text: controller.course.value.description,
                              style: SkillBuddyTypography.fromColor(
                                skillBuddyTheme.graphite,
                              ).kParagraph,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              children: <Widget>[
                                for (int moduleIndex = 0;
                                    moduleIndex < controller.modules.length;
                                    moduleIndex++) ...<Widget>[
                                  const Gap(20),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Divider(
                                          color: skillBuddyTheme.electric,
                                        ),
                                      ),
                                      const Gap(20),
                                      Text(
                                        '${'Module'.tr} ${moduleIndex + 1}',
                                        style: SkillBuddyTypography.fromColor(
                                          skillBuddyTheme.graphite,
                                        ).kParagraph.copyWith(fontSize: 16),
                                      ),
                                      const Gap(20),
                                      Expanded(
                                        child: Divider(
                                          color: skillBuddyTheme.electric,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Gap(8),
                                  Text(
                                    controller.modules[moduleIndex].name,
                                    style: SkillBuddyTypography.fromColor(
                                      skillBuddyTheme.electric,
                                    ).kParagraphSemiBold20.copyWith(
                                          fontWeight: FontWeight.w700,
                                        ),
                                  ),
                                  for (int chapterIndex = 0;
                                      chapterIndex <
                                          controller.modules[moduleIndex]
                                              .chapters.length;
                                      chapterIndex++) ...<Widget>[
                                    const Gap(10),
                                    Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: controller.isChapterLocked(
                                            moduleIndex,
                                            chapterIndex,
                                          )
                                              ? skillBuddyTheme.grey
                                              : skillBuddyTheme.electric,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: <Widget>[
                                          Text(
                                            '${'Chapter'.tr} ${chapterIndex + 1}',
                                            style:
                                                SkillBuddyTypography.fromColor(
                                              controller.isChapterLocked(
                                                moduleIndex,
                                                chapterIndex,
                                              )
                                                  ? skillBuddyTheme.grey
                                                  : skillBuddyTheme.graphite,
                                            ).kParagraph,
                                          ),
                                          const Gap(4),
                                          Text(
                                            controller.modules[moduleIndex]
                                                .chapters[chapterIndex].name,
                                            style:
                                                SkillBuddyTypography.fromColor(
                                              controller.isChapterLocked(
                                                moduleIndex,
                                                chapterIndex,
                                              )
                                                  ? skillBuddyTheme.grey
                                                  : skillBuddyTheme.graphite,
                                            )
                                                    .kParagraphSemiBold
                                                    .copyWith(fontSize: 18),
                                          ),
                                          const Gap(4),
                                          for (int lessonIndex = 0;
                                              lessonIndex <
                                                  controller
                                                      .modules[moduleIndex]
                                                      .chapters[chapterIndex]
                                                      .lessons
                                                      .length;
                                              lessonIndex++) ...<Widget>[
                                            ListTile(
                                              key: GlobalObjectKey(
                                                controller
                                                    .modules[moduleIndex]
                                                    .chapters[chapterIndex]
                                                    .lessons[lessonIndex]
                                                    .id,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              tileColor:
                                                  controller.isCurrentLesson(
                                                moduleIndex,
                                                chapterIndex,
                                                lessonIndex,
                                              )
                                                      ? skillBuddyTheme.electric
                                                      : null,
                                              leading: SvgPicture.asset(
                                                controller.isLessonLocked(
                                                  moduleIndex,
                                                  chapterIndex,
                                                  lessonIndex,
                                                )
                                                    ? 'asset/icons/locked_icon.svg'
                                                    : controller
                                                            .modules[
                                                                moduleIndex]
                                                            .chapters[
                                                                chapterIndex]
                                                            .lessons[
                                                                lessonIndex]
                                                            .isCompleted
                                                        ? 'asset/icons/done_checkmark.svg'
                                                        : 'asset/icons/current_checkmark.svg',
                                                height: 20,
                                              ),
                                              title: Text(
                                                controller
                                                    .modules[moduleIndex]
                                                    .chapters[chapterIndex]
                                                    .lessons[lessonIndex]
                                                    .name,
                                                style: SkillBuddyTypography
                                                        .fromColor(
                                                  controller.isChapterLocked(
                                                    moduleIndex,
                                                    chapterIndex,
                                                  )
                                                      ? skillBuddyTheme.grey
                                                      : controller
                                                              .isCurrentLesson(
                                                          moduleIndex,
                                                          chapterIndex,
                                                          lessonIndex,
                                                        )
                                                          ? Colors.white
                                                          : skillBuddyTheme
                                                              .graphite,
                                                )
                                                    .kParagraph
                                                    .copyWith(fontSize: 16),
                                              ),
                                              onTap: controller.isLessonLocked(
                                                moduleIndex,
                                                chapterIndex,
                                                lessonIndex,
                                              )
                                                  ? null
                                                  : () =>
                                                      controller.onLessonTap(
                                                        controller.modules[
                                                            moduleIndex],
                                                        controller
                                                                .modules[
                                                                    moduleIndex]
                                                                .chapters[
                                                            chapterIndex],
                                                        controller
                                                                .modules[
                                                                    moduleIndex]
                                                                .chapters[
                                                                    chapterIndex]
                                                                .lessons[
                                                            lessonIndex],
                                                      ),
                                            ),
                                            if (lessonIndex !=
                                                controller
                                                        .modules[moduleIndex]
                                                        .chapters[chapterIndex]
                                                        .lessons
                                                        .length -
                                                    1)
                                              Divider(
                                                color: skillBuddyTheme.grey,
                                                height: 8,
                                              ),
                                          ],
                                        ],
                                      ),
                                    ),
                                  ],
                                ],
                              ],
                            ),
                          ),
                          const Gap(20),
                        ],
                      ),
                    ),
                    Obx(
                      () => !controller.isEnrolled.value
                          ? Positioned.fill(
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: ElevatedButton(
                                    onPressed: controller.enrolling.value
                                        ? null
                                        : controller.onEnrollTap,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: skillBuddyTheme.electric,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: Text(
                                      'Enroll'.tr,
                                      style: SkillBuddyTypography.fromColor(
                                        skillBuddyTheme.linen,
                                      ).kParagraphSemiBold,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                    ),
                  ],
                )
              : const SizedBox(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
        ),
      ),
    );
  }
}
