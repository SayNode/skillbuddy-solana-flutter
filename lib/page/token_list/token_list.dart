import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../service/theme_service.dart';
import '../../theme/theme.dart';
import '../../theme/typography.dart';
import '../../util/util.dart';
import '../../widget/skillbuddy_scaffold.dart';
import '../avatar/avatar_page.dart';
import '../friends/friends_list_page.dart';
import '../profile/edit_bio_page.dart';
import '../profile/widget/profile_header.dart';
import 'token_list_controller.dart';

class TokenListPage extends GetView<TokenListController> {
  const TokenListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Manually initialize the controller to avoid type issues
    final TokenListController controller = Get.find<TokenListController>();
    final CustomTheme skillBuddyTheme = ThemeService().theme;

    return SkillBuddyScaffold(
      body: Obx(
        () {
          return Column(
            children: <Widget>[
              ProfileHeader(
                backButton: true,
                showFriends: true,
                userFriends: controller.user.following.length,
                user: controller.user, // Pass the unwrapped user object
                onTapImage: () => Get.to<void>(AvatarPage.new),
                onTapBio: (String userDescription) => Get.to<void>(
                  () => EditBioPage(bio: userDescription),
                ),
                onTapFriends: () => Get.to<void>(
                  () => const FriendsListPage(),
                ),
              ),
              const Gap(32),
              Divider(
                color: skillBuddyTheme.seashell,
                thickness: 3,
              ),
              const Gap(16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: getRelativeWidth(16)),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: skillBuddyTheme.greyish,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: getRelativeHeight(10)),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'My balance'.tr,
                          style: SkillBuddyTypography.fromColor(
                            skillBuddyTheme.graphite,
                          ).kParagraphSemiBold,
                        ),
                        const Gap(2),
                        Text(
                          '${controller.user.token} Bonk',
                          style: SkillBuddyTypography.fromColor(
                            skillBuddyTheme.graphite,
                          ).kTitle,
                        ),
                        Gap(getRelativeHeight(2)),
                        Text(
                          '~\$${controller.bitcoinPriceInDollar.value.toStringAsFixed(2)}',
                          style: SkillBuddyTypography.fromColor(
                            skillBuddyTheme.graphite,
                          ).kTextAdditional,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Gap(getRelativeHeight(14)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: getRelativeWidth(16)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: InkWell(
                        onTap: controller.donatePage,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: skillBuddyTheme.seashell,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: getRelativeWidth(12),
                              vertical: getRelativeHeight(19),
                            ),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  'Donate'.tr,
                                  style: SkillBuddyTypography.fromColor(
                                    skillBuddyTheme.electric,
                                  ).kParagraphSemiBold,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Gap(getRelativeWidth(24)),
                    Expanded(
                      child: InkWell(
                        onTap: controller.withdraw,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: skillBuddyTheme.electric,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: getRelativeHeight(19),
                            ),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  'Withdraw'.tr,
                                  style: SkillBuddyTypography.fromColor(
                                    skillBuddyTheme.linen,
                                  ).kParagraphSemiBold,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
