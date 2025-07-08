import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../model/user_model.dart';
import '../../../util/util.dart';
import '../../token_list/token_list.dart';
import 'dashboard_card.dart';

class ProfileCards extends StatelessWidget {
  const ProfileCards({
    required this.user,
    required this.coursesEnrolled,
    required this.coursesCompleted,
    this.hideBottomCards = false,
    super.key,
  });

  final User user;
  final int coursesEnrolled;
  final int coursesCompleted;
  final bool hideBottomCards;

  @override
  Widget build(BuildContext context) {
    return hideBottomCards
        ? Column(
            children: <Widget>[
              const Gap(30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  DashBoardCard(
                    title:
                        '${user.dailyStreak} ${user.dailyStreak == 1 ? 'day' : 'days'}',
                    subtitle: 'current streak',
                    icon: 'asset/icons/calendar_icon.svg',
                  ),
                  Gap(getRelativeWidth(20)),
                  DashBoardCard(
                    title: user.xp.toString(),
                    subtitle: 'Total XP',
                    icon: 'asset/icons/token_icon.svg',
                  ),
                ],
              ),
            ],
          )
        : Column(
            children: <Widget>[
              const Gap(30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  DashBoardCard(
                    title:
                        '${user.dailyStreak} ${user.dailyStreak == 1 ? 'day' : 'days'}',
                    subtitle: 'current streak',
                    icon: 'asset/icons/calendar_icon.svg',
                  ),
                  // Gap(getRelativeWidth(20)),
                  GestureDetector(
                    onTap: () => Get.to<void>(() => const TokenListPage()),
                    child: DashBoardCard(
                      title: '${user.token} rewards',
                      subtitle: 'current amount',
                      icon: 'asset/icons/token_icon.svg',
                      clickable: true,
                    ),
                  ),
                ],
              ),
              // const Gap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  DashBoardCard(
                    title:
                        '$coursesEnrolled ${coursesEnrolled == 1 ? 'course' : 'courses'}',
                    subtitle: 'in progress',
                    icon: 'asset/icons/progress_icon.svg',
                  ),
                  // Gap(getRelativeWidth(20)),
                  DashBoardCard(
                    title:
                        '$coursesCompleted ${coursesCompleted == 1 ? 'course' : 'courses'}',
                    subtitle: 'completed',
                    icon: 'asset/icons/token_icon.svg',
                  ),
                ],
              ),
            ],
          );
  }
}
