import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../page/explore_course/discover_courses_page.dart';
import '../../page/leaderboard/leaderboard_page.dart';
import '../../page/my_courses/my_courses_page.dart';
import '../../page/profile/profile_page.dart';

enum NavigationBarPage {
  home,
  book,
  crown,
  profile,
}

class SkillBuddyNavigationBarController extends GetxController {
  final RxInt selectedPageIndex = 0.obs;

  NavigationBarPage get selectedPage =>
      NavigationBarPage.values[selectedPageIndex.value];

  void changeIndex(NavigationBarPage page) {
    // Handle disposing the previous controller manually if needed
    final NavigationBarPage previousPage = selectedPage;

    // Change the index
    selectedPageIndex.value = page.index;

    // Delete previous controllers if necessary (optional depending on your design)
    if (previousPage == NavigationBarPage.crown) {
      // Get.delete<LeaderboardController>();
    } else if (previousPage == NavigationBarPage.book) {
      // Get.delete<MyCoursesController>();
    } else if (previousPage == NavigationBarPage.profile) {
      // Get.delete<ProfileController>();
    } else if (previousPage == NavigationBarPage.home) {
      //Get.delete<DiscoverCoursesController>();
    }
  }

  // This function will return the appropriate page with its controller initialized
  Widget getPageFor(NavigationBarPage page) {
    switch (page) {
      case NavigationBarPage.home:
        return const DiscoverCoursesPage();
      case NavigationBarPage.book:
        return const MyCoursesPage();
      case NavigationBarPage.crown:
        return const LeaderboardPage();
      case NavigationBarPage.profile:
        return const ProfilePage();
    }
  }
}
