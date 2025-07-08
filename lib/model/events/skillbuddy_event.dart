import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';

class EventParameterId {
  static const String userId = 'user_id';
  static const String username = 'username';
  static const String userEmail = 'user_email';
  static const String userAuthenticationMethod = 'user_authentication_method';
}

class GoogleEventToken {
  static const String firstOpen = 'first_open';
  static const String sessionStart = 'session_start';
  static const String accountCreation = 'account_creation';
  static const String accountLogin = 'account_login';
}

abstract class SkillBuddyEvent {
  String? get googleToken;
  BranchStandardEvent? get branchStandardToken;
  String? get branchCustomEvent;

  bool get isAutoTrackedByGoogle;

  Map<String, Object> getParameters();
}
