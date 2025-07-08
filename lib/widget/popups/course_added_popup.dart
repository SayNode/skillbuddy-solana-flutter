import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../page/my_courses/controller/my_courses_controller.dart';
import '../../service/theme_service.dart';
import '../../theme/theme.dart';
import '../../theme/typography.dart';
import '../../util/util.dart';
import '../controller/skillbody_navigation_bar_controller.dart';
import '../skillbuddy_button.dart';

class CourseAddedPopup extends StatelessWidget {
  const CourseAddedPopup({required this.courseId, super.key});
  final int courseId;

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = ThemeService().theme;

    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
        child: Column(
          children: <Widget>[
            Text(
              'Successfully added!'.tr,
              style: SkillBuddyTypography.fromColor(theme.graphite).kTitle,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: getRelativeHeight(12)),
            Text(
              'Your course has been successfully added to your account. We are excited to have you on this learning journey.'
                  .tr,
              style: SkillBuddyTypography.fromColor(theme.graphite).kParagraph,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: getRelativeHeight(12)),
            SkillBuddyButton(
              text: 'Start course'.tr,
              onTap: () {
                Get.find<SkillBuddyNavigationBarController>().changeIndex(
                  NavigationBarPage.book,
                );
                Get.find<MyCoursesController>().courseToOpenId = courseId;
                Get.close(1);
              },
            ),
          ],
        ),
      ),
    );
  }
}
