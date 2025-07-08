import 'package:get/get.dart';

import '../model/leaderboard_model.dart';
import 'api_service.dart';
import 'logger_service.dart';
import 'user_state_service.dart';

class LeaderBoardService {
  final UserStateService loggedInUser = Get.find<UserStateService>();

  Future<Map<String, List<LeaderboardEntry>>> getLeaderBoardList(
    String leaderBoardType,
  ) async {
    final ApiResponse response = await Get.find<APIService>()
        .get('/users/leaderboard/$leaderBoardType/allboards/');
    if (response.success && response.result != null) {
      if (response.result is Map<String, dynamic>) {
        // This is the raw leaderboard data that comes from the backend
        final Map<String, dynamic> leaderboardData = response.result!;

        // This is the map that is going to be returned
        final Map<String, List<LeaderboardEntry>> ret =
            <String, List<LeaderboardEntry>>{};

        // Deal with the daily leaderboard data:
        final Map<String, dynamic> dailyData = leaderboardData['daily'];
        final LeaderboardEntry userRankDataDay = LeaderboardEntry.fromJson(
          dailyData['user'] as Map<String, dynamic>,
        )
          ..user = loggedInUser.user.value.name
          ..photo = loggedInUser.user.value.avatar;
        ret['daily'] = (dailyData['leaderboard'] as List<dynamic>)
            .map(
              (dynamic item) =>
                  LeaderboardEntry.fromJson(item as Map<String, dynamic>),
            )
            .toList();
        if (userRankDataDay.rank != -1) {
          // Add login user if it's not in the list yet
          ret['daily']!
            ..addIf(
              !ret['daily']!.any(
                (LeaderboardEntry element) => element.id == userRankDataDay.id,
              ),
              userRankDataDay,
            )
            ..sort(
              (LeaderboardEntry a, LeaderboardEntry b) =>
                  a.rank.compareTo(b.rank),
            );
        }

        // Deal with the weekly leaderboard data:
        final Map<String, dynamic> weeklyData = leaderboardData['weekly'];
        final LeaderboardEntry userRankDataWeek = LeaderboardEntry.fromJson(
          weeklyData['user'] as Map<String, dynamic>,
        )
          ..user = loggedInUser.user.value.name
          ..photo = loggedInUser.user.value.avatar;
        ret['weekly'] = (weeklyData['leaderboard'] as List<dynamic>)
            .map(
              (dynamic item) =>
                  LeaderboardEntry.fromJson(item as Map<String, dynamic>),
            )
            .toList();
        if (userRankDataWeek.rank != -1) {
          // Add login user if it's not in the list yet
          ret['weekly']!
            ..addIf(
              !ret['weekly']!.any(
                (LeaderboardEntry element) => element.id == userRankDataWeek.id,
              ),
              userRankDataWeek,
            )
            ..sort(
              (LeaderboardEntry a, LeaderboardEntry b) =>
                  a.rank.compareTo(b.rank),
            );
        }

        // Deal with the monthly leaderboard data:
        final Map<String, dynamic> monthlyData = leaderboardData['monthly'];
        final LeaderboardEntry userRankDataMonth = LeaderboardEntry.fromJson(
          monthlyData['user'] as Map<String, dynamic>,
        )
          ..user = loggedInUser.user.value.name
          ..photo = loggedInUser.user.value.avatar;
        ret['monthly'] = (monthlyData['leaderboard'] as List<dynamic>)
            .map(
              (dynamic item) =>
                  LeaderboardEntry.fromJson(item as Map<String, dynamic>),
            )
            .toList();
        if (userRankDataMonth.rank != -1) {
          // Add login user if it's not in the list yet
          ret['monthly']!
            ..addIf(
              !ret['monthly']!.any(
                (LeaderboardEntry element) =>
                    element.id == userRankDataMonth.id,
              ),
              userRankDataMonth,
            )
            ..sort(
              (LeaderboardEntry a, LeaderboardEntry b) =>
                  a.rank.compareTo(b.rank),
            );
        }

        return ret;
      }
    } else {
      LoggerService().log('Failed to get leaderboard: ${response.message}');
    }
    return <String, List<LeaderboardEntry>>{};
  }
}
