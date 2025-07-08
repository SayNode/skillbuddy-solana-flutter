import 'package:get/get.dart';

import '../../../model/leaderboard_model.dart';
import '../../../model/user_model.dart';
import '../../../service/leaderboard_service.dart';
import '../../../service/logger_service.dart';
import '../../../service/user_state_service.dart';
import '../../../util/util.dart';
import '../../../widget/controller/skillbody_navigation_bar_controller.dart';
import '../../friends/friend_page.dart';

enum DurationType { day, week, month }

enum LeaderboardType {
  friends,
  global,
}

class LeaderboardController extends GetxController {
  final Rx<DurationType> selectedDuration = DurationType.day.obs;
  final Rx<LeaderboardType> selectedLeaderboard = LeaderboardType.global.obs;
  RxList<LeaderboardEntry> leaderboardList = <LeaderboardEntry>[].obs;
  RxList<LeaderboardEntry> leaderboardListDaily = <LeaderboardEntry>[].obs;
  RxList<LeaderboardEntry> leaderboardListWeekly = <LeaderboardEntry>[].obs;
  RxList<LeaderboardEntry> leaderboardListMonthly = <LeaderboardEntry>[].obs;

  final LeaderBoardService leaderBoardService = Get.put(LeaderBoardService());
  final UserStateService loggedInUser = Get.find<UserStateService>();

  RxBool isLoading = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await checkUserName();
    await getLeaderboardLists(selectedLeaderboard.value);
  }

  Future<void> refreshLeaderboard() async {
    await getLeaderboardLists(selectedLeaderboard.value);
  }

  Future<void> getLeaderboardLists(LeaderboardType type) async {
    isLoading.value = true;
    try {
      changeDuration(DurationType.day);

      final Map<String, List<LeaderboardEntry>> leaderboards =
          await leaderBoardService.getLeaderBoardList(type.name.toLowerCase());

      leaderboardListDaily.value =
          leaderboards['daily'] ?? <LeaderboardEntry>[];
      leaderboardListWeekly.value =
          leaderboards['weekly'] ?? <LeaderboardEntry>[];
      leaderboardListMonthly.value =
          leaderboards['monthly'] ?? <LeaderboardEntry>[];
      leaderboardList.value = leaderboardListDaily;
      isLoading.value = false;
    } catch (e) {
      Get.find<LoggerService>().log('Error getting leaderboard data: $e');
      rethrow;
    }
  }

  void goToFriend(User user) {
    if (user.id == loggedInUser.user.value.id) {
      Get.find<SkillBuddyNavigationBarController>()
          .changeIndex(NavigationBarPage.profile);
      return;
    }
    Get.to<void>(
      () => FriendPage(user: user),
    );
  }

  void changeLeaderboard() {
    leaderboardList
      ..value = <LeaderboardEntry>[]
      ..refresh();
    if (selectedLeaderboard.value == LeaderboardType.global) {
      selectedLeaderboard.value = LeaderboardType.friends;

      getLeaderboardLists(LeaderboardType.friends);
    } else {
      selectedLeaderboard.value = LeaderboardType.global;
      getLeaderboardLists(LeaderboardType.global);
    }
  }

  void changeDuration(DurationType duration) {
    selectedDuration.value = duration;
    switch (duration) {
      case DurationType.day:
        selectedDuration.value = DurationType.day;
        leaderboardList.value = leaderboardListDaily;
      case DurationType.week:
        selectedDuration.value = DurationType.week;
        leaderboardList.value = leaderboardListWeekly;
      case DurationType.month:
        selectedDuration.value = DurationType.month;
        leaderboardList.value = leaderboardListMonthly;
    }
  }
}
