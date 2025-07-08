class LeaderboardEntry {
  LeaderboardEntry();

  LeaderboardEntry.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? -1,
        rank = json['rank'] ?? -1,
        user = json['user'] ?? '',
        photo = json['avatar'] ?? '',
        xp = json['xp'] ?? 0,
        dateJoined = json['date_joined'] ?? '',
        bio = json['bio'] ?? '',
        dailyStreak = json['daily_streak'] ?? 0;

  int id = 0;
  int rank = 0;
  String user = '';
  int xp = 0;
  String photo = '';
  String dateJoined = '';
  String bio = '';
  int dailyStreak = 0;
}
