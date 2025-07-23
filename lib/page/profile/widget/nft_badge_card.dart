import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../service/theme_service.dart';
import '../../../theme/theme.dart';
import '../../../theme/typography.dart';
import '../../../util/util.dart';

enum NftBadgeStatus { locked, unlocked, redeemed }

class NftBadgeCard extends StatelessWidget {
  const NftBadgeCard({
    required this.firstNftBadgeStatus,
    required this.secondNftBadgeStatus,
    super.key,
  });
  final NftBadgeStatus firstNftBadgeStatus;
  final NftBadgeStatus secondNftBadgeStatus;
  @override
  Widget build(BuildContext context) {
    final CustomTheme skillBuddyTheme = ThemeService().theme;
    // final List<Widget> cards = <Widget>[
    //   DashBoardCard(
    //     title: 'Finish 2 Solana related courses'.tr,
    //     subtitle: firstNftBadgeStatus == NftBadgeStatus.locked
    //         ? 'locked'.tr
    //         : firstNftBadgeStatus == NftBadgeStatus.unlocked
    //             ? 'redeem new'.tr
    //             : 'redeemed'.tr,
    //     subtitleTextColor: firstNftBadgeStatus == NftBadgeStatus.locked
    //         ? skillBuddyTheme.red
    //         : firstNftBadgeStatus == NftBadgeStatus.unlocked
    //             ? skillBuddyTheme.green
    //             : skillBuddyTheme.slate,
    //     icon: 'asset/icons/progress_icon.svg',
    //   ),
    //   DashBoardCard(
    //     title: 'Finish 2 Solana related courses'.tr,
    //     subtitle: secondNftBadgeStatus == NftBadgeStatus.locked
    //         ? 'locked'.tr
    //         : secondNftBadgeStatus == NftBadgeStatus.unlocked
    //             ? 'redeem new'.tr
    //             : 'redeemed'.tr,
    //     subtitleTextColor: secondNftBadgeStatus == NftBadgeStatus.locked
    //         ? skillBuddyTheme.red
    //         : secondNftBadgeStatus == NftBadgeStatus.unlocked
    //             ? skillBuddyTheme.green
    //             : skillBuddyTheme.slate,
    //     icon: 'asset/icons/token_icon.svg',
    //   ),
    // ];

    return Padding(
      padding: EdgeInsets.only(
        left: getRelativeWidth(15),
        right: getRelativeWidth(15),
        top: getRelativeHeight(20),
      ),
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'NFT Badges'.tr,
              style: SkillBuddyTypography.fromColor(skillBuddyTheme.graphite)
                  .kTitle,
            ),
          ),
          Gap(getRelativeHeight(10)),
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 5,
              crossAxisSpacing: 16,
              childAspectRatio: 2.5,
            ),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 2,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: EdgeInsets.symmetric(
                  vertical: getRelativeHeight(8),
                  horizontal: getRelativeWidth(10),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: skillBuddyTheme.grey,
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    SvgPicture.asset(
                      index == 0
                          ? 'asset/icons/progress_icon.svg'
                          : 'asset/icons/token_icon.svg',
                    ),
                    Gap(getRelativeWidth(10)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            index == 0
                                ? 'Finish 2 Solana related courses'.tr
                                : 'Finish 2 Solana related courses'.tr,
                            style: SkillBuddyTypography.fromColor(
                              skillBuddyTheme.graphite,
                            ).kParagraphSemiBold,
                          ),
                          Text(
                            index == 0
                                ? firstNftBadgeStatus == NftBadgeStatus.locked
                                    ? 'locked'.tr
                                    : firstNftBadgeStatus ==
                                            NftBadgeStatus.unlocked
                                        ? 'redeem new'.tr
                                        : 'redeemed'.tr
                                : secondNftBadgeStatus == NftBadgeStatus.locked
                                    ? 'locked'.tr
                                    : secondNftBadgeStatus ==
                                            NftBadgeStatus.unlocked
                                        ? 'redeem new'.tr
                                        : 'redeemed'.tr,
                            style: SkillBuddyTypography.fromColor(
                              index == 0
                                  ? firstNftBadgeStatus == NftBadgeStatus.locked
                                      ? skillBuddyTheme.red
                                      : firstNftBadgeStatus ==
                                              NftBadgeStatus.unlocked
                                          ? skillBuddyTheme.green
                                          : skillBuddyTheme.slate
                                  : secondNftBadgeStatus ==
                                          NftBadgeStatus.locked
                                      ? skillBuddyTheme.red
                                      : secondNftBadgeStatus ==
                                              NftBadgeStatus.unlocked
                                          ? skillBuddyTheme.green
                                          : skillBuddyTheme.slate,
                            ).kTextAdditional,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
