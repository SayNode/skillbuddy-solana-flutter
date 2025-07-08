import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../service/content_service.dart';
import '../../service/theme_service.dart';
import '../../theme/theme.dart';
import '../../theme/typography.dart';
import '../../util/util.dart';
import '../../widget/controller/skillbody_navigation_bar_controller.dart';
import '../../widget/skillbuddy_button.dart';
import 'controller/my_courses_controller.dart';
import 'widget/my_course_card.dart';

class MyCoursesPage extends GetView<MyCoursesController> {
  const MyCoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.put(ThemeService()).theme;
    final MyCoursesController controller = Get.find<MyCoursesController>();
    final ContentService contentService = Get.find<ContentService>();
    // ignore: cascade_invocations
    controller.init();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getRelativeWidth(20)),
      child: Column(
        children: <Widget>[
          Gap(getRelativeHeight(36)),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'My courses'.tr,
              style: SkillBuddyTypography.fromColor(theme.graphite).kTitle,
              textAlign: TextAlign.left,
            ),
          ),
          Expanded(
            child: Obx(
              () => !contentService.myCourses.initialDataLoaded.value
                  ? Center(
                      child: SpinKitCircle(
                        color: theme.electric,
                      ),
                    )
                  : Obx(
                      () => contentService.myCourses.data.value.isEmpty
                          ? const EmptyMyCourses()
                          : const MyCourses(),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyCourses extends StatelessWidget {
  const MyCourses({super.key});

  @override
  Widget build(BuildContext context) {
    final MyCoursesController controller = Get.find<MyCoursesController>();
    final ContentService contentService = Get.find<ContentService>();
    return Column(
      children: <Widget>[
        Gap(getRelativeHeight(24)),
        Expanded(
          child: Obx(
            () {
              return ListView.separated(
                shrinkWrap: true,
                itemBuilder: (_, int i) => MyCourseCard(
                  course: contentService.myCourses.data.value[i],
                  progress: contentService.myCourses.data.value[i].progress,
                  onTap: () => controller.goToCourseDetails(
                    contentService.myCourses.data.value[i],
                  ),
                  onOptionsTap: () {},
                ),
                separatorBuilder: (_, int i) => Gap(getRelativeHeight(12)),
                itemCount: contentService.myCourses.data.value.length,
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: SkillBuddyButton(
            text: 'Search for more courses'.tr,
            onTap: () {
              Get.find<SkillBuddyNavigationBarController>()
                  .changeIndex(NavigationBarPage.home);
            },
          ),
        ),
      ],
    );
  }
}

class EmptyMyCourses extends StatelessWidget {
  const EmptyMyCourses({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.put(ThemeService()).theme;
    final MyCoursesController controller = Get.find<MyCoursesController>();
    return Column(
      children: <Widget>[
        const Spacer(),
        Text(
          'Your Courses Await'.tr,
          style: SkillBuddyTypography.fromColor(theme.graphite).kTitle,
          textAlign: TextAlign.left,
        ),
        Gap(getRelativeHeight(8)),
        Text(
          'Start learning today'.tr,
          style: SkillBuddyTypography.fromColor(theme.slate).kParagraph,
        ),
        Gap(getRelativeHeight(12)),
        Material(
          color: theme.seashell,
          shape: const CircleBorder(),
          child: InkWell(
            onTap: controller.addCourse,
            customBorder: const CircleBorder(),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Icon(Icons.add, color: theme.electric, size: 36),
              ),
            ),
          ),
        ),
        const Spacer(flex: 3),
      ],
    );
  }
}
