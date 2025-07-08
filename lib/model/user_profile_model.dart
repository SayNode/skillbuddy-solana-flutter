class UserProfile {
  UserProfile();

  UserProfile.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? -1,
        firstName = json['first_name'] ?? '',
        lastName = json['last_name'] ?? '',
        email = json['email'] ?? '',
        avatar = json['avatar'] ?? '',
        username = json['username'] ?? '',
        firstLogin = json['is_first_login'] ?? true,
        aboutMe = json['about_me'] ?? '',
        referralLink = json['personal_referral_code'] ?? '',
        isVerified = json['is_verified'] ?? false,
        joinedAt = returnShortDate(json['date_joined']),
        subscriptionGiftedBy = json['subscription_gifted_by'] ?? '';
  int id = -1;
  String email = '';
  String firstName = '';
  String lastName = '';
  String avatar = '';
  String username = '';
  bool firstLogin = true;
  String aboutMe = '';
  String joinedAt = '01.01.1990';
  String referralLink = '';
  bool isVerified = false;
  String subscriptionGiftedBy = '';

  static String returnShortDate(String? date) {
    if (date == null) {
      return '01.01.1990';
    } else {
      final DateTime? dateParsed = DateTime.tryParse(date);
      //debugPrint("DateParsed: " + dateParsed.toString());
      if (dateParsed != null) {
        return '${dateParsed.day}.${dateParsed.month}.${dateParsed.year}';
      } else {
        return '01.01.1990';
      }
    }
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'email': email,
        'first_name': firstName,
        'last_name': lastName,
        'avatar': avatar,
        'username': username,
        'firstLogin': firstLogin,
        'about_me': aboutMe,
        'date_joined': joinedAt,
        'is_verified': isVerified,
        'personal_referral_code': referralLink,
        'subscription_gifted_by': subscriptionGiftedBy,
      };
}
