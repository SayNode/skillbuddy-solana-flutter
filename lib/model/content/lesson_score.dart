class LessonScore {
  LessonScore();

  LessonScore.fromJson(Map<String, dynamic> json)
      : score = json['score'] ?? -1,
        xpCollected = json['xp'] ?? -1,
        lootBox = json['loot_box'] ?? <dynamic, dynamic>{},
        updatedHeartBalance = json['updated_heart_balance'] ?? -1,
        courseClaimable = json['course_claimable'] ?? false,
        rewardAmount = json['reward_amount'] ?? -1,
        rewardType = json['reward_type'] ?? '',
        courseId = json['course_id'] ?? -1,
        lessonPassed = json['lesson_passed'] ?? false,
        percentageCorrect = json['percentage_correct'] ?? -1;
  int score = -1;
  int xpCollected = -1;
  Map<dynamic, dynamic> lootBox = <dynamic, dynamic>{};
  int updatedHeartBalance = -1;
  bool courseClaimable = false;
  int rewardAmount = -1;
  String rewardType = '';
  int courseId = -1;
  bool lessonPassed = false;
  double percentageCorrect = -1;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'score': score,
        'xp_collected': xpCollected,
        'loot_box': lootBox,
        'updated_heart_balance': updatedHeartBalance,
        'course_claimable': courseClaimable,
        'reward_amount': rewardAmount,
        'reward_type': rewardType,
        'course_id': courseId,
        'lesson_passed': lessonPassed,
        'percentage_correct': percentageCorrect,
      };
}
