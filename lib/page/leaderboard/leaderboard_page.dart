import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../model/leaderboard_model.dart';
import '../../model/user_model.dart';
import '../../service/theme_service.dart';
import '../../service/user_state_service.dart';
import '../../theme/theme.dart';
import '../../theme/typography.dart';
import '../../util/util.dart';
import '../friends/friends_list_page.dart';
import '../profile/widget/profile_header.dart';
import 'controller/leaderboard_controller.dart';
import 'widgets/days_weeks_months_row.dart';
import 'widgets/leaderboard_column.dart';
import 'widgets/leaderboard_row.dart';

class LeaderboardPage extends GetView<LeaderboardController> {
  const LeaderboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = ThemeService().theme;
    return RefreshIndicator(
      onRefresh: () => controller.refreshLeaderboard(),
      child: SingleChildScrollView(
        child: Obx(
          () {
            return Column(
              children: <Widget>[
                ProfileHeader(
                  editable: false,
                  showSettings: false,
                  showFriends: true,
                  userFriends:
                      Get.find<UserStateService>().user.value.following.length,
                  user: Get.find<UserStateService>().user.value,
                  onTapFriends: () => Get.to<void>(
                    () => const FriendsListPage(),
                  ),
                ),
                Gap(getRelativeHeight(32)),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: getRelativeWidth(15)),
                  child: const DaysWeeksMonthsRow(),
                ),
                Gap(getRelativeHeight(20)),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: getRelativeWidth(15)),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () => controller.changeLeaderboard(),
                      child: Text(
                        controller.selectedLeaderboard.value ==
                                LeaderboardType.global
                            ? 'Friends Leaderboard'.tr
                            : 'Global Leaderboard'.tr,
                        style: SkillBuddyTypography.fromColor(
                          theme.electric,
                        )
                            .kParagraph
                            .copyWith(decoration: TextDecoration.underline),
                      ),
                    ),
                  ),
                ),
                Gap(getRelativeHeight(20)),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: getRelativeWidth(15)),
                  child: controller.leaderboardList.isEmpty
                      ? Center(
                          child: controller.isLoading.value
                              ? SpinKitCircle(
                                  color: theme.electric,
                                  size: getRelativeWidth(64),
                                )
                              : Text(
                                  'No rank on this board yet'.tr,
                                ),
                        )
                      : DecoratedBox(
                          decoration: BoxDecoration(
                            color: theme.seashell,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: getRelativeWidth(20),
                              horizontal: getRelativeWidth(24),
                            ),
                            child: SizedBox(
                              width: double.infinity,
                              child: Stack(
                                alignment: Alignment.topCenter,
                                children: <Widget>[
                                  if (controller.leaderboardList.length > 1)
                                    Positioned(
                                      left: getRelativeWidth(10),
                                      bottom: getRelativeHeight(10),
                                      child: LeaderboardColumn(
                                        position: 2,
                                        name:
                                            controller.leaderboardList[1].user,
                                        xp: controller.leaderboardList[1].xp,
                                        avatar:
                                            controller.leaderboardList[1].photo,
                                        onTap: () => controller.goToFriend(
                                          User.fromJson(<String, dynamic>{
                                            'id': controller
                                                .leaderboardList[1].id,
                                            'name': controller
                                                .leaderboardList[1].user,
                                            'xp': controller
                                                .leaderboardList[1].xp,
                                            'avatar': controller
                                                .leaderboardList[1].photo,
                                            // 'follower': controller
                                            //     .leaderboardList[1].user.follower,
                                            // 'following': controller
                                            //     .leaderboardList[1]
                                            //     .user
                                            //     .following,
                                            'date_joined': controller
                                                .leaderboardList[1].dateJoined,
                                            'daily_streak': controller
                                                .leaderboardList[1].dailyStreak,
                                            'bio': controller
                                                .leaderboardList[1].bio,
                                          }),
                                        ),
                                      ),
                                    ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      bottom: getRelativeHeight(36),
                                    ),
                                    child: LeaderboardColumn(
                                      position: 1,
                                      name: controller.leaderboardList[0].user,
                                      xp: controller.leaderboardList[0].xp,
                                      avatar:
                                          controller.leaderboardList[0].photo,
                                      onTap: () => controller.goToFriend(
                                        User.fromJson(<String, dynamic>{
                                          'id':
                                              controller.leaderboardList[0].id,
                                          'name': controller
                                              .leaderboardList[0].user,
                                          'xp':
                                              controller.leaderboardList[0].xp,
                                          'avatar': controller
                                              .leaderboardList[0].photo,
                                          // 'follower': controller
                                          //     .leaderboardList[0].user.follower,
                                          // 'following': controller
                                          //     .leaderboardList[0].user.following,
                                          'date_joined': controller
                                              .leaderboardList[0].dateJoined,
                                          'daily_streak': controller
                                              .leaderboardList[0].dailyStreak,
                                          'bio':
                                              controller.leaderboardList[0].bio,
                                        }),
                                      ),
                                    ),
                                  ),
                                  if (controller.leaderboardList.length > 2)
                                    Positioned(
                                      right: getRelativeWidth(10),
                                      bottom: getRelativeHeight(10),
                                      child: LeaderboardColumn(
                                        position: 3,
                                        name:
                                            controller.leaderboardList[2].user,
                                        xp: controller.leaderboardList[2].xp,
                                        avatar:
                                            controller.leaderboardList[2].photo,
                                        onTap: () => controller.goToFriend(
                                          User.fromJson(<String, dynamic>{
                                            'id': controller
                                                .leaderboardList[2].id,
                                            'name': controller
                                                .leaderboardList[2].user,
                                            'xp': controller
                                                .leaderboardList[2].xp,
                                            'avatar': controller
                                                .leaderboardList[2].photo,
                                            // 'follower': controller
                                            //     .leaderboardList[2].user.follower,
                                            // 'following': controller
                                            //     .leaderboardList[2]
                                            //     .user
                                            //     .following,
                                            'date_joined': controller
                                                .leaderboardList[2].dateJoined,
                                            'daily_streak': controller
                                                .leaderboardList[2].dailyStreak,
                                            'bio': controller
                                                .leaderboardList[2].bio,
                                          }),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                ),
                Gap(getRelativeHeight(24)),
                if (controller.leaderboardList.isEmpty)
                  const SizedBox()
                else
                  controller.leaderboardList.length <= 3
                      ? SizedBox(
                          child: Center(
                            child: Text(
                              controller.selectedLeaderboard.value ==
                                      LeaderboardType.global
                                  ? 'No more accounts to show.'
                                  : 'No more friends to show.'.tr,
                            ),
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.leaderboardList.length - 3,
                          itemBuilder: (BuildContext context, int index) {
                            final LeaderboardEntry leaderboard =
                                controller.leaderboardList[index + 3];
                            return LeaderboardRow(
                              position: 4 + index,
                              // Assuming id represents position
                              name: leaderboard.user,
                              // dayStreak: leaderboard.user.dailyStreak,
                              xp: leaderboard.xp,
                              avatar: leaderboard.photo,
                              dayStreak: leaderboard.dailyStreak,
                              onTap: () => controller.goToFriend(
                                User.fromJson(<String, dynamic>{
                                  'name': leaderboard.user,
                                  // 'daily_streak': leaderboard.user.dailyStreak,
                                  'avatar': leaderboard.photo,
                                  'xp': leaderboard.xp,
                                  'id': leaderboard.id,
                                  // 'follower': leaderboard.user.follower,
                                  // 'following': leaderboard.user.following,
                                  'date_joined': leaderboard.dateJoined,
                                  'daily_streak': leaderboard.dailyStreak,
                                  'bio': leaderboard.bio,
                                }),
                              ),
                            );
                          },
                        ),
                Gap(getRelativeHeight(15)),
              ],
            );
          },
        ),
      ),
    );
  }
}
