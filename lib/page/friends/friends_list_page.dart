import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../model/user_model.dart';
import '../../service/theme_service.dart';
import '../../theme/theme.dart';
import '../../theme/typography.dart';
import '../../util/util.dart';
import '../../widget/skillbuddy_scaffold.dart';
import 'controller/friend_list_controller.dart';
import 'friend_page.dart';

class FriendsListPage extends GetView<FriendListController> {
  const FriendsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(FriendListController());
    final CustomTheme skillBuddyTheme = ThemeService().theme;
    return SkillBuddyScaffold(
      title: 'Friends'.tr,
      backButton: true,
      body: Column(
        children: <Widget>[
          const Gap(20),
          Obx(
            () => controller.friendsList.isEmpty
                ? Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: getRelativeWidth(20),
                      vertical: getRelativeHeight(30),
                    ),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: getRelativeWidth(60),
                          ),
                          child: Text(
                            'Looks like your friend list is empty'.tr,
                            style: SkillBuddyTypography.fromColor(
                              skillBuddyTheme.graphite,
                            ).kTitle,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            softWrap: true,
                          ),
                        ),
                        Gap(
                          getRelativeHeight(20),
                        ),
                        Text(
                          'Explore the leaderboard to make your first connections and start growing your network!'
                              .tr,
                          style: SkillBuddyTypography.fromColor(
                            skillBuddyTheme.graphite,
                          ).kParagraph,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          softWrap: true,
                        ),
                      ],
                    ),
                  )
                : SizedBox(
                    height: getRelativeHeight(400),
                    child: ListView.builder(
                      itemCount: controller.friendsList.length,
                      itemBuilder: (BuildContext context, int index) {
                        final Map<String, dynamic> friendData =
                            controller.friendsList[index];
                        return FriendsCard(
                          // isAFriend: friendData['isAFriend'] as bool,
                          name: friendData['name'] as String,
                          level: friendData['xp'].toString(),
                          image: (friendData['photo'] as String?) ?? '',
                          onTapArrow: () => Get.to<Widget>(
                            () => FriendPage(
                              user: User.fromJson(<String, dynamic>{
                                'name': friendData['name'],
                                'xp': (friendData['xp'] as int) * 100,
                                'photo': friendData['photo'],
                                'id': friendData['id'],
                                'bio': friendData['bio'],
                                'follower': friendData['follower'],
                                'following': friendData['following'],
                                'date_joined': friendData['date_joined'],
                                'daily_streak': friendData['daily_streak'],
                              }),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class FriendsCard extends StatelessWidget {
  const FriendsCard({
    // required this.isAFriend,
    required this.name,
    required this.level,
    required this.image,
    this.onTapConfirm,
    this.onTapDelete,
    this.onTapArrow,
    super.key,
  });

  // final bool isAFriend;
  final void Function()? onTapArrow;
  final void Function()? onTapConfirm;
  final void Function()? onTapDelete;
  final String name;
  final String level;
  final String image;

  @override
  Widget build(BuildContext context) {
    final CustomTheme skillBuddyTheme = ThemeService().theme;

    return InkWell(
      onTap: onTapArrow,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: getRelativeHeight(20),
          horizontal: getRelativeWidth(13),
        ),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              radius: 20,
              child: ClipOval(
                child: image.isEmpty
                    ? Image.asset('asset/images/avatar_default.png')
                    : Image.network(
                        image,
                        width: getRelativeWidth(40),
                        height: getRelativeHeight(40),
                        fit: BoxFit.cover,
                        errorBuilder: (
                          BuildContext context,
                          Object error,
                          StackTrace? stackTrace,
                        ) =>
                            Image.asset('asset/images/avatar_default.png'),
                      ),
              ),
            ),
            const Gap(20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  name,
                  style:
                      SkillBuddyTypography.fromColor(skillBuddyTheme.graphite)
                          .kInterSmall,
                ),
                Text(
                  '$level XP',
                  style: SkillBuddyTypography.fromColor(skillBuddyTheme.slate)
                      .kTextAdditional,
                ),
              ],
            ),
            const Spacer(),
            // if (isAFriend)
            const Row(
              children: <Widget>[
                Gap(200),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                ),
              ],
            ),
            // else
            //   Expanded(
            //     child: Row(
            //       children: <Widget>[
            //         Flexible(
            //           child: SkillBuddySmallButton(
            //             onTap: onTapConfirm ?? () {},
            //             text: 'Confirm'.tr,
            //           ),
            //         ),
            //         const Gap(10),
            //         Flexible(
            //           child: SkillBuddySmallButton(
            //             onTap: onTapDelete ?? () {},
            //             text: 'Delete'.tr,
            //             buttonColor: skillBuddyTheme.grey,
            //             textColor: skillBuddyTheme.graphite,
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }
}
