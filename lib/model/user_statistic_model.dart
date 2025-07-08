import 'statistic_progress_model.dart';

class UserStatistic {
  UserStatistic();

  UserStatistic.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? -1,
        totalXp = json['total_xp'] ?? -1,
        totalSats = json['total_sats'] ?? -1,
        hearts = json['heart'] ?? -1,
        dayStreak = json['day_streak'] ?? -1,
        level = json['level'] ?? -1,
        levelPercentage = (double.tryParse(json['level_percentage'])) ?? -1,
        progress = createStatisticProgressList(json),
        createdAt =
            DateTime.tryParse(json['created_at']) ?? DateTime.parse('19900101'),
        updatedAt =
            DateTime.tryParse(json['updated_at']) ?? DateTime.parse('19900101'),
        lastCategoryId = json['current_category'] ?? -1,
        user = json['user'] ?? 0;
  int id = -1;
  int totalXp = -1;
  int totalSats = -1;
  int hearts = -1;
  int dayStreak = -1;
  List<StatisticProgress> progress = <StatisticProgress>[];
  DateTime createdAt = DateTime.parse('19900101');
  DateTime updatedAt = DateTime.parse('19900101');
  int user = -1;
  int level = -1;
  int lastCategoryId = -1;
  double levelPercentage = -1;

  static List<StatisticProgress> createStatisticProgressList(
    Map<String, dynamic> json,
  ) {
    if (json['progress'] == null) {
      return <StatisticProgress>[];
    } else {
      final List<dynamic> untypedList = json['progress'];
      final List<StatisticProgress> statisticProgressList =
          <StatisticProgress>[];
      for (int i = 0; i < untypedList.length; i++) {
        final StatisticProgress statisticProgress =
            StatisticProgress.fromJson(untypedList[i]);
        statisticProgressList.add(statisticProgress);
      }
      return statisticProgressList;
    }
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'total_xp': totalXp,
        'total_sats': totalSats,
        'heart': hearts,
        'day_streak': dayStreak,
        'progress': progress,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'current_category': lastCategoryId,
        'user': user,
      };
}
