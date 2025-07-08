import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';

import 'skillbuddy_event.dart';

class AccountLoginEvent implements SkillBuddyEvent {
  AccountLoginEvent(
    this.userId,
    this.username,
    this.userEmail,
    this.userAuthenticationMethod,
  );

  final String userId;
  final String username;
  final String userEmail;
  final String userAuthenticationMethod;

  @override
  String get googleToken => GoogleEventToken.accountLogin;

  @override
  BranchStandardEvent? get branchStandardToken => BranchStandardEvent.LOGIN;

  @override
  String? get branchCustomEvent => null;

  @override
  bool get isAutoTrackedByGoogle => false;

  @override
  Map<String, Object> getParameters() {
    return <String, Object>{
      EventParameterId.userId: userId,
      EventParameterId.username: username,
      EventParameterId.userEmail: userEmail,
      EventParameterId.userAuthenticationMethod: userAuthenticationMethod,
    };
  }
}
