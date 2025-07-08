import 'package:intl/intl.dart';

class User {
  User();

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int? ?? json['pk'] as int? ?? -1,
        email = json['email'] as String? ?? '',
        name = json['name'] as String? ?? '',
        bio = json['bio'] as String? ?? '',
        avatar = json['avatar'] as String? ?? '',
        areasOfInterest = json['areas_of_interest'] ?? <List<dynamic>>[],
        timeGrowingDaily = json['time_growing_daily'] as int? ?? 0,
        dailyStreak = json['daily_streak'] as int? ?? 0,
        xp = json['xp'] as int? ?? 0,
        dateJoined = _formatDate(json['date_joined'] as String?),
        follower = json['follower'] ?? <List<dynamic>>[],
        following = json['following'] ?? <List<dynamic>>[],
        level = json['level'] as int? ?? 0,
        token = json['satoshi_balance'] as int? ?? 0,
        isVerified = json['is_verified'] as bool? ?? false,
        isTenant = json['is_tenant'] as bool? ?? false,
        firebasePushNotificationToken =
            json['firebase_push_notification_token'] as String? ?? '';

  int id = -1;
  String email = '';
  String name = '';
  String bio = '';
  String avatar = '';
  List<dynamic> areasOfInterest = <List<dynamic>>[];
  int timeGrowingDaily = 0;
  int dailyStreak = 0;
  int xp = 0;
  String dateJoined = '01/01/1970';
  int token = 0;
  int level = 0;
  bool isTenant = false;
  bool isVerified = false;
  List<dynamic> follower = <List<dynamic>>[];
  List<dynamic> following = <List<dynamic>>[];
  String firebasePushNotificationToken = '';

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'email': email,
        'name': name,
        'bio': bio,
        'photo': avatar,
        'areas_of_interest': areasOfInterest,
        'time_growing_daily': timeGrowingDaily,
        'daily_streak': dailyStreak,
        'xp': xp,
        'date_joined': dateJoined,
        'satoshi_balance': token,
        'follower': follower,
        'following': following,
        'is_verified': isVerified,
        'level': level,
        'firebase_push_notification_token': firebasePushNotificationToken,
      };
  // Function to format date
  static String _formatDate(String? isoDate) {
    if (isoDate == null || isoDate.isEmpty) {
      return '01/01/1970'; // Return default if the date is null or empty
    }
    // Check if the isoDate is already in 'dd/MM/yyyy' format
    final RegExp dateFormatPattern = RegExp(r'^\d{2}/\d{2}/\d{4}$');
    if (dateFormatPattern.hasMatch(isoDate)) {
      return isoDate; // Return if it's already in 'dd/MM/yyyy' format
    }
    try {
      // Parse the ISO 8601 date string to a DateTime object
      final DateTime parsedDate = DateTime.parse(isoDate);
      // Format the date to 'dd/MM/yyyy'
      return DateFormat('dd/MM/yyyy').format(parsedDate);
    } catch (e) {
      return '01/01/1970'; // Fallback if the parsing fails
    }
  }
}
