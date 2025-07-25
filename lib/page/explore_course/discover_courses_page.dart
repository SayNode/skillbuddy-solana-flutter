import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../model/content/course.dart';
import '../../model/user_model.dart';
import '../../service/interest_service.dart';
import '../../service/storage/shared_storage_service.dart';
import '../../service/storage/storage_service.dart';
import '../../service/theme_service.dart';
import '../../service/user_state_service.dart';
import '../../theme/theme.dart';
import '../../theme/typography.dart';
import '../../util/util.dart';
import '../../widget/skillbuddy_chip.dart';
import '../settings/settings.dart';
import 'controller/discover_courses_controller.dart';
import 'widget/check_out_rewards.dart';
import 'widget/course_card.dart';
import 'widget/search_widget.dart';

class DiscoverCoursesPage extends GetView<DiscoverCoursesController> {
  const DiscoverCoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = ThemeService().theme;
    final User user = Get.find<UserStateService>().user.value;
    final SharedStorageService sharedStorage =
        Get.find<StorageService>().shared;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(getRelativeWidth(16)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: AutoSizeText(
                    controller.greetingMessage,
                    style: SkillBuddyTypography.fromColor(
                      theme.graphite,
                    ).kTitle,
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.to<Widget>(
                    () => const SettingsPage(),
                    transition: Transition.upToDown,
                  ),
                  child: SvgPicture.asset(
                    'asset/icons/settings_icon.svg',
                    colorFilter:
                        ColorFilter.mode(theme.graphite, BlendMode.srcIn),
                  ),
                ),
              ],
            ),
          ),
          if (sharedStorage.readInt('showBonkBanner') == null ||
              sharedStorage.readInt('showBonkBanner') == 1)
            const CheckOutRewards(),
          SearchWidget(onChanged: controller.updateSearchText),
          const Gap(5),
          Obx(
            () => SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  Gap(getRelativeWidth(12)),
                  for (int i = 0;
                      i < controller.areaOfInterestChips.length;
                      i++)
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: getRelativeWidth(3),
                      ),
                      child: Obx(
                        () => SkillBuddyChip(
                          borderRadius: 12,
                          onTap: controller.loading.value
                              ? null
                              : () async => controller.selectAreaOfInterest(i),
                          selected: controller.coursesIndex == i,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              controller.areaOfInterestChips[i],
                              style: SkillBuddyTypography.fromColor(
                                theme.graphite,
                              ).kParagraph,
                            ),
                          ),
                        ),
                      ),
                    ),
                  Gap(getRelativeWidth(15)),
                ],
              ),
            ),
          ),
          Obx(
            () => controller.lastVisitedCourse.value != null &&
                    controller.lastVisitedLesson.value != null &&
                    controller.lastVisitedCourse.value!.progress < 100
                ? Padding(
                    padding: EdgeInsets.fromLTRB(
                      getRelativeWidth(12),
                      16,
                      getRelativeWidth(12),
                      0,
                    ),
                    child: Material(
                      borderRadius: BorderRadius.circular(16),
                      color: theme.seashell,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () => controller.goToCourseDetails(
                          controller.lastVisitedCourse.value!,
                          controller.lastVisitedLesson.value,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(
                                    'Current course'.tr,
                                    style: SkillBuddyTypography.fromColor(
                                      theme.slate,
                                    ).kTextAdditional,
                                  ),
                                  const Spacer(),
                                  SvgPicture.asset(
                                    'asset/icons/continue.svg',
                                    colorFilter: ColorFilter.mode(
                                      theme.electric,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ],
                              ),
                              const Gap(2),
                              RichText(
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'Continue learning: '.tr,
                                      style: SkillBuddyTypography.fromColor(
                                        theme.graphite,
                                      ).kParagraphSemiBold,
                                    ),
                                    TextSpan(
                                      text: controller
                                          .lastVisitedCourse.value!.name,
                                      style: SkillBuddyTypography.fromColor(
                                        theme.graphite,
                                      ).kParagraph,
                                    ),
                                  ],
                                ),
                              ),
                              const Gap(15),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: LinearProgressIndicator(
                                      value: controller.lastVisitedCourse.value!
                                              .progress /
                                          100,
                                      backgroundColor: theme.linen,
                                      color: theme.electric,
                                      minHeight: 9,
                                      borderRadius: BorderRadius.circular(8),
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        theme.electric,
                                      ),
                                    ),
                                  ),
                                  Gap(getRelativeHeight(12)),
                                  Text(
                                    '${controller.lastVisitedCourse.value!.progress.round()}%',
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
                      ),
                    ),
                  )
                : Container(),
          ),
          Obx(
            () => Padding(
              padding: EdgeInsets.only(left: getRelativeWidth(15), top: 20),
              child: Text(
                controller.searchText.value.isEmpty
                    ? 'Suggestions'.tr
                    : 'Search filter'.tr,
                style: SkillBuddyTypography.fromColor(
                  theme.graphite,
                ).kParagraphSemiBold,
              ),
            ),
          ),
          Gap(getRelativeHeight(5)),
          Obx(() {
            // Show a loading spinner while data is loading
            if (controller.loading.value) {
              return Center(
                child: SpinKitCircle(
                  color: theme.electric,
                ),
              );
            }

            // Combine all filtered courses (from different areas) into a single list.
            final List<Course> searchResults = controller.filteredCourses.values
                .expand((List<Course> courses) => courses)
                .toList();

            // Check if there’s a search query entered and if no courses match the search, you can display a message (optional)
            if (controller.searchText.value.trim().isNotEmpty &&
                searchResults.isEmpty) {
              return Center(
                child: Text(
                  'No courses found'.tr,
                  style: SkillBuddyTypography.fromColor(
                    theme.graphite,
                  ).kParagraph,
                ),
              );
            }

            // Display the filtered (searched) courses in a horizontal list
            return IntrinsicHeight(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  left: getRelativeWidth(10),
                  right: getRelativeWidth(10),
                  bottom: getRelativeHeight(8),
                ),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    for (int i = 0; i < searchResults.length; i++) ...<Widget>[
                      CourseCard(
                        course: searchResults[i],
                        onTap: () =>
                            controller.goToCourseDetails(searchResults[i]),
                      ),
                      if (i != searchResults.length - 1) const Gap(20),
                    ],
                  ],
                ),
              ),
            );
          }),
          const Gap(10),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getRelativeWidth(10),
              vertical: getRelativeHeight(5),
            ),
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: theme.seashell,
              ),
              child: ListTile(
                leading: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    SvgPicture.asset(
                      'asset/icons/Union.svg',
                      height: getRelativeHeight(25),
                      width: getRelativeWidth(20),
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: getRelativeHeight(2),
                      ),
                      child: Text(
                        user.dailyStreak.toString(),
                        style: SkillBuddyTypography.fromColor(
                          theme.graphite,
                        ).kParagraphSemiBold,
                      ),
                    ),
                  ],
                ),
                title: Text(
                  'Your current streak'.tr,
                  style: SkillBuddyTypography.fromColor(
                    theme.graphite,
                  ).kParagraph,
                ),
                trailing: Text(
                  ''.tr,
                  style: SkillBuddyTypography.fromColor(
                    theme.graphite,
                  ).kTextAdditional,
                ),
              ),
            ),
          ),
          Obx(
            () => controller.loading.value
                ? Padding(
                    padding: EdgeInsets.only(top: getRelativeHeight(24)),
                    child: Center(
                      child: Center(
                        child: SpinKitCircle(
                          color: theme.electric,
                        ),
                      ),
                    ),
                  )
                : Obx(
                    () {
                      if (controller.loading.value) {
                        return Padding(
                          padding: EdgeInsets.only(top: getRelativeHeight(24)),
                          child: Center(
                            child: SpinKitCircle(
                              color: theme.electric,
                            ),
                          ),
                        );
                      } else {
                        if (controller.searchText.value.isNotEmpty) {
                          return Container();
                        }
                        // Use filteredCourses if not empty, else use allCourses
                        final Iterable<MapEntry<AreaOfInterest, List<Course>>>
                            coursesToDisplay =
                            controller.filteredCourses.isNotEmpty
                                ? controller.filteredCourses.entries
                                : controller.allCourses.entries;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            for (final MapEntry<AreaOfInterest,
                                List<Course>> entry in coursesToDisplay)
                              (entry.value.isEmpty ||
                                      entry.key.title == 'Bitcoin (BTC)')
                                  ? const SizedBox()
                                  : Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Gap(getRelativeHeight(20)),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            bottom: getRelativeHeight(5),
                                            left: getRelativeWidth(15),
                                          ),
                                          child: Text(
                                            entry.key.title,
                                            style:
                                                SkillBuddyTypography.fromColor(
                                              theme.graphite,
                                            ).kParagraphSemiBold,
                                          ),
                                        ),
                                        IntrinsicHeight(
                                          child: SingleChildScrollView(
                                            padding: EdgeInsets.only(
                                              left: getRelativeWidth(10),
                                              right: getRelativeWidth(10),
                                              bottom: getRelativeHeight(8),
                                            ),
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              children: <Widget>[
                                                for (int i = 0;
                                                    i < entry.value.length;
                                                    i++) ...<Widget>[
                                                  CourseCard(
                                                    isSolanaCourse:
                                                        entry.key.title ==
                                                            'Solana',
                                                    course: entry.value[i],
                                                    onTap: () => controller
                                                        .goToCourseDetails(
                                                      entry.value[i],
                                                    ),
                                                  ),
                                                  if (i !=
                                                      entry.value.length - 1)
                                                    const Gap(20),
                                                ],
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                          ],
                        );
                      }
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
