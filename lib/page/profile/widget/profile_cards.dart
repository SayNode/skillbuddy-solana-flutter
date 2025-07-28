import 'package:flutter/material.dart';
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
    final List<Widget> cards = hideBottomCards
        ? <Widget>[
            DashBoardCard(
              title:
                  '${user.dailyStreak} ${user.dailyStreak == 1 ? 'day' : 'days'}',
              subtitle: 'current streak',
              icon: 'asset/icons/calendar_icon.svg',
            ),
            DashBoardCard(
              title: user.xp.toString(),
              subtitle: 'Total XP',
              icon: 'asset/icons/token_icon.svg',
            ),
          ]
        : <Widget>[
            DashBoardCard(
              title:
                  '${user.dailyStreak} ${user.dailyStreak == 1 ? 'day' : 'days'}',
              subtitle: 'current streak',
              icon: 'asset/icons/calendar_icon.svg',
            ),
            GestureDetector(
              onTap: () => Get.to<void>(() => const TokenListPage()),
              child: DashBoardCard(
                title: '${user.token} rewards',
                subtitle: 'current amount',
                icon: 'asset/icons/token_icon.svg',
                clickable: true,
              ),
            ),
            DashBoardCard(
              title:
                  '$coursesEnrolled ${coursesEnrolled == 1 ? 'course' : 'courses'}',
              subtitle: 'in progress',
              icon: 'asset/icons/progress_icon.svg',
            ),
            DashBoardCard(
              title:
                  '$coursesCompleted ${coursesCompleted == 1 ? 'course' : 'courses'}',
              subtitle: 'completed',
              icon: 'asset/icons/token_icon.svg',
            ),
          ];

    return Padding(
      padding: EdgeInsets.only(
        left: getRelativeWidth(15),
        right: getRelativeWidth(15),
        top: getRelativeHeight(30),
      ),
      child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 2,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        childAspectRatio: 2.5,
        physics: const NeverScrollableScrollPhysics(),
        children: cards,
      ),
    );
  }
}
