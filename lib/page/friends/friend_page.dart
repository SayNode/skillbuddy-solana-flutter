import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../model/user_model.dart';
import '../../service/theme_service.dart';
import '../../theme/theme.dart';
import '../../theme/typography.dart';
import '../../util/util.dart';
import '../../widget/skillbuddy_scaffold.dart';
import '../profile/widget/profile_cards.dart';
import '../profile/widget/profile_course_card.dart';
import '../profile/widget/profile_header.dart';
import '../profile/widget/progress_bar.dart';
import 'controller/friend_controller.dart';
import 'controller/friend_list_controller.dart';

class FriendPage extends GetView<FriendController> {
  const FriendPage({required this.user, super.key});

  final User user;

  @override
  Widget build(BuildContext context) {
    final CustomTheme skillBuddyTheme = ThemeService().theme;
    Get.put(FriendController(user: user));
    return PopScope(
      onPopInvokedWithResult: (bool didPop, dynamic result) =>
          Get.put(FriendListController()).refreshFriendsList(),
      child: SkillBuddyScaffold(
        backButton: true,
        title: '',
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Obx(
                () => ProfileHeader(
                  user: user,
                  showSettings: false,
                  editable: false,
                  buttonText: controller.isFollowing.value
                      ? 'Unfollow'.tr
                      : 'Follow'.tr,
                  onTapFollow: () => controller.toggleFollowers(user.id),
                ),
              ),
              Gap(getRelativeHeight(24)),
              Divider(
                color: skillBuddyTheme.seashell,
                thickness: 3,
              ),
              Obx(
                () => controller.isFollowing.value
                    ? ProgressBar(
                        // level: 'Level ${user.xp ~/ 100 + 1}',
                        xp: user.xp,
                      )
                    : const SizedBox(),
              ),
              Obx(
                () => ProfileCards(
                  user: user,
                  coursesEnrolled: controller.coursesEnrolled.length,
                  coursesCompleted: controller.coursesCompleted.value,
                  hideBottomCards: true,
                ),
              ),
              Gap(getRelativeHeight(32)),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: getRelativeWidth(15)),
                  child: Text(
                    'Courses Enrolled'.tr,
                    style:
                        SkillBuddyTypography.fromColor(skillBuddyTheme.graphite)
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
                        itemCount: controller.visibleList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ProfileCourseCard(
                            course: controller.visibleList[index],
                          );
                        },
                      ),
              ),
              if (controller.coursesEnrolled.length > 4)
                Center(
                  child: TextButton(
                    onPressed: () => controller.toggleSeeMore(),
                    child: Obx(
                      () => Text(
                        controller.seeMore.value
                            ? 'Show less'.tr
                            : 'Show more'.tr,
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
        ),
      ),
    );
  }
}
