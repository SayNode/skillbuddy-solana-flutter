class Company {
  Company();
  Company.fromJson(Map<String, dynamic> json)
      : name = json['name'] ?? '',
        logo = json['logo'] ?? '',
        description = json['description'] ?? '',
        discord = json['discord'] ?? '',
        website = json['website'] ?? '',
        twitter = json['twitter'] ?? '',
        coursesByCompany =
            List<String>.from(json['courses_by_company'] ?? <String>[]);
  String name = '';
  String logo = '';
  String description = '';
  String discord = '';
  String website = '';
  String twitter = '';
  List<String> coursesByCompany = <String>[];

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'logo': logo,
        'description': description,
        'discord': discord,
        'website': website,
        'twitter': twitter,
        'courses_by_company': coursesByCompany,
      };
}

class Course {
  Course();

  Course.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? -1,
        name = json['name'] ?? '',
        company = Company.fromJson(json['company'] ?? <String, dynamic>{}),
        description = json['description'] ?? '',
        rewardAmount = json['reward_amount'] ?? 0,
        rewardType = json['reward_type'] ?? '',
        image = json['image'] ?? '',
        progress = json['progress'] ?? 0.0,
        isFavorite = json['is_favorite'] ?? false,
        enrolledUsers = json['enrolled_users'] ?? 0,
        isFirstTime = json['is_first_time'] ?? true,
        isCompleted = json['is_completed'] ?? false,
        areaOfInterestList =
            List<String>.from(json['areas_of_interest'] ?? <String>[]),
        activated = json['activated'] ?? false;

  int id = -1;
  String name = '';
  Company company = Company();
  String description = '';
  int rewardAmount = 0;
  String rewardType = '';
  String image = '';
  double progress = 0;
  bool isFavorite = false;
  int enrolledUsers = 0;
  bool isFirstTime = true;
  bool isCompleted = false;
  bool activated = false;
  List<String> areaOfInterestList = <String>[];

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'company': company.toJson(),
        'description': description,
        'reward_amount': rewardAmount,
        'reward_type': rewardType,
        'image': image,
        'progress': progress,
        'is_favorite': isFavorite,
        'enrolled_users': enrolledUsers,
        'is_first_time': isFirstTime,
        'is_completed': isCompleted,
        'activated': activated,
      };
}

class NextStep {
  NextStep();

  NextStep.fromJson(Map<String, dynamic> json)
      : message = json['course_message'] ?? '',
        link = json['course_link'] ?? '';

  String message = '';
  String link = '';
}
