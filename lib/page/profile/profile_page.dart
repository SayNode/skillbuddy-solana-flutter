import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../model/content/course.dart';
import '../../service/content_service.dart';
import '../../service/theme_service.dart';
import '../../service/user_state_service.dart';
import '../../theme/theme.dart';
import '../../theme/typography.dart';
import '../../util/util.dart';
// import '../friends/friends_list_page.dart';
import '../avatar/avatar_page.dart';
import '../friends/friends_list_page.dart';
import 'controller/profile_controller.dart';
import 'edit_bio_page.dart';
import 'edit_name_page.dart';
import 'widget/profile_cards.dart';
import 'widget/profile_course_card.dart';
import 'widget/profile_header.dart';
import 'widget/progress_bar.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomTheme skillBuddyTheme = ThemeService().theme;
    final ContentService contentService = Get.find<ContentService>();
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Obx(
            () => ProfileHeader(
              onTapName: (String name) => Get.to<void>(
                () => EditNamePage(name: name),
              ),
              showFriends: true,
              userFriends:
                  Get.find<UserStateService>().user.value.following.length,
              user: Get.find<UserStateService>().user.value,
              onTapImage: () => Get.to<void>(AvatarPage.new),
              onTapBio: (String userDescription) => Get.to<void>(
                () => EditBioPage(bio: userDescription),
              ),
              onTapFriends: () => Get.to<void>(
                () => const FriendsListPage(),
              ),
            ),
          ),
          Gap(getRelativeHeight(10)),
          Divider(
            color: skillBuddyTheme.seashell,
            thickness: 3,
          ),
          Obx(
            () => ProgressBar(
              level:
                  'Level ${Get.find<UserStateService>().user.value.xp ~/ 100 + 1}',
              xp: Get.find<UserStateService>().user.value.xp,
            ),
          ),
          Obx(
            () => ProfileCards(
              user: Get.find<UserStateService>().user.value,
              coursesEnrolled: contentService.myCourses.data.value
                  .where((Course course) => course.isCompleted == false)
                  .length,
              coursesCompleted: contentService.coursesCompleted(),
            ),
          ),
          Gap(getRelativeHeight(32)),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: getRelativeWidth(15)),
              child: Text(
                'Courses Enrolled'.tr,
                style: SkillBuddyTypography.fromColor(skillBuddyTheme.graphite)
                    .kTitle,
              ),
            ),
          ),
          Gap(getRelativeHeight(14)),
          Obx(
            () => controller.loading.value
                ? Center(
                    child: SpinKitCircle(
                      color: skillBuddyTheme.electric,
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: getRelativeWidth(15),
                    ),
                    key: UniqueKey(),
                    shrinkWrap: true,
                    physics: controller.seeMore.value
                        ? const BouncingScrollPhysics()
                        : const NeverScrollableScrollPhysics(),
                    itemCount: (controller.seeMore.value ||
                            contentService.myCourses.data.value.length < 4)
                        ? contentService.myCourses.data.value.length
                        : 4,
                    itemBuilder: (BuildContext context, int index) {
                      return ProfileCourseCard(
                        course: contentService.myCourses.data.value[index],
                        onTap: () => controller.goToCourseDetails(
                          contentService.myCourses.data.value[index],
                        ),
                      );
                    },
                  ),
          ),
          if (contentService.myCourses.data.value.length > 4)
            Center(
              child: TextButton(
                onPressed: () => controller.toggleSeeMore(),
                child: Obx(
                  () => Text(
                    controller.seeMore.value ? 'Show less'.tr : 'Show more'.tr,
                    style: SkillBuddyTypography.fromColor(
                      skillBuddyTheme.electric,
                    ).kParagraph,
                  ),
                ),
              ),
            )
          else
            const SizedBox(),
        ],
      ),
    );
  }
}
